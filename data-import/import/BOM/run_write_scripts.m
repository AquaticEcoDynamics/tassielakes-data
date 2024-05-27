addpath(genpath('Functions'))

% writeTFVMetcsv(datenum(1970,01,01),datenum(1984,01,01),7.5,'mandurah_combined','airport','Clouds');
% 
% writeTFVMetcsv(datenum(1990,01,01),datenum(2017,01,01),7.5,'mandurah_combined','airport','Clouds');

datalake = '../../../data-lake/BOM/IDY/';

%importBoMmetdata(datalake);

mkdir('liawenee met output/');

import_write_rainfall('../../../data-lake/BOM/IDC/IDCJAC0009_096033_1800_Data.csv','liawenee met output/tfv_rain_liawenee.csv',datenum(2022,11,01),datenum(2024,05,01));
writeTFVMetcsv(datenum(2022,11,01),datenum(2024,05,01),10,'LIAWENEE','LAUNCESTONAIRPORT','Clouds');

 tfv_plot_met_infile('liawenee met output\tfv_met_LIAWENEE.csv','liawenee met output\tfv_rain_liawenee.csv','liawenee met output\liawenee.png');
%writeTFVMetcsv(datenum(2014,01,01),datenum(2017,07,01),10,'LAUNCESTONAIRPORT');


% close all;
% 
% writeTFVMetcsv(datenum(1994,01,01),datenum(1999,01,01),7.5,'jandakot','airport','Clouds');
% close all;
% 
% writeTFVMetcsv(datenum(1994,01,01),datenum(1999,01,01),7.5,'airport','airport','Clouds')