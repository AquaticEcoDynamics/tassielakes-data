function [mface,mcolor,agencyname] = sort_agency_information_Coorong(agency)

switch agency
    
    % Coorong
    case 'ALS'
        mface = 'ok';
        mcolor = [190 174 212]/255;
       % agency = 'DEW ALS';
    case 'AWQC (DEW)'
        mface = 'sk';
        mcolor = [190 174 212]/255;   
       % agency = 'DEW AWQC';
    case 'DEW WDSA Hydro'
        mface = 'dk';
        mcolor = [190 174 212]/255;        
   case 'DEW WDSA Met'
        mface = '^k';
        mcolor = [190 174 212]/255; 
    case 'DEW WDSA Sonde'
         mface = 'vk';
        mcolor = [190 174 212]/255;
		
		
		
    case 'SA Water'
         mface = 'ok';
        mcolor = [253 192 134]/255;

	case 'FU TLM'
		mface = 'sk';
        mcolor = [253 192 134]/255;
	
	case 'UA HCHB'
		 mface = 'dk';
        mcolor = [253 192 134]/255;	
		
		

    case 'UA Logger'
         mface = 'ok';
        mcolor = [232/255 90/255 24/255];
    case 'UA WQ'
         mface = 'dk';
        mcolor = [232/255 90/255 24/255];
    case 'UA Sonde'
         mface = 'sk';
        mcolor = [232/255 90/255 24/255];
    case 'UA Logger'
         mface = '^k';
        mcolor = [232/255 90/255 24/255];
    case 'UA Sediment'
         mface = 'vk';
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
        
        
       