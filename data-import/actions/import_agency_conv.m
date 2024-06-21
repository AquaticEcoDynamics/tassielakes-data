function data = import_agency_conv(sheet)

filename = '../../data-governance/variable_key.xlsx';

if strcmpi(sheet,'MAFRL') == 0

    [snum,sstr] = xlsread(filename,sheet,'A2:D10000');


    for i = 1:length(sstr(:,1))
        varid = ['var',num2str(i)];
        if strcmpi(sstr{i,3},'JUNK') == 0
            data.(varid).Old = sstr{i,1};
            data.(varid).ID = sstr{i,3};
            data.(varid).Conv = snum(i,1);
        end
    end
    
else
    [snum,sstr] = xlsread(filename,sheet,'A2:E10000');
     for i = 1:length(sstr(:,1))
        varid = ['var',num2str(i)];

        if strcmpi(sstr{i,3},'JUNK') == 0
            data.(varid).Old = sstr{i,1};
            data.(varid).Depth = sstr{i,end};
            data.(varid).Conv = snum(i,1);
            data.(varid).ID = sstr{i,3};

        end
     end   
    
end