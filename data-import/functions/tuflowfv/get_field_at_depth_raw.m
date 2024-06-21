function [xdata,ydata,ydata_max,ydata_min] = get_field_at_depth_raw(mDate,mData,mDepth,level)

xdata = [];
ydata_max = [];
ydata_min = [];
ydata = [];

inc = 1;

if strcmpi(level,'surface')
    maxdepth = max(mDepth);
    
    sss = find(mDepth > (maxdepth-1));
    
    if ~isempty(sss)
        
        mDate_b = mDate(sss);
        mData_b = mData(sss);
        mDepth_b = mDepth(sss);
        
        xdata = mDate_b;
        ydata = mData_b;
        ydata_min = [];
        ydata_max = [];
        
        %         fdate = floor(mDate_b);
        %
        %         udate = unique(fdate);
        %
        %         for j = 1:length(udate)
        %             if ~isnan(udate(j))
        %                 sss2 = find(fdate == udate(j));
        %
        %                 [~,tt] = max(mDepth_b(sss2));
        %
        %                 ggg = find(mDepth_b(sss2) == mDepth_b(sss2(tt(1))));
        %
        %                 if length(ggg) > 3
        %
        %                     xdata(inc,1) = mean(mDate_b(sss2(ggg)));
        %
        %                     ydata_max(inc,1) = max(mData_b(sss2(ggg)));
        %                     ydata_min(inc,1) = min(mData_b(sss2(ggg)));
        %                     ydata(inc,1) = mean(mData_b(sss2(ggg)));
        %
        %                 else
        %                     xdata(inc,1) = mDate_b(sss2(tt(1)));
        %                     ydata_max(inc,1) = mDate_b(sss2(tt(1)));
        %                     ydata_min(inc,1) = mDate_b(sss2(tt(1)));
        %
        %
        %                     ydata(inc,1) = mData_b(sss2(tt(1)));
        %                 end
        %
        %                 inc = inc + 1;
        %             end
        %         end
    end
    
else
    mindepth = min(mDepth);
    
    if mindepth < -5
        mindepth = mindepth + 3;
    else
        mindepth = mindepth + 1;
    end
    sss = find(mDepth < (mindepth));
    
    if ~isempty(sss)
        
        mDate_b = mDate(sss);
        mData_b = mData(sss);
        mDepth_b = mDepth(sss);
        
        xdata = mDate_b;
        ydata = mData_b;
        ydata_min = [];
        ydata_max = [];
        
        
        %         fdate = floor(mDate_b);
        %
        %         udate = unique(fdate);
        %
        %         for j = 1:length(udate)
        %             if ~isnan(udate(j))
        %                 sss2 = find(fdate == udate(j));
        %
        %                 [~,tt] = min(mDepth_b(sss2));
        %
        %                 xdata(inc,1) = mDate_b(sss2(tt(1)));
        %                 ydata(inc,1) = mData_b(sss2(tt(1)));
        %                 ydata_max(inc,1) = mDate_b(sss2(tt(1)));
        %                 ydata_min(inc,1) = mDate_b(sss2(tt(1)));
        %
        %
        %                 inc = inc + 1;
        %             end
        %         end
    end
end

