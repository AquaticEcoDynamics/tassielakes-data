clear all; close all; fclose all;

addpath(genpath('../functions/tuflowfv'));


%ncfile = 'Z:\Busch\Studysites\Fitzroy\Geike_v3\Output\Fitzroy_wl.nc';
ncfile = "D:\woods_model_tfvaed_0.1\outputs\results\woods_2015_2017_test.nc";

outdir = 'D:\woods_model_tfvaed_0.1\outputs\results\';;

%varname = 'WQ_DIAG_LND_SB';
varname = 'TEMP';

cax = [10 20];

conv = 1;%32/1000;%14/1000;

title = 'Temperature (C)';

% These two slow processing down. Only set to 1 if required
create_movie = 1; % 1 to save movie, 0 to just display on screen
save_images = 0;

plot_interval = 1;


%shp = shaperead('Matfiles/Udated_Wetlands.shp');

%clip_depth = 0.05;% In m
clip_depth = 999;% In m

isTop = 1;

%____________




if create_movie | save_images
    
    if ~exist(outdir,'dir')
        mkdir(outdir);
    end
end


if create_movie
    sim_name = [outdir,varname,'.mp4'];
    
    hvid = VideoWriter(sim_name,'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',8);
    framepar.resolution = [1024,768];
    
    open(hvid);
end
%__________________


dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

dat = tfv_readnetcdf(ncfile,'timestep',1);
clear funcions


pdata = tfv_readnetcdf(ncfile,'names',{'TEMP'});
ID = 2157;

ttt = find(dat.idx2 == ID);

TSdate = timesteps;
TSdata = pdata.TEMP(ttt(1),:);


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 5;

[~,indBB] = min(abs(timesteps - datenum(2016,11,01)));



for i = 1:plot_interval:length(timesteps)%1:plot_interval:length(timesteps)
    
    tdat = tfv_readnetcdf(ncfile,'timestep',i);
    clear functions
    
 
    
    if isTop
      if strcmpi(varname,'H') == 0 & strcmpi(varname,'D') == 0 
        
        
        cdata = tdat.(varname)(tdat.idx3(tdat.idx3 > 0));
      else
          
        cdata = tdat.(varname);
      end
    else
    
    bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
    bottom_cells(length(tdat.idx3)) = length(tdat.idx3);
    
    cdata = tdat.(varname)(bottom_cells);
    
    end
    
   Depth = tdat.D;
    
    
    if clip_depth < 900
    
        Depth(Depth < clip_depth) = 0;
    
        cdata(Depth == 0) = NaN;
    end
    
    if strcmpi(varname,'WQ_TRC_RET') == 1
        cdata = cdata ./ 86400;
    end
    
    cdata = cdata * conv;
    
    if first_plot
        
        hfig = figure('visible','on','position',[304         166        1271         812]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        axes('position',[0 0.3 1 0.7]);
        

        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');hold on
        
        scatter(dat.cell_X(ID),dat.cell_Y(ID),'k','filled');
%         plot(281633.0, 6212426.0,'*k');
%         plot(281838.05, 6212888.35,'*r');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        %mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        colormap(jet);
        
        x_lim = get(gca,'xlim');
        y_lim = get(gca,'ylim');
        
        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.1 0.5 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        colorTitleHandle = get(cb,'Title');
        %set(colorTitleHandle ,'String',regexprep(varname,'_',' '),'color','k','fontsize',10);
        
        
        axis off
        axis equal
        
        text(0.1,0.85,title,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        txtDate = text(0.1,0.1,datestr(timesteps(i),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',21,...
            'color','k');
        
        first_plot = 0;
  
        
        axes('position',[0.1 0.05 0.8 0.2]);
        
        plot(TSdate,TSdata,'k');hold on
        
        sc = scatter(TSdate(i),TSdata(i),'r','filled');
        
        grid on;
        
        ylabel('Temperatrue (C)','fontsize',10);
        xlabel('Date','fontsize',10);
        set(gca,'xtick',datenum(2015,01:04:13,01),'xticklabel',datestr(datenum(2015,01:04:13,01)),'fontsize',6);
        
%                 xlim([302147.215129442          309696.598366144]);
%         ylim([6275780.42222753          6289569.26176241]);
%           xlim([306019.916783491           310273.95096848]);
%           ylim([6274581.65164921           6277299.4138508]);

%         xlim([294562.612607759          363234.552262931]);
%         ylim([6045021.04244045          6088893.28083541]);
        set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf,'paperposition',[0.635                      6.35                     20.32                     15.24])
    
    else
        
        set(patFig,'Cdata',cdata);
        drawnow;
        
        set(txtDate,'String',datestr(timesteps(i),'dd mmm yyyy HH:MM'));
        
        caxis(cax);
        set(sc,'Xdata',TSdate(i),'Ydata',TSdata(i));
        drawnow;

    end
    
    if create_movie
        
       % F = fig2frame(hfig,framepar); % <-- Use this
        
        % Add the frame to the video object
    writeVideo(hvid,getframe(hfig));
    end
    
    if save_images
    
        img_dir = [outdir,varname,'/'];
        if ~exist(img_dir,'dir')
            mkdir(img_dir);
        end
        
        img_name =[img_dir,datestr(timesteps(i),'yyyymmddHHMM'),'.png'];
        
        saveas(gcf,img_name);
        
    end
    clear data cdata
    
end

if create_movie
    % Close the video object. This is important! The file may not play properly if you don't close it.
    close(hvid);
end

clear all;