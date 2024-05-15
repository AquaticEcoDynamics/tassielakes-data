clear all; close all;

load metdata.mat;

outdir = 'Met Data Export 2/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

sites = fieldnames(metdata);

for i = 1:length(sites)
    fid = fopen([outdir,sites{i},'.csv'],'wt');
    fprintf(fid,'Date,Air Temperature\n');
    
    mdate = metdata.(sites{i}).Date;
    mdata = metdata.(sites{i}).AirTemperature;
    
    for j = 1:length(mdate)
        fprintf(fid,'%s,%4.4f\n',datestr(mdate(j),'dd/mm/yyyy HH:MM:SS'),mdata(j));
    end
    fclose(fid);
end
