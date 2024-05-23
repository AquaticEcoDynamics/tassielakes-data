function [data,c_units,isConv] = tfv_getmodelpolylinedata_stacked(rawData,filename,X,Y,shp,varname,timebin,isSurf,isSpherical)

rawGeo = tfv_readnetcdf(filename,'timestep',1);
mtime = tfv_readnetcdf(filename,'time',1);


[rawData.(varname{1}),c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1}),varname{1});

%disp(['The units ',c_units]);

for i = 1:length(shp)
    sdata(i,1) = shp(i).X;
    sdata(i,2) = shp(i).Y;
end

dist(1,1) = 0;

for i = 2:length(shp)
    
    dist(i,1) = sqrt(power((sdata(i,1) - sdata(i-1,1)),2) + power((sdata(i,2)- sdata(i-1,2)),2)) + dist(i-1,1);
    
end

if isSpherical
    dist = dist * 111111;
end

dist = dist / 1000; % convert to km


dtri = DelaunayTri(double(X),double(Y));

query_points(:,1) = sdata(~isnan(sdata(:,1)),1);
query_points(:,2) = sdata(~isnan(sdata(:,2)),2);

pt_id = nearestNeighbor(dtri,query_points);

for i = 1:length(pt_id)
    Cell_3D_IDs = find(rawGeo.idx2==pt_id(i));
    surfIndex(i) = min(Cell_3D_IDs);
    botIndex(i) = max(Cell_3D_IDs);
end

thetime = find(mtime.Time >= timebin(1) & ...
    mtime.Time < timebin(end));


thetime(end)

if isSurf
    uData =  rawData.(varname{1})(surfIndex,thetime);
else
    uData =  rawData.(varname{1})(botIndex,thetime);
end

pred_lims = [0.05,0.25,0.5,0.75,0.95];
num_lims = length(pred_lims);
nn = (num_lims+1)/2;
[ix,~] = size(uData);


inc = 1;
for i = 1:ix
    xd = uData(i,:);
    if sum(isnan(xd)) < length(xd)
        xd(isnan(xd)) = mean(xd(~isnan(xd)));
        data.pred_lim_ts(:,inc) = plims(xd,pred_lims)';
        data.dist(inc,1) = dist(i);
        inc = inc + 1;
    end
end