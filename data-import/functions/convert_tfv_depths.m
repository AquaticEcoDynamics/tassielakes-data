clear all; close all;

load('D:\csiem\data-warehouse/mat/cockburn.mat');

cockburn_test = cockburn;clear cockburn;

sites = fieldnames(cockburn_test);

for i = 1:length(sites)
    disp(num2str(i));
    vars = fieldnames(cockburn_test.(sites{i}));
    for j = 1:length(vars)
        thedata = [];
        switch cockburn_test.(sites{i}).(vars{j}).Deployment
        
            case 'Integrated'
                cockburn_test.(sites{i}).(vars{j}).mDepth = cockburn_test.(sites{i}).(vars{j}).Depth;
            case 'Fixed'
                
                if isfield(cockburn_test.(sites{i}).(vars{j}),'Height')
                    for k = 1:length(cockburn_test.(sites{i}).(vars{j}).Height)
                        thedata(k,1) = str2double(cockburn_test.(sites{i}).(vars{j}).Height{k});
                    end
                    cockburn_test.(sites{i}).(vars{j}).mDepth = (str2double(cockburn_test.(sites{i}).(vars{j}).calc_SMD) - thedata) .* -1;
                    
                    
                else
                
                    for k = 1:length(cockburn_test.(sites{i}).(vars{j}).Depth)
                        cockburn_test.(sites{i}).(vars{j}).mDepth(k,1) = str2double(cockburn_test.(sites{i}).(vars{j}).Depth{k}) * -1;
                    end                    
                    
                    
                end
                case 'Floating'
                if isfield(cockburn_test.(sites{i}).(vars{j}),'Height')
                    for k = 1:length(cockburn_test.(sites{i}).(vars{j}).Height)
                        thedata(k,1) = str2double(cockburn_test.(sites{i}).(vars{j}).Height{k});
                    end
                    
                    
                    
                    cockburn_test.(sites{i}).(vars{j}).mDepth = (thedata) .* -1;
                    
                    
                else
                
                    for k = 1:length(cockburn_test.(sites{i}).(vars{j}).Depth)
                        cockburn_test.(sites{i}).(vars{j}).mDepth(k,1) = str2double(cockburn_test.(sites{i}).(vars{j}).Depth{k}) * -1;
                    end                    
                    
                    
                end                         
                    
            case 'Profile'
                    for k = 1:length(cockburn_test.(sites{i}).(vars{j}).Depth)
                        cockburn_test.(sites{i}).(vars{j}).mDepth(k,1) = str2double(cockburn_test.(sites{i}).(vars{j}).Depth{k}) * -1;
                    end            
            otherwise
                
                
                stop
        end
    end
end

sites = fieldnames(cockburn_test);

for i = 1:length(sites)
    disp(num2str(i));
    vars = fieldnames(cockburn_test.(sites{i}));
    for j = 1:length(vars)
        if isfield(cockburn_test.(sites{i}).(vars{j}),'Depth')
            cockburn_test.(sites{i}).(vars{j}).O_Depth = cockburn_test.(sites{i}).(vars{j}).Depth;
            cockburn_test.(sites{i}).(vars{j}) = rmfield(cockburn_test.(sites{i}).(vars{j}),'Depth');
            cockburn_test.(sites{i}).(vars{j}).Depth = cockburn_test.(sites{i}).(vars{j}).mDepth;
        end
        if isfield(cockburn_test.(sites{i}).(vars{j}),'Height')
            cockburn_test.(sites{i}).(vars{j}).Depth = cockburn_test.(sites{i}).(vars{j}).mDepth;
        end
    end
end
        



save('D:\csiem\data-warehouse/mat/cockburn_test.mat','cockburn_test','-mat','-v7.3');               