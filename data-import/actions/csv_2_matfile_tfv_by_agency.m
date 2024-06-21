function csv_2_matfile_tfv_by_agency

addpath(genpath('../functions/'));

run('td_data_paths.m')
load varkey.mat;

outfilepath = [datapath,'data-warehouse/mat/agency/'];mkdir(outfilepath);
%             'D:/csiem/data-warehouse/mat/agency/';mkdir(outfilepath);
filepath = [datapath,'data-warehouse/csv'];
%          'D:/csiem/data-warehouse/csv/';
mergepath = [datapath,'data-warehouse/mat/'];
%           'D:/csiem/data-warehouse/mat/';

filelist = dir(fullfile(filepath, '**/*Header.csv'));  %get list of files and folders in any subfolder
%filelist = dir(fullfile(filepath, '**\*HEADER.csv'));  %get list of files and folders in any subfolder

filelist = filelist(~[filelist.isdir]);  %remove folders from list

agency = [];
            

for i = 1:length(filelist)
    display([filelist(i).folder,'/',filelist(i).name])
    data(i).header = import_header([filelist(i).folder,'/',filelist(i).name]);
    %data(i).header = import_header([filelist(i).folder,'\',filelist(i).name]);

    agency = [agency;{data(i).header.Agency_Code}];
end

unique_agency = unique(agency);
unique_agency
inc = 1;

for ag = 1:length(unique_agency)

    find_agency = find(strcmpi(agency,unique_agency(ag)) == 1);

    % The datafile name.
    csiem = [];

    for ff = 1:length(find_agency)

        disp(filelist(find_agency(ff)).name);
        
        
        headerfile = [filelist(find_agency(ff)).folder,'/',filelist(find_agency(ff)).name];
      %  headerfile = [filelist(find_agency(ff)).folder,'\',filelist(find_agency(ff)).name];

        datafile = regexprep(headerfile,'Header','DATA');

        % Import the header stuff
        header = import_header(headerfile);
        % smd = import_header_smd(regexprep(headerfile,'Header','SMD'));
        % header.calc_SMD = smd.calc_SMD;
        % header.mAHD = smd.mAHD;
        header.mAHD = 0;
        sitecode = [header.Agency_Code,'_',header.Program_Code,'_',header.Station_ID];
        sitecode = regexprep(sitecode,'\.','');
        sitecode = [sitecode,'_',header.Deployment,'_',num2str(inc)];
        sitecode = regexprep(sitecode,'-','_');
        %sitecode = [agency,'_',num2str(randi(10000,1))];
        %sitecode = [agency,'_',num2str(i)];
        tfv_name = varkey.(header.Variable_ID).tfvName;
        tfv_conv = varkey.(header.Variable_ID).tfvConv;
        Deployment = header.Deployment;

        % Import the data stuff

        if strcmpi(tfv_name,'N/A') == 0

            % opts = detectImportOptions(datafile);
            % if sum(ismember(opts.VariableNames,'Height'))
            %     opts = setvartype(opts, 'Height', 'string');  %or 'char' if you prefer
            % else
            %     opts = setvartype(opts, 'Depth', 'string');  %or 'char' if you prefer
            % end

            % tab = readtable(datafile,opts);

            display(datafile)
            %datafile = regexprep(datafile,' ','');
            tt = import_datafile_raw(datafile);
            stop
            disp('Finished Import');
            tab = struct2table(tt);
            tab.Date = datetime(tab.Date,'ConvertFrom','datenum');
            % Downshift the data to hourly if required.
            dt = mean(diff(tab.Date));
            if datenum(dt) < 1/24
                if strcmpi(header.Deployment,'Profile') == 0
                    tt2 = timetable2table(retime(table2timetable(tab),'hourly','nearest'));
                else
                    tt2 = tab;
                end
                disp('Finished Downsample');
            else
                tt2 = tab;
            end


            [s,~,j] = unique(tt2.QC);
            QC_CODE = s{mode(j)};


            csiem.(sitecode).(tfv_name).QC = QC_CODE;

            csiem.(sitecode).(tfv_name).Date = datenum(tt2.Date);
            csiem.(sitecode).(tfv_name).Data = tt2.Data * tfv_conv;
            csiem.(sitecode).(tfv_name).Data_Raw = double(tt2.Data);
            if sum(ismember(tt2.Properties.VariableNames,'Depth'))
                csiem.(sitecode).(tfv_name).oDepth = tt2.Depth;
            else
                csiem.(sitecode).(tfv_name).Height = tt2.Height;
            end


            switch Deployment

                case 'Integrated'
                    csiem.(sitecode).(tfv_name).Depth = tt2.Depth;
                case 'Fixed'

                    if sum(ismember(tt2.Properties.VariableNames,'Height'))



                        thedata = [];
                        for k = 1:length(tt2.Height)
                            thedata(k,1) = str2double(tt2.Height{k});
                        end
                        csiem.(sitecode).(tfv_name).Depth = (str2double(header.calc_SMD) - thedata) .* -1;


                    else

                        for k = 1:length(tt2.Depth)
                            csiem.(sitecode).(tfv_name).Depth(k,1) = str2double(tt2.Depth{k}) * -1;
                        end


                    end
                case 'Floating'
                    if sum(ismember(tt2.Properties.VariableNames,'Height'))
                        thedata = [];
                        for k = 1:length(tt2.Height)
                            thedata(k,1) = str2double(tt2.Height{k});
                        end



                        csiem.(sitecode).(tfv_name).Depth = (thedata) .* -1;


                    else

                        for k = 1:length(tt2.Depth)
                            csiem.(sitecode).(tfv_name).Depth(k,1) = str2double(tt2.Depth{k}) * -1;
                        end


                    end

                case 'Profile'
                    for k = 1:length(tt2.Depth)
                        csiem.(sitecode).(tfv_name).Depth(k,1) = str2double(tt2.Depth{k}) * -1;
                    end
                case 'Satelite'
                    for k = 1:length(tt.Depth)
                        csiem.Depth(k,1) = str2double(tt.Depth{k}) * -1;
                    end
                otherwise

            end
            headerfield = fieldnames(header);

            for k = 1:length(headerfield)

                csiem.(sitecode).(tfv_name).(headerfield{k}) = header.(headerfield{k});
            end



            csiem.(sitecode).(tfv_name).X = header.Lon;
            csiem.(sitecode).(tfv_name).Y = header.Lat;
            csiem.(sitecode).(tfv_name).XUTM = header.X;
            csiem.(sitecode).(tfv_name).YUTM = header.Y;
            csiem.(sitecode).(tfv_name).Agency = header.Tag;
            csiem.(sitecode).(tfv_name).Units = varkey.(header.Variable_ID).tfvUnits;



            inc = inc + 1;
        end


    end


    

    if ~isempty(csiem)
        dt=whos('csiem'); MB=dt.bytes*9.53674e-7;
        disp(['csiem is: ',num2str(MB),'MB']);
        if MB > 1700
            save([outfilepath,'csiem_',unique_agency{ag},'_public.mat'],'csiem','-mat','-v7.3');
        else
            save([outfilepath,'csiem_',unique_agency{ag},'_public.mat'],'csiem','-mat');
        end
    end
    clear csiem
end

filelist = dir(fullfile(outfilepath, '**/*.mat'));  %get list of files and folders in any subfolder
%filelist = dir(fullfile(outfilepath, '**\*.mat'));  %get list of files and folders in any subfolder

filelist = filelist(~[filelist.isdir]);  %remove folders from list



for i = 1:length(filelist)
    disp(filelist(i).name);
    matdata = load([filelist(i).folder,'/',filelist(i).name]);
    sites = fieldnames(matdata.csiem);
    for j = 1:length(sites)
        csiem.(sites{j}) = matdata.csiem.(sites{j});
    end
    
    clear matdata;
end

save([mergepath,'csiem.mat'],'csiem','-mat','-v7.3');