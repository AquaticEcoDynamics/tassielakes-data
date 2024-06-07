function data = import_HT_file(filename)

fid = fopen(filename,'rt')
x  = 5;
textformat = [repmat('%s ',1,x)];
datacell = textscan(fid,textformat,...
    'Headerlines',1,...
    'Delimiter',',');
fclose(fid);

data = readtable(filename);

data.mtime = datenum(data.Var1) + datenum(data.Var3);
