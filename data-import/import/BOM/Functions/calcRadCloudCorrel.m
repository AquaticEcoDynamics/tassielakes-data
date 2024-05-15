function calcRadCloudCorrel(site1,site2)

% Actual, On Ground Solar Data from Ellenbrook

date1 = datenum(2010,06,01,00,00,00);
date2 = datenum(2011,06,30,00,00,00);

mm = find(sol.Date >= date1 & sol.Date <= date2);
met.Rad_Actual = sol.Solar_Rad(mm);

% Finding correlation between TC and Actual Ground Data
