% .*((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((*.%
%.((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((%
%                                 ____    _    _   _                      %
%.(((((((      |\    /|    /\    |    \  \ \  / / | |          (((((((((((%
%.(((((((      | \  / |   /  \   |   /   \ \/ /  | |          (((((((((((%
%.(((((((      |  \/  |  /   \  | |\ \    \  /   | |____      (((((((((((%
%.(((((((      |_|\/|_| /_/  \_\ |_| \_\    \/    |______|     (((((((((((%
%                                                                         %
%.((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((%
% .*((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((*.%
% The AED Model Assessment, Reporting and Visualisation Library
%--------------------------------------------------------------------------
% MARVL configuration for Cockburn Sound
MARVLs = struct;
%run('td_data_paths.m')

%% master configuration: --------------------------------------------------
%
% List here the available MARVL modules, state variables, model outputs,
%   processed field data, and general plotting features to be included
%   in the plotting.
%
% Note: if multiple NetCDF outpus are listed, some modules only deal with
%  the first NetCDF output such as the transect_stackedArea module.
% For further detail about available MARVL modules visit:
%     MARVL_documentation.doc
%
%--------------------------------------------------------------------------
master.modules = {...
       'timeseries';...
%        'boxchart';...
%        'transect';  ...
%        'transect_stackedArea'; ...
%        'transect_exceedance'; ...
%        'sheet'; ...
%        'curtain'; ...
%        'site_profiling'; ...
    %   'sediment_profiling'; ...
    };

% state variable Configuration
%    column 1: AED names;
%    column 2: user-defined names
master.varname = {...
    'H','H';...
    'SAL','Salinity';...
    'TEMP','Temperature';...
    'WQ_OXY_OXY','DO';...
    'WQ_DIAG_OXY_SAT','DO-saturation';...
    'WQ_NIT_AMM','NH_4';...
    'WQ_NIT_NIT','NO_3';...
    'WQ_PHS_FRP','PO_4';...
%    'WQ_OGM_POP','POP';...
%    'WQ_OGM_DOP','DOP';...
%    'WQ_OGM_PON','PON';...
%    'WQ_OGM_DON','DON';...
%    'WQ_OGM_POC','POC';...
    'WQ_OGM_DOC','DOC';...
%    'WQ_PHS_FRP_ADS','FRPADS';...
    'WQ_DIAG_PHY_TCHLA','TCHLA';...
    'WQ_DIAG_TOT_TN','TN';...
    'WQ_DIAG_TOT_TP','TP';...
    'WQ_DIAG_TOT_TSS','TSS';...
%    'WQ_DIAG_TOT_TOC','TOC';...
    'WQ_DIAG_TOT_TURBIDITY','Turbidity';...
%    'WQ_NCS_SS1','SS1';...
%     'WQ_PHY_DINO','DINO';...
%     'WQ_PHY_MDIAT','MDIAT';...
%     'WQ_PHY_CRYPT','CRYPT';...
%     'WQ_PHY_BGA','BGA';...
%     'WQ_PHY_GRN','GRN';...
%     'WQ_DIAG_TOT_LIGHT','TOT-LIGHT';...
    'WQ_DIAG_TOT_PAR','TOT-PAR';...
%     'WQ_DIAG_TOT_UV','TOT-UV';...
%     'WQ_DIAG_TOT_EXTC','TOT-EXTC';...
% 	  'WQ_DIAG_OGM_PON_SWI','PONSWI';...
%     'WQ_DIAG_OGM_DON_SWI','DONSWI';...
%     'WQ_DIAG_NIT_AMM_DSF','AMMDSF';...
%     'WQ_DIAG_NIT_NIT_DSF','NITDSF';...
%     'WQ_DIAG_OGM_POP_SWI','POPSWI';...
%     'WQ_DIAG_OGM_DOP_SWI','DOPSWI';...
%     'WQ_DIAG_PHS_FRP_DSF','FRPDSF';...
    };
master.add_human = 1; % option to use user-define names, if 0 use AED names

% Models
master.ncfile(1).name = '/Development/projects/Woods/woods_model_tfvaed_0.1/outputs/results/woods_2023_2024_wqv3_WQ.nc';
%'/Projects2/csiem/Model/TFV/Results_2022_B009/csiem_v1_B009_20220101_20221231_WQ_WQ.nc';
%'/Projects2/csiem/Model/TFV/Results_2013_B009_HD/csiem_v1_B009_20130101_20131231_HD.nc';
%'/Projects2/csiem/Model/TFV/Results_2013_B009_HD/csiem_v1_B009_20130101_20131231_HD.nc';
%'/Projects2/csiem/Model/TFV/Results_2015_B009/csiem_v1_B009_20150101_20151231_WQ_WQ.nc';
%'/Projects2/csiem/Model/TFV/csiem_model_tfvaed_1.0/tfvaed_1.0/outputs/results_2022_newMZ/csiem_100_A_20220101_20221231_WQ_009_WWM_WRF_GW_NAR_IMOS_newMZ_WQ.nc';
%'/Projects2/csiem/Model/TFV/csiem_model_tfvaed_1.0/tfvaed_1.0/outputs/results_IMOS/csiem_100_A_20220101_20221231_WQ_009_WWM_WRF_GW_NAR_IMOS_WQ.nc';
%'/Projects2/csiem/Model/TFV/csiem_model_tfvaed_1.0/tfvaed_1.0/outputs/results_2022_shifted/csiem_100_A_20220101_20221231_WQ_009_waves_noGW_WWM_WQ.nc';
%'E:\database\csiem_100_A_20130101_20130601_WQ_009_diag_1_WQ.nc';
%'E:\database\csiem_100_A_20130101_20130601_WQ_009_WQ_plot_ks.nc';
master.ncfile(1).legend = 'V0';
master.ncfile(1).tag = 'TFV';

%master.ncfile(2).name = '/Projects2/csiem/Model/TFV/csiem_model_tfvaed_1.1/outputs/results/csiem_v1_A001_20220101_20221231_WQ_lowRes_T1_WQ.nc';
%'/Projects2/csiem/Model/TFV/Results_2013_B009/csiem_v1_B009_20130101_20131231_WQ_WQ_noCan.nc';
%'E:\database\csiem_100_A_20130101_20130601_WQ_009_diag_1_WQ.nc';
%'E:\database\csiem_100_A_20130101_20130601_WQ_009_WQ_plot_ks.nc';
% master.ncfile(2).legend = 'V1';
% master.ncfile(2).tag = 'TFV';

% field data
master.add_fielddata = 1;
master.fielddata_matfile = '../data-warehouse/mat/agency/csiem_HT_public.mat';
master.fielddata_files = {'csiem_HT_public'};
master.fielddata_folder = ['../data-warehouse/mat/agency/'];

master.fielddata = 'csiem'; %'swan';

% general plotting features
master.font = 'Times New Roman'; %'Helvetica';
master.fontsize   = 9;
master.xlabelsize = 9;
master.ylabelsize = 9;
master.titlesize  = 10;
master.legendsize = 6;
master.visible = 'off'; % on or off

MARVLs.master = master; clear master;

%% timeseries setting:-----------------------------------------------------
%  The is the configuration file for the marvl_plot_timeseries.m function.
% -------------------------------------------------------------------------

timeseries.start_plot_ID = 1;
timeseries.end_plot_ID = 15;

timeseries.plotvalidation = 1; % Add field data to figure (true or false)
timeseries.validation_raw = 1; % 1: raw data; 0: daily-average
timeseries.plotmodel = 1;

timeseries.plotdepth = {'surface','bottom'};  %  {'surface','bottom'} Cell-array with either one
timeseries.depthTHRESH = -3;  %  {'surface','bottom'} Cell-array with either one
% timeseries.edge_color = {[166,86,40]./255;[8,88,158]./255}; % symbol edge color for field data, surface and bottom
timeseries.edge_color = {[255, 100, 100]./255; [0, 0, 0]./255};
timeseries.depth_range = [0.2 100];
timeseries.validation_minmax = 0;
timeseries.isModelRange = 1;
timeseries.pred_lims = [0.05,0.25,0.5,0.75,0.95];
timeseries.alph = 0.5;

%timeseries.filetype = 'png';
%timeseries.expected = 1; % plot expected WL

timeseries.isFieldRange = 0;
timeseries.fieldprctile = [10 90];
timeseries.isHTML = 0;

timeseries.polygon_file = '../gis/woods_marvl_zones_v1.shp';
timeseries.plotAllsites = 1;
if timeseries.plotAllsites == 0
    timeseries.plotsite = [6 10 29];
end

% section for model skill calculations
timeseries.add_error = 0;
timeseries.isSaveErr = 1;
timeseries.obsTHRESH = 5;
timeseries.showSkill = 0;
timeseries.scoremethod = 'range'; % 'range' or 'median'

timeseries.SkillStyle = 'score'; % 'score' for score table or 'tailor' for tailor diagram

% selection of model skill assessment, 1: activated; 0: not activated
timeseries.skills = [1,... % r: regression coefficient (0-1)
    1,... % BIAS: bias relative to mean observation (%)
    1,... % MAE: mean absolute error
    1,... % RMSE: root mean square error
    1,... % NMAE: MAE normalized to mean observation
    1,... % NRMS: RMSE normalized to mean observation
    1,... % MEF: model efficienty, Nash-Sutcliffe Efficiency
    ];
timeseries.outputdirectory = '../outputs/MARVL_AED/RAW/';
timeseries.htmloutput = '../outputs/MARVL_AED/HTML/';
timeseries.ErrFilename = '../outputs/MARVL_AED/errormatrix.mat';

timeseries.ncfile(1).symbol = {'-';'-'};
% timeseries.ncfile(1).colour = {[166,86,40]./255;[8,88,158]./255};% Surface and Bottom
timeseries.ncfile(1).colour = {[255, 255, 255]./255; [0, 0, 0]./255}
timeseries.ncfile(1).col_pal_color_surf =[[254,232,200]./255;[252,141,89]./255]; % color1: 5-95 perc; color2: 25-75 perc
% timeseries.ncfile(1).col_pal_color_bot  =[[222,235,247]./255;[107,174,214]./255];
timeseries.ncfile(1).col_pal_color_bot = [[211, 211, 211]./255; [128, 128, 128]./255];

% timeseries.ncfile(2).symbol = {'-';'-'};
% timeseries.ncfile(2).colour = {[77,175,74]./255;[152,78,163]./255};% Surface and Bottom
% timeseries.ncfile(2).col_pal_color_surf =[[222,235,247]./255;[107,174,214]./255]; % color1: 5-95 perc; color2: 25-75 perc
% timeseries.ncfile(2).col_pal_color_bot  =[[254,232,200]./255;[252,141,89]./255];


% plotting configuration
timeseries.datearray = datenum(2023,01:6:23,1);
timeseries.dateformat = 'dd/mmm/yy';

%timeseries.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
timeseries.istitled = 1;
timeseries.isylabel = 1;
timeseries.islegend = 1;
timeseries.isYlim   = 1;
%timeseries.isGridon = 1;
timeseries.dimensions = [20 10]; % Width & Height in cm

timeseries.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
%timeseries.smoothfactor = 3; % Must be odd number (set to 3 if none)

%timeseries.fieldsymbol = {'.','.'}; % Cell with same number of levels
%timeseries.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

timeseries.legendlocation = 'northeastoutside';
timeseries.filetype = 'png';

% ylim
 for vvvv=1:size(MARVLs.master.varname,1)
     timeseries.cAxis(vvvv).value = [ ];
 end
%timeseries.cAxis(4).value = [2 10];
%timeseries.cAxis(5).value = [40 120];

MARVLs.timeseries = timeseries; clear timeseries;

%% Transect setting:-----------------------------------------------------
%  The is the configuration file for the marvl_plot_transect.m function.
% -------------------------------------------------------------------------

transect.start_plot_ID = 4;
transect.end_plot_ID = 4;

transect.polygon_file = '../gis/New_Curtain_line_LL_Dist.shp';
% Add field data to figure
transect.plotvalidation = 1; % 1 or 0
transect.pred_lims = [0.05,0.25,0.5,0.75,0.95];

transect.isRange = 1;
transect.istitled = 1;
transect.isylabel = 1;
transect.islegend = 0;
transect.isYlim = 1;
transect.isHTML = 1;
transect.isSurf = 1; %plot surface (1) or bottom (0)
transect.isSpherical = 1;
transect.use_matfiles = 0;
transect.add_obs_num = 1;
%config.boxon = 1;

% ___
transect.outputdirectory = '../outputs/transect_oxy/RAW/';
transect.htmloutput = '../outputs/transect_oxy/HTML/';

% plotting configuration
transect.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
transect.boxlegend = 'southeast';
transect.rangelegend = 'northwest';
transect.dimensions = [20 10]; % Width & Height in cm
transect.filetype = 'png';

for i=1:7
transect.pdates(i).value = [datenum(2013,04,1+(i-1)*5) datenum(2013,04,1+i*5)];
end


transect.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.
transect.binradius = 0.5;% in km;


%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.
transect.linedist = 1500;%  in m

transect.xtickManual = 1;  % 1: use manual x labels'; 0: use distance
% transect.xlim = [0 47.6];% xlim in KM
% transect.xticks = [0 18.4 28.3 47.5]; %[0:5:45];
% transect.xticklabels = {'Cape Peron','Coogee','Port Fremantle','Narrows Bridge'};
transect.xlim = [0 27.3];% xlim in KM
transect.xticks = [0    6.36   13.06   20.12   27.0]; %[0:5:45];
transect.xticklabels = {'offshore','Cape Peron','central CS','Coogee','Fremantle'};
transect.xlabel = 'Distance from Southern CS (km)';

% ylim
%transect.cAxis(1).value = [35 37]; %SAL
%transect.cAxis(2).value = [22 30]; %TEMP
%transect.cAxis(3).value = [5.5 7.3]; %OXY
%transect.cAxis(4).value = [0 0.1]; %AMM
%transect.cAxis(5).value = [0 0.02]; %NIT
%transect.cAxis(6).value = [0 0.015]; %FRP

 for vvvv=1:size(MARVLs.master.varname,1)
     transect.cAxis(vvvv).value = [ ];
 end

transect.ncfile(1).symbol = {'-'};
transect.ncfile(1).translate = 1;
transect.ncfile(1).colour = [166,86,40]./255;
transect.ncfile(1).edge_color = [166,86,40]./255;
transect.ncfile(1).col_pal_color =[[254,232,200]./255;[252,141,89]./255];

MARVLs.transect = transect; clear transect;

%% Transect stacked area setting:------------------------------------------
%  The is the configuration file for the marvl_plot_transect.m function.
% -------------------------------------------------------------------------
transectSA.thevars = {...
    'WQ_PHY_GRN';...
    'WQ_PHY_DINO';...
    'WQ_PHY_MDIAT';...
    'WQ_PHY_CRYPT';...
    'WQ_PHY_BGA';...
    };
transectSA.thelabels = {...
    'Green Algae';...
    'Dino';...
    'Diatom';...
    'Crypt';...
    'Cyano';...
    };
transectSA.thevars_conv = 12./[50 50 50 50 50];

transectSA.varname = {...
    'WQ_DIAG_PHY_TCHLA','TChla (\mug/L)';...
    };
transectSA.add_human = 1;

transectSA.polygon_file = '../gis/New_Curtain_line_LL_Dist.shp';
% Add field data to figure
transectSA.plotvalidation = 1; % 1 or 0
transectSA.pred_lims = [0.05,0.25,0.5,0.75,0.95];

transectSA.isRange = 1;
transectSA.istitled = 1;
transectSA.isylabel = 1;
transectSA.islegend = 0;
transectSA.isYlim = 1;
transectSA.isHTML = 1;
transectSA.isSurf = 1; %plot surface (1) or bottom (0)
transectSA.isSpherical = 1;
transectSA.use_matfiles = 0;
transectSA.add_obs_num = 1;
%config.boxon = 1;

% ___
transectSA.outputdirectory = '../outputs/transectSA/RAW/';
transectSA.htmloutput = '../outputs/transectSA/HTML/';

% plotting configuration
transectSA.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
transectSA.boxlegend = 'southeast';
transectSA.rangelegend = 'northwest';
transectSA.dimensions = [20 10]; % Width & Height in cm

for i=1:12
transectSA.pdates(1).value = [datenum(2013,i,01) datenum(2013,i+1,01)];i=i+1;
end

transectSA.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.
transectSA.binradius = 0.5;% in km;


%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.
transectSA.linedist = 1500;%  in m

transectSA.xtickManual = 1;  % 1: use manual x labels'; 0: use distance
transectSA.xlim = [0 27.3];% xlim in KM
transectSA.xticks = [0    6.36   13.06   20.12   27.0]; %[0:5:45];
transectSA.xticklabels = {'offshore','Cape Peron','central CS','Coogee','Fremantle'};
transectSA.xlabel = 'Distance from Southern CS (km)';

% ylim
transectSA.cAxis(1).value = [0 10];

MARVLs.transectSA = transectSA; clear transectSA;

%% Site profiling setting:------------------------------------------
%  The is the configuration file for the marvl_plot_profile.m function.
% -------------------------------------------------------------------------
for vvvv=1:length(MARVLs.master.varname)
    profile.cAxis(vvvv).value = [ ];
end

profile.start_plot_ID = 1;
profile.end_plot_ID = 1;

profile.sitenames={'Cockburn','Swan'};
profile.siteX=[115.7265, 115.8178]; %[ 380000, 388340];
profile.siteY=[-32.2264, -32.0059]; %6433760,6458300];

profile.plotvalidation = false; % Add field data to figure (true or false)
profile.plotmodel = 1;

profile.filetype = 'eps';
profile.expected = 1; % plot expected WL

profile.isHTML = 1;

profile.datearray = datenum(2013,1,15:1:20);

profile.dateformat = 'dd/mm/yyyy';

profile.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
profile.istitled = 1;
profile.isylabel = 1;
profile.islegend = 1;
profile.isYlim   = 1;
profile.isGridon = 1;
profile.dimensions = [20 10]; % Width & Height in cm

profile.outputdirectory = './Outputs/profile/RAW/';
profile.htmloutput = './Outputs/profile/HTML/';

MARVLs.profile = profile; clear profile;

%% Sheet plotting setting:------------------------------------------
%  The is the configuration file for the marvl_plot_sheet.m function.
% -------------------------------------------------------------------------
sheet.cAxis(2).value = [23 28]; %[35.5 36.5];
sheet.start_plot_ID = 2;
sheet.end_plot_ID = 2;

sheet.style = 'm_map'; % choose 'm_map'(default) or 'none' to use 'm_map14' library
sheet.add_ruler = 1;   % 1/0: add/no ruler (default), work only for m_map option
sheet.plotdepth = {'surface'};  %  {'surface','bottom'} Cell-array with either one
sheet.meshstype = 'patch'; % choose 'patch' or 'meshgrid'
sheet.add_quiver = 1;  % 1/0: add/no current vector, work only for 'meshgrid' option
sheet.add_coastline = 1;  % 1/0: add/no coast line
sheet.coastline_file = './GIS/Boundary.shp';  % 1/0: add/no coast line

sheet.plottype = 'movie'; % choose 'movie' or 'figure';
sheet.xlim=[115.6666  115.7786]; %[115.6089  115.7786];  %
sheet.ylim=[-32.3000  -32.1333]; %[-32.3206  -31.9921];  %
          
if strcmpi(sheet.plottype,'movie')
    sheet.FileFormat='mp4'; % choose 'mp4' or 'avi'
    sheet.Quality   =100;   % movie quality
    sheet.FrameRate =4;     % frame rate
    sheet.resolution = [1024,768]; % frame rosolution
    sheet.colormap = 'turbo'; % colormap options, see Matlab manual
    sheet.save_images = 1;  % option to save slide images
    sheet.datearray = [datenum(2013,01,15) datenum(2013,01,20)];
    sheet.dateformat = 'mm/yyyy';
    sheet.plot_interval = 1;
elseif strcmpi(sheet.plottype,'figure')
    sheet.datearray = [datenum(2013,01,15) datenum(2013,01,16)];
    sheet.resolution = [1024,768]; % frame rosolution
    sheet.colormap = 'turbo'; % colormap options, see Matlab manual
else
    msg=['Error: type of ',sheet.plottype,' is not recognized'];
    error(msg);
end

sheet.outputdirectory = './Outputs/sheet_patch_zoomin_TEMP/';

sheet.clip_depth = 0.05; % remove the shallow NaN cells 1000; %

sheet.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
sheet.istitled = 1;
sheet.isColorbar = 1;
sheet.colorbarposition = [0.86 0.25 0.02 0.5];

sheet.isAxison = 1;
sheet.dimensions = [15 20]; % Width & Height in cm

MARVLs.sheet = sheet; clear sheet;

%% Curtain plotting setting:------------------------------------------
%  The is the configuration file for the marvl_plot_curtain.m function.
% -------------------------------------------------------------------------
curtain.start_plot_ID = 2;
curtain.end_plot_ID = 2;
curtain.cAxis(2).value =[23 26];    %[35.5 36.5];
%curtain.geofile = '.\data\csiem_100_A_20130101_20130601_WQ_009_diag_geo.nc';
curtain.polyline = '.\GIS\New_Curtain_line_LL_Dist.shp';
curtain.isSpherical = 1;
curtain.meshstype = 'meshgrid'; % choose 'patch' or 'meshgrid'
curtain.add_quiver = 1;  % 1/0: add/no current vector, work only for 'meshgrid' option
curtain.plottype = 'movie'; % choose 'movie' or 'slide';

if strcmpi(curtain.plottype,'movie')
    curtain.FileFormat='mp4'; % choose 'mp4' or 'avi'
    curtain.Quality   =100;   % movie quality
    curtain.FrameRate =4;     % frame rate
    curtain.resolution = [1024,768]; % frame rosolution
    curtain.colormap = 'turbo'; % colormap options, see Matlab manual
    curtain.save_images = 1;  % option to save slide images
    curtain.datearray = [datenum(2013,01,15) datenum(2013,01,25)];
    curtain.dateformat = 'mm/yyyy';
    curtain.plot_interval = 1;
elseif strcmpi(curtain.plottype,'slide') % print selected time slide
    curtain.datearray = [datenum(2013,01,15)];
    curtain.resolution = [1024,768]; % frame rosolution
    curtain.colormap = 'turbo'; % colormap options, see Matlab manual
    curtain.save_images = 1;  % option to save slide images
else
    msg=['Error: type of ',curtain.plottype,' is not recognized'];
    error(msg);
end

curtain.outputdirectory = './Outputs/curtain_meshgrid_newtest_TEMP_dist/';

curtain.clip_depth = 0.05; % remove the shallow NaN cells
curtain.max_depth = -24;   % maximum depth along the curtain

curtain.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
curtain.istitled = 1;
curtain.isColorbar = 1;
curtain.colorbarposition = [0.2 0.06 0.6 0.02];
curtain.xtickManual = 1;  % 1: use manual x labels'; 0: use distance
curtain.xlim = [0 27.3];% xlim in KM
curtain.xticks = [0    6.36   13.06   20.12   27.0]; %[0:5:45];
curtain.xticklabels = {'offshore','Cape Peron','central CS','Coogee','Fremantle'};
curtain.xlabel = 'Distance from CS South (km)';
curtain.ylim = [-24 2];% xlim in KM
%curtain.isAxison = 1;
curtain.dimensions = [20 10]; % Width & Height in cm
%curtain.colorbarposition = [0.92 0.25 0.01 0.45];

MARVLs.curtain = curtain; clear curtain;

%% Transect exceedance setting:-----------------------------------------------------
%  The is the configuration file for the marvl_plot_transect.m function.
% -------------------------------------------------------------------------

transectExc.start_plot_ID = 14;
transectExc.end_plot_ID = 14;

transectExc.polygon_file = '.\GIS\New_Curtain_line_LL_Dist.shp';
% Add field data to figure
transectExc.plotvalidation = 0; % 1 or 0
transectExc.pred_lims = [0.05,0.25,0.5,0.75,0.95];

transectExc.isRange = 1;
transectExc.istitled = 1;
transectExc.isylabel = 1;
transectExc.islegend = 0;
transectExc.isYlim = 1;
transectExc.isHTML = 1;
transectExc.isSurf = 1; %plot surface (1) or bottom (0)
transectExc.isSpherical = 1;
transectExc.use_matfiles = 0;
transectExc.add_obs_num = 1;
%config.boxon = 1;

transectExc.thresh(14).value = [1.2 1.6];
transectExc.thresh(14).legend = {'%time > 1.2 mg/L',...
    '%time > 1.6 mg/L'};
% ___
transectExc.outputdirectory = './Outputs/transect_exceedance/RAW/';
transectExc.htmloutput = './Outputs/transect_exceedance/HTML/';

% plotting configuration
transectExc.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
transectExc.boxlegend = 'southeast';
transectExc.rangelegend = 'northwest';
transectExc.dimensions = [20 10]; % Width & Height in cm

i=1;
transectExc.pdates(1).value = [datenum(2013,01,15) datenum(2013,01,20)];i=i+1;
%transectExc.pdates(2).value = [datenum(2021,07,01) datenum(2021,07,15)];i=i+1;
%transectExc.pdates(3).value = [datenum(2021,07,16) datenum(2021,08,01)];i=i+1;

transectExc.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.
transectExc.binradius = 0.5;% in km;


%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.
transectExc.linedist = 1500;%  in m
transectExc.xtickManual = 1;  % 1: use manual x labels'; 0: use distance
transectExc.xlim = [0 27.3];% xlim in KM
transectExc.xticks = [0    6.36   13.06   20.12   27.0]; %[0:5:45];
transectExc.xticklabels = {'offshore','Cape Peron','central CS','Coogee','Fremantle'};
transectExc.xlabel = 'Distance from Southern CS (km)';

% ylim
for vvvv=1:size(MARVLs.master.varname,1)
    transectExc.cAxis(vvvv).value = [ ];
end

transectExc.ncfile(1).symbol = {'-'};
transectExc.ncfile(1).translate = 1;
transectExc.ncfile(1).colour = [166,86,40]./255;% Surface and Bottom
transectExc.ncfile(1).edge_color = [166,86,40]./255;
transectExc.ncfile(1).col_pal_color =[[176 190 197]./255;[162 190 197]./255;[150 190 197]./255;[150 190 197]./255];

MARVLs.transectExc = transectExc; clear transectExc;

%% Boxchart plot setting:-----------------------------------------------------
%  The is the configuration file for the marvl_boxchart.m function.
% -------------------------------------------------------------------------

boxchartConf.start_plot_ID = 2;
boxchartConf.end_plot_ID = 4;

% reading polygon and NC files, 'W:\' is the 'Projects2' drive
boxchartConf.polygon_file = '../gis/MLAU_Zones_v2_ll.shp';
boxchartConf.cattt=["CS02","CS03","CS04","CS05","CS06","CS07","CS08","CS09","CS10","CS11",...
    "CS12","CS13","CS14","CS15","CS16","CS17","CS18","CS19","CS20","CS21","CS22","CS23",...
    "CS24","SC1","sc2","sc3","sc4"];

% time period to extract data
boxchartConf.datearray = [datenum(2013,4,1) datenum(2013,5,1)];
% ylim
for vvvv=1:size(MARVLs.master.varname,1)
    boxchartConf.cAxis(vvvv).value = [0 1];
end
boxchartConf.cAxis(2).value = [30 40];
boxchartConf.cAxis(3).value = [20 28];
boxchartConf.cAxis(4).value = [3 8];
boxchartConf.cAxis(5).value = [0 0.02];
boxchartConf.cAxis(6).value = [0 0.02];
%boxchartConf.ylimits= [40 40 10 0.02 0.02]; %[0.15 0.03  2.0  2.0  80  4 0.05  5];
%boxchartConf.axisLim2=[40 40 10 0.02 0.02]; %[0.08 0.02  0.8  0.8  60  3 0.04  4];
%boxchartConf.axisInt2=[10 10 2 0.01 0.01]; %[0.02 0.01  0.2  0.2  20  1 0.01  1];

boxchartConf.legendLoc = 'southeast'; % Width & Height in cm
boxchartConf.dimensions = [28 7.5]; % Width & Height in cm
boxchartConf.outputdirectory = '../outputs/boxchart2/RAW/';

MARVLs.boxchartConf = boxchartConf; clear boxchartConf;

%% Nutrient Budgeting setting:-----------------------------------------------------
%  The is the configuration file for the marvl_plot_nutrient_budget.m function.
% -------------------------------------------------------------------------

% 3D vars name for C pool
NBudget.Pool_3D={'WQ_OGM_DON','DON';...
    'WQ_OGM_DONR','DONR';...
    'WQ_OGM_PON','PON';...
    'WQ_NIT_NIT','NIT';...
    'WQ_NIT_AMM','AMM';...
    };
NBudget.Pool_3D_factors=[1 1 1 1 1]*14/1e9;

% % 2D vars name for C pool
% config.Pool_2D={'WQ_DIAG_MAC_MAC_BEN',...
%     'WQ_DIAG_MAG_IN_BEN',...
%     'WQ_DIAG_PHY_MPB_BEN',...
%     'MPB_BENXNC',...
%     };
% config.Pool_2D_factors=[16/106 1 16/106 1]*14/1e9;

% 3D vars name for C BGC process
NBudget.BGC_3D={'WQ_DIAG_NIT_ANAMMOX','ANAMMOX';...
        'WQ_DIAG_NIT_DENIT','DENIT';...
        'WQ_DIAG_NIT_DNRA','DNRA';...
        'WQ_DIAG_NIT_NITRIF','NITRIF';...
    };

NBudget.BGC_3D_factors=[1 1 1 1]*14/1e9;

% 2D vars name for BGC process
NBudget.BGC_2D={'WQ_DIAG_NIT_SED_AMM','SED-AMM';...
        'WQ_DIAG_NIT_SED_NIT','SED-NIT';...
    };
NBudget.BGC_2D_factors=[1 1]*14/1e9;


NBudget.polygon_file = 'E:\database\AED-MARVl-v0.3\Examples\Cockburn\GIS\Cockburn_Sites_2021.shp';
NBudget.plotAllsites = 0;
if NBudget.plotAllsites == 0
    NBudget.plotsite = [5];
end

NBudget.inputdirectory = 'E:\database\AED-MARVl-v0.3\Examples\Cockburn\Data\nutrient_budget\matfiles_kw001\';
NBudget.outputdirectory = 'E:\database\AED-MARVl-v0.3\Examples\Cockburn\plotting2\NutrientBudget\';

% plotting configuration
NBudget.datearray = datenum(2021,06,01:15:61);
NBudget.dateformat = 'dd/mm/yyyy';

NBudget.dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
NBudget.istitled = 1;
NBudget.isylabel = 1;
NBudget.islegend = 1;
NBudget.isYlim   = 1;
NBudget.isGridon = 1;
NBudget.dimensions = [20 10]; % Width & Height in cm

NBudget.legendlocation = 'northeastoutside';

MARVLs.NBudget = NBudget; clear NBudget;
