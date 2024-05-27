function writeTFVMetcsv(startdate,enddate,TZ,site,varargin)

% Creates TFVMetcsv files for a pair of BoM sites
% Ensure that the data extraction scripts have been used and the .mat files
% exist in the relevant path folder. All calculations are hourly.
% "remove_nans" is used to remove any nans in the data. Typical input -
% startdate = datenum(2001,01,01,09,00,00);
% enddate = datenum(2002,01,01,09,00,00);
% site = 'airport';
% TZ = 7.5;
% IMPORTANT - Comment out the file writing part to just generate the plots.

if length(varargin) == 0
    disp('Using data from one site');
end

if length(varargin) == 1
    disp('To add data from another site you need to include the site name, and the variables');
end




if length(varargin) == 2
    disp(['Replacing data from ',site,' with ',varargin{1}]);
    
    
    load metdata.mat;
    
    met = metdata.(site);
    

    
    
    
    
    
    tt = find(met.Date >= startdate & met.Date <= enddate);
    
    newmet = metdata.(varargin{1});
    
    newdate = newmet.Date;
    
    switch varargin{2}
        case 'Clouds'
            met.CloudAmount_First = [];
            met.CloudAmount_First = interp1(newdate,newmet.CloudAmount_First,met.Date,'linear','extrap');
            met.CloudAmount_Second = [];
            met.CloudAmount_Second = interp1(newdate,newmet.CloudAmount_Second,met.Date,'linear','extrap');
            met.CloudAmount_Third = [];
            met.CloudAmount_Third = interp1(newdate,newmet.CloudAmount_Third,met.Date,'linear','extrap');
        case 'Temperature'
            met.AirTemperature = [];
            met.AirTemperature = interp1(newdate,newmet.AirTemperature,met.Date,'linear','extrap');
        case 'Wind'
            met.WindSpeed = [];
            met.WindDir = [];
            
            met.WindSpeed = interp1(newdate,newmet.WindSpeed,met.Date,'linear','extrap');
            met.WindDir = interp1(newdate,newmet.WindDir,met.Date,'linear','extrap');
        case 'RH'
            met.RelativeHumidity = [];
            met.RelativeHumidity = interp1(newdate,newmet.RelativeHumidity,met.Date,'linear','extrap');
        otherwise
            disp('Variable unknown');
    end
else
    
    load metdata.mat;
    
    met = metdata.(site);
    

    
    
    
    
    
    tt = find(met.Date >= startdate & met.Date <= enddate);
    
end



% Calculating Clouds

Cloud_1 = met.CloudAmount_First/8.0;
nn = find (isnan(Cloud_1));
Cloud_1(nn) = 0;

Cloud_2 = met.CloudAmount_Second/8.0;
nn = find (isnan(Cloud_2));
Cloud_2(nn) = 0.;

Cloud_3 = met.CloudAmount_Third/8.0;
nn = find (isnan(Cloud_3));
Cloud_3(nn) = 0.;

met.TC = (Cloud_1 + Cloud_2 + Cloud_3)/3.0;

% Calculating Wind

met.WIND = remove_nans(met.WindSpeed(tt),1);
met.DIRN = remove_nans(met.WindDir(tt),1);

met.Wx = (round(-1.0.*(met.WIND).*sin((pi/180).*met.DIRN)*1000000)/1000000)/3.6;
met.Wy = (round(-1.0.*(met.WIND).*cos((pi/180).*met.DIRN)*1000000)/1000000)/3.6;

% Relative Humidity

met.RH = remove_nans(met.RelativeHumidity(tt),1);

% Temperature

met.Temp = remove_nans(met.AirTemperature(tt),1);


% Get Bird Model Data

lat = met.lat;
lon = met.lon;
[GHI ZenithAngle NewDate] = genBirdSolarData(lat,lon,startdate,enddate,TZ);
met.GHI = GHI;

% Dates

met.Date_1 = met.Date(tt);
met.NewDate = NewDate;

% Rain

met.Date_vec = datevec(met.Date_1);
nn = find(met.Date_1 == datenum(met.Date_vec(1:end,1),met.Date_vec(1:end,2),met.Date_vec(1:end,3),09,00,00));

%met.Rain = (remove_nans(met.Rain_9am(tt(nn)),1))/1000;
met.Rain = met.Rain_9am ./1000;
met.Date_daily = [startdate:1:enddate];
met.Rain(isnan(met.Rain)) = 0;

for iii = 1:length(met.Date_daily)
    ttt = find(floor(met.Date) == met.Date_daily(iii));
    if ~isempty(ttt)
        met.Rain_interp(iii) = sum(met.Rain(ttt));
    else
        met.Rain_interp(iii) = 0;
    end
end

%met.Rain_interp = interp1(met.Date_1(nn),met.Rain,met.Date_daily);
nn = find (isnan(met.Rain_interp));
met.Rain_interp(nn) = 0;

% Interpolating to get data in same dimensions

met.TC_interp = interp1(met.Date_1,met.TC(tt),met.NewDate);
met.Wx_interp = interp1(met.Date_1,met.Wx,met.NewDate);
met.Wy_interp = interp1(met.Date_1,met.Wy,met.NewDate);
met.RH_interp = interp1(met.Date_1,met.RH,met.NewDate);
met.Temp_interp = interp1(met.Date_1,met.Temp,met.NewDate);


for i = 1:length(met.Rain_interp)
    
    if met.Rain_interp(i) < 0
        met.Rain_interp(i) = 0;
    end
end

% Calculate the model data based on the model correlation

for i = 1:length(met.TC_interp)
    
    if met.TC_interp(i) >= 0.02
        met.Rad_Model(i) = (0.66182* power(met.TC_interp(i),2) - 1.5236*met.TC_interp(i) + 0.98475) * met.GHI(i);
    else
        met.Rad_Model(i) = met.GHI(i);
    end
end



% Create Directory
dirname = [site,' met output/'];

if ~exist(dirname,'dir')
    mkdir(dirname);
end


% Make the file

formatout = 'dd/mm/yyyy HH:MM:SS';
Iso_Time = datestr(met.NewDate,formatout);

filename = [dirname,strcat('tfv_met_', site, '.csv')];

fid = fopen(filename,'wt');
fprintf(fid,'ISOTime,Wx,Wy,Atemp,Rel_Hum,Sol_Rad,Clouds \n');

for ii = 1:length(GHI)
    fprintf(fid,'%s,%f,%f,%f,%f,%f,%f \n',...
        datestr(met.NewDate(ii),formatout),...
        met.Wx_interp(ii),...
        met.Wy_interp(ii),...
        met.Temp_interp(ii),...
        met.RH_interp(ii),...
        met.Rad_Model(ii),...
        met.TC_interp(ii));
end
fclose(fid);

filename = [dirname,strcat('tfv_rain_', site, '.csv')];

% fid = fopen(filename,'wt');
% fprintf(fid,'ISOTime,Precip \n');
% 
% for ii = 1:length(met.Rain_interp)
%     fprintf(fid,'%s,%f \n',...
%         datestr(met.Date_daily(ii),formatout),...
%         met.Rain_interp(ii));
% end
% fclose(fid);

% Create the summary plots

startyear = datevec(startdate);
endyear = datevec(enddate);

YEARS = endyear(1,1) - startyear(1,1);

for i = 0:YEARS-1
    firstdate = datenum(startyear(1,1)+i,startyear(1,2),startyear(1,3),startyear(1,4),startyear(1,5),startyear(1,6));
    lastdate = datenum(startyear(1,1)+i+1,startyear(1,2),startyear(1,3),startyear(1,4),startyear(1,5),startyear(1,6));
    cc = find(met.Date_daily >= firstdate & met.Date_daily <= lastdate);
    met.Date_daily_vec = datevec(met.Date_daily(cc));
    Unique_month = unique(met.Date_daily_vec(1:end,2));
    for j = 1:length(Unique_month)
        dd = find(met.Date_daily_vec(1:end,2) == Unique_month(j));
        met.Rain_monthly(j) = sum(met.Rain_interp(cc(dd)));
    end
    
    %axes_plot
end

