function data = import_datafile(filename)

%[~,headers] = xlsread(filename,'A1:D1');

fid = fopen(filename,'rt');

fline = fgetl(fid);
headers = split(fline,',');

frewind(fid);



x  = 5;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values

datacell = textscan(fid,textformat,'Headerlines',1,'Delimiter',',');
fclose(fid);
%datacell{2}
mDate = datenum(datacell{2},'yyyy-mm-dd HH:MM:SS');
%mDate = datenum(datacell{2},'dd/mm/yyyy HH:MM');
%data.Date =  datetime(datacell{1},'InputFormat','yyyy-mm-dd HH:MM:SS');
%mData = str2double(datacell{4});
mData = str2double(datacell{4});
mQC = datacell{5};
if strcmpi(headers{3},'Depth')
    mDepth = datacell{3};
else
    mHeight = datacell{3};
end

[data.Date,ind] = sort(mDate);
data.Data = mData(ind);
data.QC = mQC(ind);
if strcmpi(headers{3},'Depth')
    data.Depth = mDepth(ind) ;
else
    data.Height = mHeight(ind);
end



% tdepth = datacell{2};

% for i = 1:length(tdepth)
%     xval = tdepth{i};
%     spt = split(xval,'-');
%     
%     if length(spt) > 1
%         
%         depth1(i,1) = str2double(spt{1});
%         depth2(i,1) = str2double(spt{2});
%         
%         try
%             depth(i,1) = (depth1(i,1) + depth2(i,1)) /2;
%         catch
%             depth1(i,1)
%             depth2(i,1)
%             stop
%         end
%         %         if (depth2(i,1) - depth(i,1)) < 0.3
%         %             data.QC(i) = {'Possible PoreWater'};
%         %
%         %         end
%         
%         
%     else
%         depth1(i,1) = NaN;
%         depth2(i,1) = NaN;
%         depth(i,1) = str2double(spt{1});
%     end
% end

% data.Depth = depth;
% data.Depth_T = depth1;
% data.Depth_B = depth2;
% 
% sss = find(~isnan(depth2) == 1);
% if ~isempty(sss)
%     data.Date = [data.Date;data.Date(sss)];
%     data.Depth = [data.Depth;depth2(sss)];
%     data.Data = [data.Data;data.Data(sss)];
%     data.QC = [data.QC;data.QC(sss)];
% end
end