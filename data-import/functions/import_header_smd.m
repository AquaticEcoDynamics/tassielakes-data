function data = import_header_smd(filename)

fid = fopen(filename,'rt');

%Defaults

Mount = [];


while ~feof(fid)
    fline = fgetl(fid);
    sline = split(fline,',');
    
    switch sline{1}
        case 'Calculated mAHD'
            data.mAHD = sline{2};
        case 'Calculated SMD'
            data.calc_SMD = sline{2};
        
        otherwise
            disp('Header not found');
            stop;
    end
    

    
end
 %   [data.X,data.Y] = ll2utm(data.Lat,data.Lon);
    fclose(fid);

end