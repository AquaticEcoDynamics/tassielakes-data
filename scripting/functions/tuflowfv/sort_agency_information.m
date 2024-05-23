function [mface,mcolor,agencyname] = sort_agency_information(agency)


switch agency
    
    % Peel Swan
    case 'WIR'
        mface = 'ok';
        mcolor = [255/255 61/255 9/255];
    case 'DEW WDSA Sonde'
        mface = 'ok';
        mcolor = [255/255 61/255 9/255];   
        
    case 'DEW WDSA Met'
        mface = 'pk';
        mcolor = [255/255 61/255 9/255];  
        
   case 'DEW WDSA Hydro'
        mface = 'dk';
        mcolor = [255/255 61/255 9/255]; 
    case 'MAFRL'
         mface = 'pk';
        mcolor = [232/255 90/255 24/255];
    case 'SA EPA'
         mface = 'pk';
        mcolor = [232/255 90/255 24/255];
    case 'SCU'
         mface = 'dk';
        mcolor = [255/255 111/255 4/255];
    case 'UA WQ'
         mface = 'dk';
        mcolor = [255/255 111/255 4/255];
    case 'MU'
         mface = 'sk';
        mcolor = [232/255 90/255 24/255];
    case 'UA Logger'
         mface = 'sk';
        mcolor = [232/255 90/255 24/255];
     % Erie   
    case     'ECCC'
         mface = 'ok';
        mcolor = [255/255 61/255 9/255];
    case     'DEW SONDE'
         mface = 'ok';
        mcolor = [255/255 61/255 9/255];        
    case 'ECCC-CGM'
         mface = 'sk';
        mcolor = [255/255 61/255 9/255];
        
    case 'ECCC-PAR'
         mface = 'pk';
        mcolor = [255/255 61/255 9/255];
        
    case 'ECCC-WQ'
         mface = 'hk';
        mcolor = [255/255 61/255 9/255];
    case 'ECCC-YSI'
         mface = 'dk';
        mcolor = [255/255 61/255 9/255];
        
    case 'EPA'
         mface = 'dk';
        mcolor = [255/255 61/255 9/255];
        
    case 'OTHER'
         mface = '^k';
        mcolor = [255/255 61/255 9/255];
    case 'SWC' %Hawkesbury
        mface = 'ok';
        mcolor = [255/255 61/255 9/255];
	case 'SWC-ww' %Hawkesbury
        mface = 'dk';
        mcolor = [255/255 61/255 9/255];
    case 'DPIE-mc'
        mface = '^k';
        mcolor = [255/255 61/255 9/255];
     case 'DPIE-sc'
        mface = '^k';
        mcolor = [255/255 61/255 9/255];   
    case 'WNSW'
         mface = 'sk';
        mcolor = [255/255 61/255 9/255];
        
    case 'BC'
         mface = '>k';
        mcolor = [255/255 61/255 9/255];  
        
    case 'DPIE-bouy'
         mface = 'pk';
        mcolor = [255/255 61/255 9/255];
        
    case 'Hornsby'
         mface = 'hk';
        mcolor = [255/255 61/255 9/255];
    otherwise
           mface = 'ok';
        mcolor = [255/255 61/255 9/255];
        
end

agencyname = agency;
        
        
       