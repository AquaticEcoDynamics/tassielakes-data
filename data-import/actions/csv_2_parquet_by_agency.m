function csv_2_parquet_by_agency

addpath(genpath('../functions/'));

load varkey.mat;

run('td_data_paths.m')
outfilepath = [datapath,'data-warehouse/parquet/agency/'];
             %'D:/csiem/data-warehouse/parquet/agency/';
filepath = [datapath,'data-warehouse/csv/'];
%          'D:/csiem/data-warehouse/csv/';

mkdir(outfilepath);

filelist = dir(fullfile(filepath, '**/*Header.csv'));  %get list of files and folders in any subfolder
%filelist = dir(fullfile(filepath, '**\*HEADER.csv'));  %get list of files and folders in any subfolder

filelist = filelist(~[filelist.isdir]);  %remove folders from list

agency = [];
for i = 1:length(filelist)
    display([filelist(i).folder,'/',filelist(i).name])
    data(i).header = import_header([filelist(i).folder,'/',filelist(i).name]);
%    data(i).header = import_header([filelist(i).folder,'\',filelist(i).name]);

    agency = [agency;{data(i).header.Agency_Code}];
end

unique_agency = unique(agency);

inc = 1;

for ag = 1:length(unique_agency)
    
    find_agency = find(strcmpi(agency,unique_agency(ag)) == 1);
    
    
    tab = create_blank_table;
    tablefield = fieldnames(tab);
    % The datafile name.
    csiem = [];
    
    for ff = 1:length(find_agency)
        
        disp([filelist(find_agency(ff)).folder,'/',filelist(find_agency(ff)).name]);
        
        
        
        headerfile = [filelist(find_agency(ff)).folder,'/',filelist(find_agency(ff)).name];
%        headerfile = [filelist(find_agency(ff)).folder,'\',filelist(find_agency(ff)).name];

        datafile = regexprep(headerfile,'Header','Data');
        
        % Import the header stuff
        header = import_header(headerfile);
        % smd = import_header_smd(regexprep(headerfile,'Header','SMD'));
        header.calc_SMD = 0;%smd.calc_SMD;
        header.mAHD = 0;%smd.mAHD;
        
        tt2 = import_datafile_raw(datafile);
        disp('Finished Import');
        
        dt = mean(diff(tt2.Date));
        
        tab11 = struct2table(tt2);
        tab11.Date = datetime(tab11.Date,'ConvertFrom','datenum');
        % Downshift the data to hourly if required.
        if dt < 1/(60*24)
            if strcmpi(header.Deployment,'Profile') == 0
                disp('Starting Downsample');
                tt = timetable2table(retime(table2timetable(tab11),'minutely','nearest'));
            else
                tt = tab11;
            end
            disp('Finished Downsample');
        else
            tt = tab11;
        end
        
    csiem.Date = tt.Date;
    csiem.Data = double(tt.Data);
    csiem.Depth = [];
    
    switch header.Deployment
        
        case 'Integrated'
            csiem.Depth = tt.Depth;
        case 'Fixed'
            
            if sum(ismember(tt.Properties.VariableNames,'Height'))
                
                thedata = [];
                for k = 1:length(tt.Height)
                    thedata(k,1) = str2double(tt.Height{k});
                end
                csiem.Depth = (str2double(header.calc_SMD) - thedata) .* -1;
                
                
            else
                
                for k = 1:length(tt.Depth)
                    csiem.Depth(k,1) = str2double(tt.Depth{k}) * -1;
                end
                
                
            end
        case 'Floating'
            if sum(ismember(tt.Properties.VariableNames,'Height'))
                thedata = [];
                for k = 1:length(tt.Height)
                    thedata(k,1) = str2double(tt.Height{k});
                end
                
                
                
                csiem.Depth = (thedata) .* -1;
                
                
            else
                
                for k = 1:length(tt.Depth)
                    csiem.Depth(k,1) = str2double(tt.Depth{k}) * -1;
                end
                
                
            end
            
        case 'Profile'
            for k = 1:length(tt.Depth)
                csiem.Depth(k,1) = str2double(tt.Depth{k}) * -1;
            end

        case 'Satelite'
            for k = 1:length(tt.Depth)
                csiem.Depth(k,1) = str2double(tt.Depth{k}) * -1;
            end
        otherwise
            display('Not recognised Deployment')
            
    end
    
    headerfield = fieldnames(header);
    
    for k = 1:length(headerfield)
        
        csiem.(headerfield{k}) = header.(headerfield{k});
    end
    
    
    
    csiem.X = header.Lon;
    csiem.Y = header.Lat;
    csiem.XUTM = header.X;
    csiem.YUTM = header.Y;
    csiem.Agency = header.Tag;
    csiem.Units = varkey.(header.Variable_ID).tfvUnits;
    
    for k = 1:length(tablefield)
        
        switch tablefield{k}
            case 'Date'
                tab.Date = [tab.Date;datestr(csiem.Date,'yyyy-mm-dd HH:MM:SS')];
            case 'Data'
                tab.Data = [tab.Data;csiem.Data];
            case 'Depth'
                if isnumeric(csiem.Depth)
                    tab.Depth = [tab.Depth;csiem.Depth];
                else
                    fakedepth = [];
                    fakedepth(1:length(csiem.Date),1) = 0;
                    tab.Depth = [tab.Depth;fakedepth];
                end
                
            otherwise
                outdata = appenddata(csiem.Date,csiem.(tablefield{k}));
                tab.(tablefield{k}) = [tab.(tablefield{k});outdata];
        end
    end
    clear csiem;
end

outfile = [outfilepath,'csiem_',unique_agency{ag},'_public.parq'];
newtable = struct2table(tab);

parquetwrite(outfile,newtable); clear newtable;
end