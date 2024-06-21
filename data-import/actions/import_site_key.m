function import_site_key


sitekey.imosbgc = read_site_sheet('IMOSBGC');
sitekey.imosamnm = read_site_sheet('IMOSAMNM');

sitekey.mafrl = read_site_sheet('MAFRL');
sitekey.bom = read_site_sheet('BOM');
sitekey.dwer = read_site_sheet('DWER');
sitekey.dwermooring = read_site_sheet('DWERMOORING');
sitekey.wc = read_site_sheet('WC');
sitekey.wwmsp5 = read_site_sheet('WWMSP5');
sitekey.wwmsp2 = read_site_sheet('WWMSP2');
sitekey.wwmsp3 = read_site_sheet('THEME3CTD');
sitekey.fpamqmp = read_site_sheet('FPA-MQMP');
sitekey.wwmsp2_seagrass = read_site_sheet('WWMSP2SG');

sitekey.dpird = read_site_sheet('DPIRD');

sitekey.dot = read_site_sheet('DOT');

sitekey.wwmsp5waves = read_site_sheet('WWMSP5.2WAVES');
sitekey.bmtswan = read_site_sheet('BMT-SWAN');
sitekey.wwmsp1wrf = read_site_sheet('WWMSP1.1-WFR');
sitekey.bombarraftv = read_site_sheet('BOM-BARRA');
sitekey.WWMSP31SedimentDeposition = read_site_sheet('WWMSP3.1-SedimentDeposition');




save sitekey.mat sitekey -mat;

end
function data = read_site_sheet(sheet)
    disp(sheet);

filename = '../../data-governance/site_key.xlsx';

dataout = readtable(filename,'Sheet',sheet,'NumHeaderLines',1,ReadVariableNames=false);

for i = 1:length(dataout.Var1)

    sitestr = dataout.Var1{i};

    data.(sitestr).AED = dataout.Var1{i};
    if ~isnumeric(dataout.Var2(i))
        data.(sitestr).ID = dataout.Var2{i};
    else
        data.(sitestr).ID = dataout.Var2(i);
    end
    data.(sitestr).Description = dataout.Var3{i};
    if ~isnumeric(dataout.Var4(i))
        data.(sitestr).Shortname = dataout.Var4{i};
    else
        data.(sitestr).Shortname = dataout.Var4(i);
    end
    data.(sitestr).X = dataout.Var5(i);
    data.(sitestr).Y = dataout.Var6(i);
    data.(sitestr).Lat = dataout.Var7(i);
    data.(sitestr).Lon = dataout.Var8(i);

    switch sheet
    case 'MAFRL'
        data.(sitestr).Depth =  dataout.Var9(i);
    end
end

%switch sheet
%
%    case 'MAFRL'
%        [snum,sstr] = xlsread(filename,sheet,'A2:I10000');
%
%        for i = 1:length(sstr)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = sstr{i,2};
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,1);
%            data.(sstr{i,1}).Y = snum(i,2);
%            data.(sstr{i,1}).Lat = snum(i,3);
%            data.(sstr{i,1}).Lon = snum(i,4);
%            data.(sstr{i,1}).Depth = snum(i,5);
%        end
%
%    case 'DWERMOORING'
%
%        [snum,sstr] = xlsread(filename,sheet,'A2:H10000');
%
%        for i = 1:size(sstr,1)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = snum(i,1);
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,4);
%            data.(sstr{i,1}).Y = snum(i,5);
%            data.(sstr{i,1}).Lat = snum(i,6);
%            data.(sstr{i,1}).Lon = snum(i,7);
%        end
%
%
%    case 'DWER'
%
%        [snum,sstr] = xlsread(filename,sheet,'A2:H10000');
%
%        for i = 1:size(sstr,1)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = snum(i,1);
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,4);
%            data.(sstr{i,1}).Y = snum(i,5);
%            data.(sstr{i,1}).Lat = snum(i,6);
%            data.(sstr{i,1}).Lon = snum(i,7);
%        end
%
%    case 'BOM'
%
%        [snum,sstr] = xlsread(filename,sheet,'A2:H10000');
%
%        for i = 1:size(sstr,1)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = snum(i,1);
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,4);
%            data.(sstr{i,1}).Y = snum(i,5);
%            data.(sstr{i,1}).Lat = snum(i,6);
%            data.(sstr{i,1}).Lon = snum(i,7);
%        end
%
%
%    case 'WWMSP5.2WAVES'
%
%        [snum,sstr] = xlsread(filename,sheet,'A2:H10000');
%
%        for i = 1:size(sstr,1)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = sstr{i,2};
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,4);
%            data.(sstr{i,1}).Y = snum(i,5);
%            data.(sstr{i,1}).Lat = snum(i,6);
%            data.(sstr{i,1}).Lon = snum(i,7);
%        end
%    otherwise
%        [snum,sstr] = xlsread(filename,sheet,'A2:H10000');
%
%        for i = 1:size(sstr,1)
%            data.(sstr{i,1}).AED = sstr{i,1};
%            data.(sstr{i,1}).ID = sstr{i,2};
%            data.(sstr{i,1}).Description = sstr{i,3};
%            data.(sstr{i,1}).Shortname = sstr{i,4};
%            data.(sstr{i,1}).X = snum(i,1);
%            data.(sstr{i,1}).Y = snum(i,2);
%            data.(sstr{i,1}).Lat = snum(i,3);
%            data.(sstr{i,1}).Lon = snum(i,4);
%        end
%
%end


end




