function summerise_data(datafile,summary_folder,gis_folder,shpname)
% This script produces a series of images and spreadsheet designed to
% summerise the data contained within one of our matfiles.

if ~exist(summary_folder,'dir')
    mkdir(summary_folder);
end

if ~exist(gis_folder,'dir')
    mkdir(gis_folder);
end



fielddata = load(datafile);

% Strip out project name and put into variable data;
proj = fieldnames(fielddata);
data = fielddata.(proj{1});




create_summary_spreadsheet(data,summary_folder);

create_var_summary_spreadsheet(data,summary_folder);


plot_summary_data(data,summary_folder)

export_shapefile(data,gis_folder,shpname)






end

function export_shapefile(data,gis_folder,shpname)

sites = fieldnames(data);

for i = 1:length(sites)
    
    vars = fieldnames(data.(sites{i}));
    
    S(i).X = data.(sites{i}).(vars{1}).X(1);
    S(i).Y = data.(sites{i}).(vars{1}).Y(1);
    
    S(i).Name = sites{i};
    S(i).Geometry = 'Point';
    
    if isfield(data.(sites{i}).(vars{1}),'Agency')
        S(i).Agency = data.(sites{i}).(vars{1}).Agency;
    end
    
    
end
%S.X
shapewrite(S,[gis_folder,shpname]);
end
    

function plot_summary_data(data,summary_folder)

sites = fieldnames(data);

basedir = summary_folder;

for i = 1:length(sites)
    
    vars = fieldnames(data.(sites{i}));
    
    for j = 1:length(vars)
        xdata_B = [];
        ydata_B = [];
        
        disp([sites{i},':',vars{j}]);
        xdata = data.(sites{i}).(vars{j}).Date;
        ydata = data.(sites{i}).(vars{j}).Data;
        
        if isfield(data.(sites{i}).(vars{j}),'Depth')
            sss  = find(data.(sites{i}).(vars{j}).Depth > -2);
            ttt  = find(data.(sites{i}).(vars{j}).Depth <= -2);
            if ~isempty(sss)
                xdata = [];
                ydata = [];
                xdata = data.(sites{i}).(vars{j}).Date(sss);
                ydata = data.(sites{i}).(vars{j}).Data(sss);
            end
            if ~isempty(ttt)
                
                xdata_B = data.(sites{i}).(vars{j}).Date(ttt);
                ydata_B = data.(sites{i}).(vars{j}).Data(ttt);
                
            end
            
        end
        
        outdir = [basedir,sites{i},'/'];
        
        if ~exist(outdir,'dir')
            mkdir(outdir);
        end
        
        fig1 = figure('visible','off');
        set(fig1,'defaultTextInterpreter','latex')
        set(0,'DefaultAxesFontName','Times')
        set(0,'DefaultAxesFontSize',6)
        
        plot(xdata,ydata,'.k');hold on;
        plot(xdata,ydata,'--','color',[0.6 0.6 0.6]);hold on;
        
        if ~isempty(ydata_B)
            plot(xdata,ydata,'.r');hold on;
            plot(xdata,ydata,'--','color',[0.6 0.6 0.6]);hold on;
        end
        
        
        
        datearray = [min(xdata):(max(xdata) - min(xdata))/5:max(xdata)];
        
        ylabel(regexprep(vars{j},'_',' '));
        xlabel('Date');
        title(regexprep(sites{i},'_',' '),'fontsize',10);
        
        %xlim([(min(datearray) - 10) (max(datearray) + 10)]);
        
        grid on
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'dd-mm-yy'));
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 16;
        ySize = 8;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        filename = [outdir,vars{j},'.png'];
        
        
        print(gcf,'-dpng',filename,'-opengl');
        
        close
        
        
        
    end
end
end


function create_var_summary_spreadsheet(data,summary_folder)

sites = fieldnames(data);

allvars = [];

for i = 1:length(sites)
    
    vars = fieldnames(data.(sites{i}));
    allvars = [allvars;vars];
end

uvars = unique(allvars);

fid = fopen([summary_folder,'Var_Summary.csv'],'wt');

fprintf(fid,'Site,');
for i = 1:length(uvars)
    fprintf(fid,'%s,',uvars{i});
end
fprintf(fid,'\n');

for i = 1:length(sites)
    
    fprintf(fid,'%s,',sites{i});
    
    for j = 1:length(uvars)
        if isfield(data.(sites{i}),uvars{j})
            fprintf(fid,'x,');
        else
            fprintf(fid,' ,');
        end
    end
    fprintf(fid,'\n');
end
    
fclose(fid);

end

function create_summary_spreadsheet(data,summary_folder)

sites = fieldnames(data);

fid = fopen([summary_folder,'Site_Summary.csv'],'wt');

fprintf(fid,'Site,X,Y,Num. Vars,Start Date,End Date,Total Samples at Site\n');

for i = 1:length(sites)
    
    fprintf(fid,'%s,',sites{i});
    
    vars = fieldnames(data.(sites{i}));
    
    X = data.(sites{i}).(vars{1}).X;
    Y = data.(sites{i}).(vars{1}).Y;
    numvars = length(vars);
    fprintf(fid,'%8.4f,%8.4f,%i,',X,Y,numvars);
    
    thedates = [];
    for j = 1:length(vars)
        thedates = [thedates;data.(sites{i}).(vars{j}).Date];
    end
    sdate = min(thedates);
    edate = max(thedates);
    total_samples = length(thedates);
    sdate
    fprintf(fid,'%s,%s,%i\n',datestr(sdate,'dd-mm-yyyy'),datestr(edate,'dd-mm-yyyy'),total_samples);
    
    clear sdate edate total_samples thedates X Y;
end

fclose(fid);

end


