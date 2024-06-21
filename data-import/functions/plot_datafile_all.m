function plot_datafile(filename,plotname)

warning off

filename = regexprep(filename,'\','/');
%plotname = regexprep(filename,'DATA.csv','IMAGE.png');


tft = split(filename,'/');

data = import_datafile(filename);

%data

[~,headers] = xlsread(filename,'A1:D1');

%     data.Depth = depth;
%     data.Depth_T = depth1;
%     data.Depth_B = depth2;

headerfile = regexprep(filename,'DATA','HEADER');

headerdata = import_header(headerfile);

titlestring = regexprep(tft{end},'.csv','');
titlestring = regexprep(titlestring,'_',' ');

fig1 = figure('visible','off');
set(fig1,'defaultTextInterpreter','latex')
set(0,'DefaultAxesFontName','Times')
set(0,'DefaultAxesFontSize',6)


gx = geoaxes('position',[0.1 0.72 0.8 0.25]);

geoscatter(headerdata.Lat,headerdata.Lon,"o",'filled','markerfacecolor','w');hold on

geobasemap('satellite'); pause(0.1);

title(headerdata.Station_ID);

% text(headerdata.Lat,headerdata.Lon+ 0.001,headerdata.Station_ID,...
%     'fontsize',8,'fontweight','bold','color','w');


nzoom = 8.9626;
gx.ZoomLevel = nzoom;


axes('position',[0.1 0.375 0.8 0.25]);

yyaxis left


%data.Date
if min(data.Date) == max(data.Date)
    plot(data.Date,data.Data,'.');
    xarr = [(min(data.Date) -10): 20/4:(max(data.Date)+10)];
    datestr(xarr)
else
   plot(data.Date,data.Data);
   xarr = [min(data.Date): (max(data.Date) - min(data.Date))/4:max(data.Date)];
end
 
%datestr(xarr)
    
xlim([min(xarr) max(xarr)]);

set(gca,'xtick',xarr,'xticklabel',datestr(xarr,'mm-yy'));
ylabel(headerdata.Variable_Name);

yyaxis right

if min(data.Date) == max(data.Date)
    plot(data.Date,data.Depth,'.');
    xarr = [(min(data.Date) -10): 20/4:(max(data.Date)+10)];
    %datestr(xarr)
else
   plot(data.Date,data.Depth);
   xarr = [min(data.Date): (max(data.Date) - min(data.Date))/4:max(data.Date)];
end


xlim([min(xarr) max(xarr)]);

set(gca,'xtick',xarr,'xticklabel',datestr(xarr,'mm-yy'));

if strcmpi(headers{2},'Height') == 1
    ylabel('Height(m)');
else
    ylabel('Depth(m)');
end

xlabel('Date');
title(titlestring);

axes('position',[0.05 0.0 0.95 0.4]);axis off
vars = fieldnames(headerdata);
XX = 10/length(vars);

for kk = 1:length(vars)
    if kk < 16
        if ~isnumeric(headerdata.(vars{kk}))
            text(.0,1.2-(XX + (kk *0.05)),[vars{kk},': ',headerdata.(vars{kk})],'fontsize',6);
        else
            text(.0,1.2-(XX + (kk *0.05)),[vars{kk},': ',num2str(headerdata.(vars{kk}))],'fontsize',6);
        end
    else
        if ~isnumeric(headerdata.(vars{kk}))
            text(.6,1.2-(XX + ((kk-15) *0.05)),[vars{kk},': ',headerdata.(vars{kk})],'fontsize',6);
        else
            text(.6,1.2-(XX + ((kk-15) *0.05)),[vars{kk},': ',num2str(headerdata.(vars{kk}))],'fontsize',6);
        end
    end
    
end




set(gca,'XTick',xarr,'XTickLabel',datestr(xarr,'mm-yyyy'));
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 28;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize]);

print(gcf,plotname,'-dpng');
close all;

clear data;