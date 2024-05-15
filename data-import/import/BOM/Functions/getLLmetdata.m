function getLLmetdata(sMetDir)
% Function to import the swan met data and save to a structured type
% swanmet.mat
% sMetDir is the file path in which the BoM data files are stored. Remember
% to add "\" at the end of the path!!!
% Add or remove headers under cHeader based on your data. Import of Date in
% the right format should be checked!

dirlist = dir(sMetDir);

for iMet = 3:length(dirlist)
    
    disp(['Processing File ',num2str(iMet - 2)]);
    filename = [sMetDir,dirlist(iMet).name];
    fid = fopen(filename,'rt');

cHeader = { ...
        'Station';...
        'Date';...
        'AirTemperature';...
        'AppTemperature';...
        'DewPoint';...
        'RelativeHumidity';...
        'DeltaT';...
        'SoilTemperature';...
        'Solar_Rad';...
        'WindSpeed';...
        'WindSpeed_Max';...
        'WindDir';...
        'AirPressure';...
        'Rain';...
        'LeafWet';...
        'NA';...
        }; 
x  = length(cHeader);
    textformat = [repmat('%s ',1,x)];
    datacell = textscan(fid,textformat,...
        'Headerlines',1,...
        'Delimiter',',');
    fclose(fid);
    
   for iHeader = 1:length(cHeader)
    if strcmp(cHeader{iHeader},'Date') == 1
          met.(cHeader{iHeader}) = datenum(datacell{iHeader},'dd/mm/yyyy HH:MM');
    elseif strcmp(cHeader{iHeader},'Station') == 1
          met.(cHeader{iHeader}) = datacell{iHeader};
    else
          met.(cHeader{iHeader}) = str2double(datacell{iHeader});
    end
    
   end

       [Date_uni,ia] = unique(met.Date); 
       nHeader = fieldnames(met);
       for ii = 3:length(nHeader)
           disp(nHeader{ii});
           met1.(nHeader{ii}) = met.(nHeader{ii})(ia);
       end

       met1.Date = Date_uni;
       met1.Station = met.Station{1};

       nSiteID = met1.Station;
    
    switch nSiteID
        case 'narrung'
            llmetdata.narrung = met1;
            llmetdata.narrung.lat = -35.571240;
            llmetdata.narrung.lon = 139.173606;
        case 'cadell'
            llmetdata.cadell = met1;
            llmetdata.cadell.lat = -34.044935;
            llmetdata.cadell.lon = 139.729249;
        case 'swan_reach'
            llmetdata.swan_reach = met1;
            llmetdata.swan_reach.lat = -34.571838;
            llmetdata.swan_reach.lon = 139.615968;
        case 'caurnamont'
            llmetdata.caurnamont = met1;
            llmetdata.caurnamont.lat = -34.831678; 
            llmetdata.caurnamont.lon = 139.534169;
        case 'mypolonga'
            llmetdata.mypolonga = met1;
            llmetdata.mypolonga.lat = -34.948828;
            llmetdata.mypolonga.lon = 139.339162;
        case 'langhorne_crk'
            llmetdata.langhorne_crk = met1;
            llmetdata.langhorne_crk.lat = -35.282459;
            llmetdata.langhorne_crk.lon = 139.037038;
        case 'currency_crk'
            llmetdata.currency_crk = met1;
            llmetdata.currency_crk.lat = -35.424706;
            llmetdata.currency_crk.lon = 138.758260;

        otherwise
            disp('StationID not found');
    end       
   
end   
   save llmetdata.mat llmetdata -mat -v7