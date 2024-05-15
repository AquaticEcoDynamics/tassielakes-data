clear all;close all;

addpath(genpath('Functions'));

filenames = dir('Files/met/');

[~,sstr] = xlsread('Files/Met Variables.xls','A2:Z1000');

opts.xtick(1) = datenum(2008,01,01);
opts.xtick(2) = datenum(2008,07,01);
opts.xtick(3) = datenum(2009,01,01);
opts.xtick(4) = datenum(2009,07,01);
opts.xtick(5) = datenum(2010,01,01);
opts.xtick(6) = datenum(2010,07,01);
opts.xtick(7) = datenum(2011,01,01);

for kk = 3:length(filenames)
    
    fullname = ['Files/met/',filenames(kk).name];
    
    [data,data_type,bcset_no,n_data,file_type,ierr] = readELCOMinputFile(fullname);
    
    for ii = 1:length(data_type)
        if strcmp(data_type{ii},'TIME') == 1
            nyear = floor(data(:,ii) / 1000);
            nday = rem(data(:,ii),1000);
            inflow.(data_type{ii}) = datenum(nyear,1,nday);
        else
            inflow.(data_type{ii}) = data(:,ii);
        end
    end
    
    for ii = 1:length(data_type)
        if strcmp(data_type{ii},'TIME') == 0
            
            xdata = inflow.TIME;
            if strcmp(data_type{ii},'REL_HUM') == 1
                ydata = inflow.(data_type{ii}) * 100;;
            else
                ydata = inflow.(data_type{ii});
            end
            
            ss = find(strcmp(sstr(:,1),data_type{ii}) == 1);
            
            
            fName = regexp(filenames(kk).name,'_','Split');
            
            opts.title = [data_type{ii}];
            opts.title = regexprep(opts.title,'_','-');
            opts.xlabel = 'Date';
            opts.ylabel = [sstr{ss,2},' (',sstr{ss,3},')'];
%             opts.ylabel = data_type{ii};
%             opts.ylabel = regexprep(opts.ylabel,'_','-');
            opts.xlim = [datenum(2008,01,01) datenum(2011,01,01)];
            if strcmp(data_type{ii},'REL_HUM') == 1
                opts.ylim = [0 100];
            else
                opts.ylim = [];
            end
            savedir = ['MetImages/'];
            
            
            opts.savename = [savedir,data_type{ii},'.eps'];
            
            if ~exist(savedir,'dir')
                mkdir(savedir);
            end
            
            plotbb(xdata,ydata,opts);
        end
    end
    
end