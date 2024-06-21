function data = import_header(filename)

fid = fopen(filename,'rt');

%Defaults

Mount = [];

fline = fgetl(fid);
while ~feof(fid)
    fline = fgetl(fid);
    sline = split(fline,',');
    %sline
    switch sline{1}
        case 'Agency Name'
            data.Agency_Name = sline{2};
        case 'Tag'
            data.Tag = sline{2};
        case 'Agency Code'
            data.Agency_Code = sline{2};
            
        case 'Program'
            data.Program_Name = sline{2};
            
        case 'Project'
            data.Program_Code = sline{2};
            
        case 'Data File Name'
            data.Data_File_Name = sline{2};
            
        case 'Location'
            data.Data_File_Location = sline{2};
            
        case 'Station Status'
            data.Status = sline{2};
            
        case 'Lat'
            data.Lat = str2num(sline{2});
            
        case 'Long'
            data.Lon = str2num(sline{2});
            
        case 'Time Zone'
            data.Time_Zone = sline{2};
            
        case 'Vertical Datum'
            data.Vertical_Datum = sline{2};
            
        case 'National Station ID'
            data.Station_ID = sline{2};
            
        case 'Site Description'
            data.Site_Description = sline{2};
            
        case 'Bad or Unavailable Data Value'
            data.Bad_Data_Code = sline{2};
            
        case 'Deployment'
            data.Deployment = sline{2}; 
            
        case 'Deployment Position'
            data.Deployment_Position = sline{2};            
            
        case 'Vertical Reference'
            data.Vertical_Reference = sline{2};
            
        case 'Site Mean Depth'
            data.Site_Mean_Depth = sline{2};
                        
        case 'Mount Description'
            %data.Mount = sline{2};
            
        case 'Contact Email'
            data.Email = sline{2};
            
        case 'Variable ID'
            data.Variable_ID = sline{2};
            
        case 'Data Classification'
            data.Data_Classification = sline{2};
            
        case 'Sampling Rate (min)'
            data.Sampling_Rate = sline{2};
            
        case 'Date'
            data.Date_Format = sline{2};
            
        case 'Depth'
            data.Depth_Format = sline{2};
            
        case 'Variable'
            data.Variable_Name = sline{2};
            
        case 'QC'
            data.QC_Code = sline{2};
            
        case 'Data Category'
            data.DataCategory = sline{2};           
        otherwise
            sline{1}
            disp('Header not found');
            stop;
    end
    

    
end
    [data.X,data.Y] = ll2utm(data.Lat,data.Lon);
    fclose(fid);

end