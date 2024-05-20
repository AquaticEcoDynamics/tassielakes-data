clear all; close all;

filename = 'v4.csv';

[~,headers] = xlsread(filename,'A1:Z1');

[snum,sstr] = xlsread(filename,'A2:Z1000');

inc = 1;

for i = 1:length(sstr)
    if ~isempty(sstr{i})
        S(inc).X = snum(i,1);
        S(inc).Y = snum(i,2);
        S(inc).Name = sstr{i};
        S(inc).Depth = snum(i,3);
        S(inc).CHARO = snum(i,4);
        S(inc).Geometry = 'Point';
    inc = inc + 1;
    end
end
shapewrite(S,'CHARO_pnts.shp');
    
        



