
function [TC_interp] = calcCloudCover(startdate,enddate,TZ,site)

% Function to calculate cloud cover from daily solar exposure data
% available on BoM website.
% startdate = datenum(2002,01,01,09,00,00);
% enddate = datenum(2013,12,31,09,00,00);
% TZ = 9.5;
% site = 'liawenee';

load solardata.mat
load metdata.mat

sol = solardata.(site);
met = metdata.(site);

ss = find(sol.Date >= startdate & sol.Date <= enddate);
tt = find(met.Date >= startdate & met.Date <= enddate);

sol.RAD = (remove_nans(sol.Solar_Rad(ss),1))/3.6;
nn = find(sol.RAD < 0.01);
sol.RAD(nn) = 0.1503;

% Run Bird Model and get number of Day Light Hours for each day

lat = met.lat;
lon = met.lon;
[GHI ZenithAngle NewDate] = genBirdSolarData(lat,lon,startdate,enddate,TZ);

nn = find(ZenithAngle <= 90);

k = floor(NewDate(nn));

xx = unique(floor(NewDate(nn)));

for i = 1:length(xx)
    rr = find(xx(i) == k);
    SunShineHours(i) = length(rr);
    GHI_avg(i) = mean(GHI(nn(rr)));
end

SunShineHours = interp1(xx,SunShineHours,sol.Date(ss));
nn = find(isnan(SunShineHours));
SunShineHours(nn) = SunShineHours(nn-1);

GHI_avg = interp1(xx,GHI_avg,sol.Date(ss));
nn = find(isnan(GHI_avg));
GHI_avg(nn) = GHI_avg(nn-1);

% Conversion of Daily Solar Data into the right units

sol.Radiation = ((sol.RAD)./(SunShineHours)).*1000;

% Get corresponding average TC for each Radiation value. Solving the 
% quadratic.

Cloud_Frac = (sol.Radiation./GHI_avg);
mm = find(Cloud_Frac > 0.93);
Cloud_Frac(mm) = 0.93;

mm = find(Cloud_Frac < 0.15);
Cloud_Frac(mm) = 0.15;

for i = 1:length(Cloud_Frac)

    a = 0.66182;
    b = -1.5236;
    c(i) = 0.98475 - Cloud_Frac(i);

    d(i) = sqrt(power(b,2) - 4*a*c(i));
   Daily_Cloud(i) = ( -b - d(i) ) / (2*a);

end

% Interp to get Hourly Cloud

TC_interp = interp1(sol.Date(ss),Daily_Cloud,NewDate);
nn = find(isnan(TC_interp));
TC_interp(nn) = min(TC_interp);


    



