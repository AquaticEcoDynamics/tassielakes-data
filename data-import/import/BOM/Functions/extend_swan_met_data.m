clear all; close all;

load metdata_bk.mat;


site = 'airport';

vars = fieldnames(metdata.(site));

sss = find(metdata.(site).Date >= datenum(2014,01,01));

for i = 1:length(vars)
    if strcmpi(vars{i},'lat') == 0 & strcmpi(vars{i},'lon') == 0
        newdata.(vars{i})(:,1) = metdata.(site).(vars{i})(1:sss(1)-1);
    end
end

vars = fieldnames(newdata);

yArray = [2012:01:2034];

vDate = datevec(newdata.Date);

for i = 1:length(yArray)
    
    com_year = yArray(i) - 4;
    
    disp(['Converting ',num2str(com_year),' to ',num2str(yArray(i))]);
    
    ttt = find(vDate(:,1) == com_year);
    
    for j = 1:length(vars)
        a.(vars{j}) = newdata.(vars{j})(ttt);
    end
    
    aVec = vDate(ttt,:);
    aVec(:,1) = yArray(i);
    a.Date(:,1) = datenum(aVec);
    
    for j = 1:length(vars)
        newdata.(vars{j}) = [newdata.(vars{j}); a.(vars{j})];
    end
    clear a aVec;
end
   

[~,ind] = unique(newdata.Date);

for i = 1:length(vars)
   
    metdata.(site).(vars{i}) = newdata.(vars{i})(ind);
end
    
save metdata.mat metdata -mat;
    
    
    





