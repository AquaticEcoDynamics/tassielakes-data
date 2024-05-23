function outdata = calc_data_ranges(data,X,Y,fieldprctile,varname)


sites = fieldnames(data);

mDate = [];
mData = [];

for i = 1:length(sites)
    
    if isfield(data.(sites{i}),varname)
        
        if inpolygon(data.(sites{i}).(varname).X,data.(sites{i}).(varname).Y,X,Y)
            
            mDate = [mDate;data.(sites{i}).(varname).Date];
            mData = [mData;data.(sites{i}).(varname).Data];
        end
    end
end



% Create a mega monthly array

datearray = datenum(1990,[01:01:480],15);

outdata.Date = datearray;
outdata.low(1:length(datearray),1) = NaN;
outdata.high(1:length(datearray),1) = NaN;

if ~isempty(mData)

    [mData,~,~] = tfv_Unit_Conversion(mData,varname);
    dv = datevec(datearray);
    dvf = datevec(mDate);
    
    for i = 1:12
        
        sss = find(dvf(:,2) == i);
        
        if ~isempty(sss)
            
            P = prctile(mData(sss),fieldprctile);
            
            tt = find(dv(:,2) == i);
            
            outdata.low(tt) = P(1);
            outdata.high(tt) = P(2);
        
            
        end
    end
end