% fid = fopen('check_rain.csv','wt');
%
% for i = 1:length(met.Date_1)
%     fprintf(fid,'%s,%7.7f,%7.7f\n',datestr(met.Date_1(i)),met.RAIN_cum(i),met.RAIN_inc(i));
% end
% fclose(fid);

% load metdata_old.mat;
%
% met = metdata;
%
% clear metdata;
%
% load metdata.mat;
%
% sites = fieldnames(metdata);
% for i = 1:length(sites);
%
%     if strcmpi(sites{i},'airport') == 0
%
%     metdata.(sites{i}).Date = datenum(metdata.(sites{i}).Year,...
%         metdata.(sites{i}).Month,...
%         metdata.(sites{i}).Day,...
%         metdata.(sites{i}).Hours,0,0);
%     end
% end
%
%
% metdata.airport = met.airport;
% metdata.jandakot = met.jandakot;
%
% save metdata.mat metdata -mat;

clear all; close all;


load metdata.mat;

hvars = fieldnames(metdata.Halls_Head);
movars = fieldnames(metdata.mandurah_old);
mnvars = fieldnames(metdata.mandurah_new);


mo_sd = min(metdata.mandurah_old.Date);
mn_sd = min(metdata.mandurah_new.Date);


metdata.mandurah_combined = [];


sss = find(metdata.Halls_Head.Date < mo_sd);


for i = 1:length(hvars)
    if strcmpi(hvars{i},'lat')==0 & strcmpi(hvars{i},'lon')==0
        metdata.mandurah_combined.(hvars{i}) = metdata.Halls_Head.(hvars{i})(sss);
    end
    
end

sss = find(metdata.mandurah_old.Date < mn_sd);

for i = 1:length(movars)
    if strcmpi(movars{i},'lat')==0 & strcmpi(movars{i},'lon')==0
        
        if isfield(metdata.mandurah_combined,movars{i})
            metdata.mandurah_combined.(movars{i}) = [metdata.mandurah_combined.(movars{i});metdata.mandurah_old.(movars{i})(sss)];
        else
            metdata.mandurah_combined.(movars{i}) = metdata.mandurah_old.(movars{i})(sss);
        end
    end
end

for i = 1:length(mnvars)
    if strcmpi(mnvars{i},'lat')==0 & strcmpi(mnvars{i},'lon')==0
        
        if isfield(metdata.mandurah_combined,mnvars{i})
            metdata.mandurah_combined.(mnvars{i}) = [metdata.mandurah_combined.(mnvars{i});metdata.mandurah_new.(mnvars{i})];
        else
            metdata.mandurah_combined.(mnvars{i}) = metdata.mandurah_old.(mnvars{i});
        end
    end
end


metdata.mandurah_combined.WindSpeed(isnan(metdata.mandurah_combined.WindSpeed)) = 0;

metdata.mandurah_combined.WindDir(isnan(metdata.mandurah_combined.WindDir)) = 0;



metdata.mandurah_combined.lat = metdata.mandurah_new.lat;
metdata.mandurah_combined.lon = metdata.mandurah_new.lon;

save metdata.mat metdata -mat;









