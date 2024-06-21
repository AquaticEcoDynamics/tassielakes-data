clear all; close all;

load('D:\csiem\data-warehouse/mat/cockburn.mat');

sites = fieldnames(cockburn);

for i = 1:length(sites)
    vars = fieldnames(cockburn.(sites{i}));
    for j = 1:length(vars)
        sss = find(isnan(cockburn.(sites{i}).(vars{j}).Depth) == 1);
        cockburn.(sites{i}).(vars{j}).Depth(sss) = -1;
    end
end


sites = fieldnames(cockburn);

for i = 1:length(sites)
    vars = fieldnames(cockburn.(sites{i}));
    if isfield(cockburn.(sites{i}),'COND') & ~isfield(cockburn.(sites{i}),'SAL') & isfield(cockburn.(sites{i}),'TEMP')
        cockburn.(sites{i}).SAL = cockburn.(sites{i}).COND;
        disp(['Converting ',sites{i},' Salinity']);
        for bfg = 1:length(cockburn.(sites{i}).SAL.Data)
            sss = find(cockburn.(sites{i}).TEMP.Date == cockburn.(sites{i}).SAL.Date(bfg) & ...
                cockburn.(sites{i}).TEMP.Depth == cockburn.(sites{i}).SAL.Depth(bfg));
            if ~isempty(sss)
                disp('Real Temp');
                cockburn.(sites{i}).SAL.Data(bfg) = cond2sal(cockburn.(sites{i}).COND.Data(bfg),cockburn.(sites{i}).TEMP.Data(sss));
            else
                
                [~,ind] = min(abs(cockburn.(sites{i}).TEMP.Date - cockburn.(sites{i}).SAL.Date(bfg)));
                
                cockburn.(sites{i}).SAL.Data(bfg) = cond2sal(cockburn.(sites{i}).COND.Data(bfg),cockburn.(sites{i}).TEMP.Data(ind(1)));
                
                disp('Time check');
%                 
%                 
%                 disp('Fake Temp');
%                 stop
%                 cockburn.(sites{i}).SAL.Data(bfg) = cond2sal(cockburn.(sites{i}).COND.Data(bfg),25);
            end
            
        end
                
        cockburn.(sites{i}).SAL.Variable_name = 'Salinity';
        cockburn.(sites{i}).SAL.Units = {'psu'};
        
    end
    
end

save('D:\csiem\data-warehouse/mat/cockburn.mat','cockburn','-mat','-v7.3');