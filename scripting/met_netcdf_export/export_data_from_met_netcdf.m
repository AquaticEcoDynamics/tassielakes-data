clear all; close all;

addpath(genpath('../../aed-marvl/'));

infile = '../../../woods_model_tfvaed_0.1/bc_repo/1_weather/CFSR/CFSR_20230101_20240501.nc';
outfile = '../../../woods_model_tfvaed_0.1/bc_repo/1_weather/CFSR/CFSR_20230101_20240501.csv';

lat = -42.077774;
lon = 146.995467;

data = tfv_readnetcdf(infile);

mdate = double(datenum(1990,01,01) + (double(data.time)/24));

[~,ind] = min(abs(data.longitude - lon));
[~,ind1] = min(abs(data.latitude - lat));



fid = fopen(outfile,'wt');
fprintf(fid,'ISOTime,SolRad,LW_Inc\n');

for i = 1:length(mdate)
    fprintf(fid,'%s,%4.4f,%4.4f\n',datestr(mdate(i),'dd/mm/yyyy HH:MM:SS'),data.downward_shortwave(ind,ind1,i),data.downward_longwave(ind,ind1,i));
end
fclose(fid);