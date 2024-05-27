addpath(genpath('Functions'))

% writeTFVMetcsv(datenum(1970,01,01),datenum(1984,01,01),7.5,'mandurah_combined','airport','Clouds');
% 
% writeTFVMetcsv(datenum(1990,01,01),datenum(2017,01,01),7.5,'mandurah_combined','airport','Clouds');

datalake = '../../../data-lake/BOM/IDY/';

importBoMmetdata(datalake);


writeTFVMetcsv(datenum(2013,01,01),datenum(2024,05,01),10,'LIAWENEE','LAUNCESTONAIRPORT','Clouds');
%writeTFVMetcsv(datenum(2014,01,01),datenum(2017,07,01),10,'LAUNCESTONAIRPORT');


% close all;
% 
% writeTFVMetcsv(datenum(1994,01,01),datenum(1999,01,01),7.5,'jandakot','airport','Clouds');
% close all;
% 
% writeTFVMetcsv(datenum(1994,01,01),datenum(1999,01,01),7.5,'airport','airport','Clouds')