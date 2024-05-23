

filelist = dir(['Z:\PEEL\','*.nc']);

int = 1;

for i = 1:length(filelist)
    ncfile(int).name = ['Z:\PEEL\',filelist(i).name];
    ncfile(int).symbol = {'-';'--'};
    ncfile(int).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
    ncfile(int).legend = 'v11';
    ncfile(int).translate = 1;
    int = int + 1;
end