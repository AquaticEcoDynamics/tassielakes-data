function getBoMSolarExposuredata(filename)

fid = fopen(filename,'rt');
cHeader = { ...
        'Product_Code';...
        'StationID';...
        'Year';...
        'Month';...
        'Day';...
        'Solar_Rad';...
        'NA';...
        }; 
x  = length(cHeader);
    textformat = [repmat('%s ',1,x)];
    datacell = textscan(fid,textformat,...
        'Headerlines',1,...
        'Delimiter',',');
    fclose(fid);
    
   for iHeader = 1:length(cHeader)
%     if strcmp(cHeader{iHeader},'Date_Raw') == 1
%           met.(cHeader{iHeader}) = datacell{iHeader};
%     elseif strcmp(cHeader{iHeader},'Time_Raw') == 1
%           met.(cHeader{iHeader}) = datacell{iHeader};
%     else
          met.(cHeader{iHeader}) = str2double(datacell{iHeader});
%     end
%     
   end
   
%       met.date_str = strcat(met.Date_Raw,met.Time_Raw);  
       met.Date = datenum(met.Year,met.Month,met.Day);
   
   solardata.liawenee = met;
   
   save solardata.mat solardata -mat -v7