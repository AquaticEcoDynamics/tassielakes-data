clear all; close all;
load('D:\csiem\data-warehouse/mat/cockburn.mat');

sites = fieldnames(cockburn);

for i = 1:length(sites)
    
    vars = fieldnames(cockburn.(sites{i}));
    
    S(i).Name = sites{i};
    S(i).X = cockburn.(sites{i}).(vars{1}).Lon;
    S(i).Y = cockburn.(sites{i}).(vars{1}).Lat;
    S(i).Geometry = 'Point';
    
end
shapewrite(S,'Sites.shp');
    

