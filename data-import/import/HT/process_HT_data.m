clear all; close all;

filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/Inflow.csv';

flowdata = import_HT_file(filename);

flowdata.m3 = flowdata.Var4 * (1000/(60*60));


filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/DO(%).csv';
dodata = import_HT_file(filename);

filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/chloro_a.csv';
CHLAdata = import_HT_file(filename);

filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/turbidity.csv';
turbdata = import_HT_file(filename);

filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/Water Temp.csv';
tempdata = import_HT_file(filename);

filename =  '../../../data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/salinity.csv';
saldata = import_HT_file(filename);

outtime = datenum(2018,01,01):01:datenum(2024,04,01);

fdata = interp1(flowdata.mtime,flowdata.m3,outtime);
tdata = interp1(tempdata.mtime,tempdata.Var4,outtime);
sdata = interp1(saldata.mtime,saldata.Var4,outtime);
fdata(fdata<0) = 0;
fid = fopen('Arthurs_Spillway.csv','wt');
fprintf(fid,'ISOTime,Flow,Sal,Temp\n');
for i = 1:length(outtime)
    fprintf(fid,'%s,%4.4f,%4.4f,%4.4f\n',datestr(outtime(i),'dd/mm/yyyy HH:MM'),fdata(i),sdata(i),tdata(i));
end
fclose(fid);


