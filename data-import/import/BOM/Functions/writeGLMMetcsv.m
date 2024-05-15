function writeGLMMetcsv(startdate,enddate,TZ,site)

% Creates GLMMetcsv files using BoM data.
% Ensure that the data extraction scripts have been used and the .mat file
% exist in the relevant path folder. All calculations are hourly.
% "remove_nans" is used to remove any nans in the data.

% startdate = datenum(2002,01,01,09,00,00);
% enddate = datenum(2013,12,31,09,00,00);
% TZ = 9.5;
% site = 'liawenee';

load metdata.mat;

met = metdata.(site);

tt = find(met.Date >= startdate & met.Date <= enddate);

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

met.WIND = (remove_nans(met.WindSpeed(tt),1))/3.6;
met.DIRN = remove_nans(met.WindDir(tt),1);

% met.Wx = (round(-1.0.*(met.WIND).*sin((pi/180).*met.DIRN)*1000000)/1000000)/3.6;
% met.Wy = (round(-1.0.*(met.WIND).*cos((pi/180).*met.DIRN)*1000000)/1000000)/3.6;

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
met.NewDate = NewDate';

% Rain

met.RAIN_cum = met.Rain_9am(tt);
nn = 1;
    while  nn > 0.5
        nn = find (isnan(met.RAIN_cum));
        met.RAIN_cum(nn) = met.RAIN_cum(nn-1);
    end

% met.Date_vec = datevec(met.Date_1);
% nn = find(met.Date_1 == datenum(met.Date_vec(1:end,1),met.Date_vec(1:end,2),met.Date_vec(1:end,3),09,00,00));


all_days = unique(floor(met.Date_1));
inc = 1;
met.RAIN_inc = [];
for i = 1:length(all_days)
    ss = find(floor(met.Date_1) == all_days(i));
    %     if isempty(ss)
    
    dump_time = round(0.3333*1000) / 1000;
    fix_time = round((21/24)*1000) / 1000;
    for j = 1:length(ss)
        
        actual_time = round((met.Date_1(ss(j)) - floor(met.Date_1(ss(j))))*1000)/1000;
        if ss(j) == 1
            met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j));
        else
            if dump_time == actual_time
                
                met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j));
                
            else
                if fix_time == actual_time % Not changing the calculation but the actual data in the mat file
                    met.RAIN_cum(ss(j)) = met.RAIN_cum(ss(j-1));
                end
                if j == 1
                    met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j)) - met.RAIN_cum(ss(j)-1);
                else
                    met.RAIN_inc(inc,1) = met.RAIN_cum(ss(j)) - met.RAIN_cum(ss(j-1));
                end
            end
        end
        inc = inc + 1;
    end
    %     end
end

for i = 2:length(met.RAIN_inc)-1
    if met.RAIN_inc(i) == 0 & met.RAIN_inc(i-1) == (-1*(met.RAIN_inc(i+1)))
        met.RAIN_inc(i+1) = met.RAIN_inc(i);
        met.RAIN_inc(i-1) = met.RAIN_inc(i);
    elseif met.RAIN_inc(i) ~= 0 & met.RAIN_inc(i) == (-1*(met.RAIN_inc(i+1)))
        met.RAIN_inc(i) = 0;
        met.RAIN_inc(i+1) = 0;
    elseif met.RAIN_inc(i) < 0 & met.RAIN_cum(i) == 0
        met.RAIN_inc(i) = 0;
    elseif met.RAIN_inc(i) == met.RAIN_cum(i) & met.RAIN_inc(i+2) < 0
        met.RAIN_inc(i) = met.RAIN_cum(i) - met.RAIN_cum(i-1);
        met.RAIN_inc(i+1) = met.RAIN_cum(i+1) - met.RAIN_cum(i);
        met.RAIN_inc(i+2) = met.RAIN_cum(i+2);
    elseif met.RAIN_inc(i) == met.RAIN_cum(i) & met.RAIN_inc(i+1) < 0
        met.RAIN_inc(i) = met.RAIN_cum(i) - met.RAIN_cum(i-1);
        met.RAIN_inc(i+1) = met.RAIN_cum(i+1);
    elseif met.RAIN_inc(i) < 0
        met.RAIN_inc(i) = 0;
    end

end


met.RAIN = ((met.RAIN_inc)/1000)*24;


% Interpolating to get data in same dimensions

met.TC_interp = interp1(met.Date_1,met.TC(tt),met.NewDate);
met.Wind_interp = interp1(met.Date_1,met.WIND,met.NewDate);
%met.Wy_interp = interp1(met.Date_1,met.Wy,met.NewDate);
met.RH_interp = interp1(met.Date_1,met.RH,met.NewDate);
met.Temp_interp = interp1(met.Date_1,met.Temp,met.NewDate);
met.Rain_interp = interp1(met.Date_1,met.RAIN,met.NewDate);

% In case cloud data is not there

mm = find(met.TC_interp == 0);

if length(mm) >= (0.85 * length(met.TC_interp))
    [TC_interp] = calcCloudCover(startdate,enddate,TZ,site);
    met.TC_interp = TC_interp;
else
    met.TC_interp = met.TC_interp;
end

% Calculate the model data based on the model correlation

for i = 1:length(met.TC_interp)
    
    if met.TC_interp(i) >= 0.02
        met.Rad_Model(i) = (0.66182* power(met.TC_interp(i),2) - 1.5236*met.TC_interp(i) + 0.98475) * met.GHI(i);
    else
        met.Rad_Model(i) = met.GHI(i);
    end
end

% Make the file

formatout = 'yyyy-mm-dd HH:MM:SS';
Iso_Time = datestr(met.NewDate,formatout);

filename = strcat('glm_met_', site, '.csv');

fid = fopen(filename,'wt');
fprintf(fid,'time,ShortWave,AirTemp,RelHum,WindSpeed,Rain,Cloud \n');

for ii = 1:length(GHI)
    fprintf(fid,'%s,%f,%f,%f,%f,%f,%f \n',...
        datestr(met.NewDate(ii),formatout),...
        met.Rad_Model(ii),...
        met.Temp_interp(ii),...
        met.RH_interp(ii),...
        met.Wind_interp(ii),...
        met.Rain_interp(ii),...
        met.TC_interp(ii));
end
fclose(fid);

metdata.(site) = met;

save metdata.mat -metdata -append -mat -v7