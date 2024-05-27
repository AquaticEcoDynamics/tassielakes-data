function import_write_rainfall(filename,outfile,sdate,edate)

fid = fopen(filename,'rt');
x  = 8;
textformat = [repmat('%s ',1,x)];
datacell = textscan(fid,textformat,...
    'Headerlines',1,...
    'Delimiter',',');
fclose(fid);

mdate = datenum(str2double(datacell{3}),str2double(datacell{4}),str2double(datacell{5}));
mrain = str2double(datacell{6}) ./ 1000;

sss = find(mdate >= sdate & mdate <= edate);

daily_date = mdate(sss);
daily_rain = mrain(sss);

daily_rain(isnan(daily_rain)) = 0;
fid = fopen(outfile,'wt');
fprintf(fid,'ISOTime,Precip \n');

for ii = 1:length(daily_date)
    fprintf(fid,'%s,%f \n',...
        datestr(daily_date(ii),'dd/mm/yyyy'),...
        daily_rain(ii));
end
fclose(fid);

