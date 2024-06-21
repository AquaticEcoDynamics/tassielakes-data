function[ydata,units,isConv,ylab] = tfv_Unit_Conversion(ydata,varname)
% A Simple function to plug into the plottfv_prof function to convert model
% and field data on the fly.
%
% Simply add to the switch function to add more units.

isConv = 1;

[snum,sstr] = xlsread('Variable_Conversions.xlsx','A2:E10000');

conv = snum(:,1);

oldvar = sstr(:,1);
newvar = sstr(:,2);
newunits = sstr(:,3);

symbol = sstr(:,5);

sss = find(strcmpi(oldvar,varname) == 1);


if isempty(sss)
    ydata = ydata * 1;
    units = [];
    isConv = 0;
    ylab = varname;
else
    ydata = ydata * conv(sss);
    units = newunits{sss};
    if ~isempty(symbol{sss})
        ylab = symbol{sss};
    else
        ylab = newvar{sss};
    end
end





% switch varname
%  	case 'D'
% 		ydata = ydata * 1;
% 		units = 'm';   
% 		
% 	case 'ECOLI_PASSIVE'
% 		ydata = ydata * 1;
% 		units = 'cfu/100mL';
% 		
% 	case 'ENTEROCOCCI_PASSIVE'
% 		disp('hi');
% 		ydata = ydata * 1;
% 		units = 'cfu/100mL';
%     
%     %
%     case  'SAL'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (1);
%         units = 'psu';
%     case  'TEMP'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (1);
%         units = 'C';    
%     
%     case  'WQ_OXY_OXY'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (32/1000);
%         units = 'mg/L';
%     case  'WQ_OXY_SAT'
%         % mmol/m^3 to mg/L
%         ydata = ydata * 1;
%         units = '%';        
%     case  'WQ_OGM_DON'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%      case  'WQ_OGM_DONR'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';       
%     case  'WQ_OGM_DOC'
%         % mmol/m^3 to mg/L
%         ydata = ydata / 83.333333;
%         units = 'mg/L';
%         
%     case  'WQ_OGM_POC'
%         % mmol/m^3 to mg/L
%         ydata = ydata / 83.333333;
%         units = 'mg/L';
%         
%         
%     case 'WQ_OGM_DOP'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'WQ_SIL_RSI'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (28.1/1000);
%         units = 'mg/L';
%         
%     case 'TN'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%         
%     case 'WQ_NIT_AMM'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%     case 'WQ_NIT_NIT'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%         
%     case 'WQ_DIAG_PHY_TCHLA'
%         ydata = ydata;
%         units = 'ug/L';
%         
%         
%     case 'WQ_PHS_FRP'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'WQ_PHS_FRP_ADS'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'WQ_OGM_POP'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%         
%     case 'WQ_OGM_PON'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%         
%     case 'WQ_OGM_DOCR'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (12/1000);
%         units = 'mg/L';
%         
%     case 'WQ_OGM_DONR'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%         
%     case 'WQ_OGM_DOPR'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'ON'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%         
%     case 'OP'
%         % mmol/m^3 to mg/L
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'WQ_DIAG_TOT_TP'
%         ydata = ydata * (31/1000);
%         units = 'mg/L';
%         
%     case 'WQ_DIAG_TOT_TN'
%         ydata = ydata * (14/1000);
%         units = 'mg/L';
%     case 'WQ_DIAG_TOT_TKN'
%         ydata = ydata * (14/1000);
%         units = 'mg/L';        
%     case 'WQ_DIAG_TOT_TOC'
%         ydata = ydata * (12/1000);
%         units = 'mg/L';
%         
%     case 'WQ_DIAG_TOT_TURBIDITY'
%         ydata = ydata * 1;
%         units = 'NTU';
%     case 'WQ_DIAG_TOT_TSS'
%         ydata = ydata * 1;
%         units = 'mg/L';
% 	case 'TSS'
%         ydata = ydata * 1;
%         units = 'mg/L';
%     case 'WQ_NCS_SS1'
%         ydata = ydata * 1;
%         units = 'mg/L';
%     case 'WQ_TRC_AGE'
%         ydata = ydata * 1/86400;
%         units = 'Days';
%         
%     case 'TN_TP'
%         ydata = ydata * 1;
%         units = 'mg/L';
%     case 'TN_CHX'
%         ydata = ydata * (14/1000);
%         units = 'mg/L';        
%         %     case 'SAL'
%         %         %PPT to uS/cm
%         %           ydata = ydata * (31/1000);
%         %         units = 'mg/L';
%         %
%         
%     otherwise
%         %  disp(['No Conversion Made for: ',varname]);
%         
%         ydata = ydata .* 1;
%         units = [];
%         isConv = 0;
%         
%         
%         
% end



