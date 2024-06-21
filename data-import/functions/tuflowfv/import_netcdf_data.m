function [data,fdata] = import_netcdf_data(ncfile,mod,varname,var,fdata,loadname,allvars,single_precision,use_matfiles)

if ~use_matfiles


	switch varname{var}
					
		case 'OXYPC'
			
			oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_AED_OXYGEN_OXY'});clear functions
			tra = tfv_readnetcdf(ncfile(mod).name,'names',{'TRACE_1'});
			data.OXYPC = tra.TRACE_1 ./ oxy.WQ_AED_OXYGEN_OXY;
			clear tra oxy
			
		case 'WindSpeed'
			
			oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});clear functions
			data.WindSpeed = sqrt(power(oxy.W10_x,2) + power(oxy.W10_y,2));
			clear  oxy
			
		case 'WindDirection'
			
			oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});clear functions
			data.WindDirection = (180 / pi) * atan2(-1*oxy.W10_x,-1*oxy.W10_y);
			clear  oxy
			
		case 'WQ_DIAG_PHY_TCHLA'
			
			if sum(strcmpi(allvars,'WQ_DIAG_PHY_TCHLA')) == 0
				tchl = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN';'WQ_PHY_CRYPT';'WQ_PHY_DIATOM';'WQ_PHY_DINO';'WQ_PHY_BGA'});clear functions
				data.WQ_DIAG_PHY_TCHLA = (((tchl.WQ_PHY_GRN / 50)*12) + ...
					((tchl.WQ_PHY_CRYPT / 50)*12) + ...
					((tchl.WQ_PHY_DIATOM / 26)*12) + ...
					((tchl.WQ_PHY_DINO / 40)*12) + ...
					((tchl.WQ_PHY_BGA / 40)*12));
				clear tchl
			else
				data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
			end
			
		case 'V'
			
			oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'V_x';'V_y'});clear functions
			data.V = sqrt(power(oxy.V_x,2) + power(oxy.V_y,2));
			clear tra oxy
			
		case 'ON'
			
			%                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
			%                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
			%                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
			%                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
			%                 data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);
			DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});clear functions
			PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});clear functions
			data.ON = DON.WQ_OGM_DON + PON.WQ_OGM_PON;
			clear DON PON
			
			% case 'WQ_DIAG_TOT_TN'
			%
			%     %                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
			%     %                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
			%     %                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
			%     %                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
			%     %                 data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);
			%     NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
			%     AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
			%     DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});
			%     DONR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});
			%     PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});
			%     CPOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_CPOM'});
			%     GRN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
			%     BGA =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_BGA'});
			%     CRYPT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_CRYPT'});
			%     DIATOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_DIATOM'});
			%     DINO =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_DINO'});
			%     data.WQ_DIAG_TOT_TN = DON.WQ_OGM_DON + DONR.WQ_OGM_DONR + PON.WQ_OGM_PON + NIT.WQ_NIT_NIT + AMM.WQ_NIT_AMM + ...
			%         (CPOM.WQ_OGM_CPOM.* 0.005) + (GRN.WQ_PHY_GRN.*0.15) + (BGA.WQ_PHY_BGA.*0.15) + ...
			%         (CRYPT.WQ_PHY_CRYPT.*0.15) + (DIATOM.WQ_PHY_DIATOM.*0.15) + (DINO.WQ_PHY_DINO.*0.15);
			%     clear TN AMM NIT
			
		case 'OP'
			
			%                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
			%                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
			%                 data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
			DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});clear functions
			PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POP'});clear functions
			data.OP = DON.WQ_OGM_DOP + PON.WQ_OGM_POP;
			clear TP FRP
			
		case 'TN_CHX'
			TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});clear functions
			CPOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_CPOM'});clear functions
			data.TN_CHX = TN.WQ_DIAG_TOT_TN - CPOM.WQ_OGM_CPOM;
			clear TP FRP
			
		case 'WQ_OGM_DON'
			
			%                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
			%                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
			%                 data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
			DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});clear functions
			if sum(strcmpi(allvars,'WQ_OGM_DONR')) > 0
				DONR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});clear functions
				data.WQ_OGM_DON = DON.WQ_OGM_DON + DONR.WQ_OGM_DONR;
			else
				data.WQ_OGM_DON = DON.WQ_OGM_DON;% + DONR.WQ_OGM_DONR;
			end
			clear DON DONR
			
		case 'WQ_OGM_DOC'
			
			%                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
			%                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
			%                 data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
			DOC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOC'});clear functions
			if sum(strcmpi(allvars,'WQ_OGM_DOCR')) > 0
				DOCR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOCR'});clear functions
				data.WQ_OGM_DOC = DOC.WQ_OGM_DOC + DOCR.WQ_OGM_DOCR;
			else
				data.WQ_OGM_DOC = DOC.WQ_OGM_DOC;% + DOCR.WQ_OGM_DOCR;
			end
			clear DOC DOCR
			
		case 'WQ_OGM_DOP'
			
			%                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
			%                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
			%                 data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
			DOP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});clear functions
			if sum(strcmpi(allvars,'WQ_OGM_DOPR')) > 0
				DOPR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOPR'});clear functions
				data.WQ_OGM_DOP = DOP.WQ_OGM_DOP + DOPR.WQ_OGM_DOPR;
			else
				data.WQ_OGM_DOP = DOP.WQ_OGM_DOP;% + DOPR.WQ_OGM_DOPR;
			end
			clear DOP DOPR
			
		case 'TURB'
			
			SS1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NCS_SS1'});clear functions
			POC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POC'});clear functions
			GRN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});clear functions
			data.TURB = (SS1.WQ_NCS_SS1 .* 2.356)  + (GRN.WQ_PHY_GRN .* 0.1) + (POC.WQ_OGM_POC / 83.333333 .* 0.1);
			clear SS1 POC GRN
			
			sites = fieldnames(fdata);
			for bdb = 1:length(sites)
				if isfield(fdata.(sites{bdb}),'WQ_DIAG_TOT_TURBIDITY')
					fdata.(sites{bdb}).TURB = fdata.(sites{bdb}).WQ_DIAG_TOT_TURBIDITY;
				end
			end
			
		case 'ECOLI'
			
			ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});clear functions
			ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});clear functions
			data.ECOLI = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) ;
			clear ECOLI_F ECOLI_A
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ECLOI')
					fdata.(thesites{bdb}).ECOLI = fdata.(thesites{bdb}).ECLOI;
				end
			end
		
		case 'WQ_DIAG_MAG_MA2'
			data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'WQ_DIAG_MAG_TMALG')
					fdata.(thesites{bdb}).WQ_DIAG_MAG_MA2 = fdata.(thesites{bdb}).WQ_DIAG_MAG_TMALG;
				end
			end
		case 'WQ_DIAG_MA2_TMALG'
			data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'WQ_DIAG_MAG_TMALG')
					fdata.(thesites{bdb}).WQ_DIAG_MA2_TMALG = fdata.(thesites{bdb}).WQ_DIAG_MAG_TMALG;
				end
			end		
		case 'ECOLI_TOTAL'
			
			ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});clear functions
			ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});clear functions
			ECOLI_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_D'});clear functions
			data.ECOLI_TOTAL = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) + (ECOLI_D.WQ_PAT_ECOLI_D) ;
			clear ECOLI_F ECOLI_A ECOLI_D
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ECLOI')
					fdata.(thesites{bdb}).ECOLI_TOTAL = fdata.(thesites{bdb}).ECLOI;
				end
			end
			
		case 'ECOLI_PASSIVE'
			
			ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR1'});clear functions
			data.ECOLI_PASSIVE = (ECOLI_P.WQ_TRC_TR1) ;
			clear ECOLI_P
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ECLOI')
					fdata.(thesites{bdb}).ECOLI_PASSIVE = fdata.(thesites{bdb}).ECLOI;
				end
			end
			
		case 'ECOLI_SIMPLE'
			
			ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});clear functions
			data.ECOLI_SIMPLE = (ECOLI_P.WQ_TRC_TR2) ;
			clear ECOLI_P
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ECLOI')
					fdata.(thesites{bdb}).ECOLI_SIMPLE = fdata.(thesites{bdb}).ECLOI;
				end
			end
			
		case 'ENTEROCOCCI'
			
			ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});clear functions
			ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});clear functions
			%ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});
			data.ENTEROCOCCI = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A)  ;
			clear ENT_F ENT_A
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ENT')
					fdata.(thesites{bdb}).ENTEROCOCCI = fdata.(thesites{bdb}).ENT;
				end
			end
			
		case 'ENTEROCOCCI_TOTAL'
			
			ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});clear functions
			ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});clear functions
			ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});clear functions
			data.ENTEROCOCCI_TOTAL = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A) + (ENT_D.WQ_PAT_ENTEROCOCCI_D) ;
			clear ENT_F ENT_A ENT_D
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ENT')
					fdata.(thesites{bdb}).ENTEROCOCCI_TOTAL = fdata.(thesites{bdb}).ENT;
				end
			end
			
		case 'ENTEROCOCCI_PASSIVE'
			
			ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});clear functions
			data.ENTEROCOCCI_PASSIVE = (ENT_P.WQ_TRC_TR2) ;
			clear ENT_P
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ENT')
					fdata.(thesites{bdb}).ENTEROCOCCI_PASSIVE = fdata.(thesites{bdb}).ENT;
				end
			end
			
		case 'ENTEROCOCCI_SIMPLE'
			
			ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR4'});clear functions
			data.ENTEROCOCCI_SIMPLE = (ENT_P.WQ_TRC_TR4) ;
			clear ENT_P
			
			thesites = fieldnames(fdata);
			for bdb = 1:length(thesites)
				if isfield(fdata.(thesites{bdb}),'ENT')
					fdata.(thesites{bdb}).ENTEROCOCCI_SIMPLE = fdata.(thesites{bdb}).ENT;
				end
			end
			
		case 'HSI_CYANO'
			TEM =  tfv_readnetcdf(ncfile(mod).name,'names',{'TEMP'});clear functions
			SAL =  tfv_readnetcdf(ncfile(mod).name,'names',{'SAL'});clear functions
			NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});clear functions
			AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});clear functions
			FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});clear functions
			DEP =  tfv_readnetcdf(ncfile(mod).name,'names',{'D'});clear functions
			V_x =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_x'});clear functions
			V_y =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_y'});clear functions
			
			%------ temperature
			%The numbers I've used for Darwin Reservoir cyanobacteria are:
			%Theta_growth (v) = 1.08;
			%T_std = 28; %T_opt = 34; %T_max = 40;
			k =  4.1102;
			a = 35.0623;
			b =  0.1071;
			v =  1.0800;
			fT = v.^(TEM.TEMP-20)-v.^(k.*(TEM.TEMP-a))+b;
			
			%------ nitrogen
			KN = 4;                %   in mmol/m3
			fN = (NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM) ./ (KN+(NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM));
			
			%------ phosphorus
			KP = 0.15;    % in mmol/m3
			fP = FRP.WQ_PHS_FRP./(KP+FRP.WQ_PHS_FRP);
			
			%------ salinity
			KS = 5;                %   in PSU
			fS = KS ./ (KS+(SAL.SAL));
			fS(SAL.SAL<KS/2.)=1;
			
			%------ stratification/velocity
			KV = 0.5;
			V = (V_x.V_x.*V_x.V_x + V_y.V_y.*V_y.V_y).^0.5; %   in m/s
			fV = KV ./ (KV+V);
			fV(V<0.05)=0.;
			
			data.HSI_CYANO = ( fT .* min(fN,fP) .* fS .* fV);
			data.HSI_CYANO(data.HSI_CYANO<0.5) = 0;
			
			clear fT;
			
		otherwise
			
			data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
			
	end

	if single_precision
		
	data.(varname{var}) = single(data.(varname{var}));

	end


	else
		disp('loading Matfile');
		data.(loadname) = load([ncfile(mod).dir,loadname,'.mat']);
		switch varname{var}
			case 'TURB'
				sites = fieldnames(fdata);
				for bdb = 1:length(sites)
					if isfield(fdata.(sites{bdb}),'WQ_DIAG_TOT_TURBIDITY')
						fdata.(sites{bdb}).TURB = fdata.(sites{bdb}).WQ_DIAG_TOT_TURBIDITY;
					end
				end
		
			case 'ECOLI'
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ECLOI')
						fdata.(thesites{bdb}).ECOLI = fdata.(thesites{bdb}).ECLOI;
					end
				end
				
			case 'ECOLI_TOTAL'
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ECLOI')
						fdata.(thesites{bdb}).ECOLI_TOTAL = fdata.(thesites{bdb}).ECLOI;
					end
				end
			
			case 'ECOLI_PASSIVE'
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ECLOI')
						fdata.(thesites{bdb}).ECOLI_PASSIVE = fdata.(thesites{bdb}).ECLOI;
					end
				end
				
			case 'ECOLI_SIMPLE'
		
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ECLOI')
						fdata.(thesites{bdb}).ECOLI_SIMPLE = fdata.(thesites{bdb}).ECLOI;
					end
				end
			
			case 'ENTEROCOCCI'
				
				
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ENT')
						fdata.(thesites{bdb}).ENTEROCOCCI = fdata.(thesites{bdb}).ENT;
					end
				end
				
			case 'ENTEROCOCCI_TOTAL'
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ENT')
						fdata.(thesites{bdb}).ENTEROCOCCI_TOTAL = fdata.(thesites{bdb}).ENT;
					end
				end
				
			case 'ENTEROCOCCI_PASSIVE'
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ENT')
						fdata.(thesites{bdb}).ENTEROCOCCI_PASSIVE = fdata.(thesites{bdb}).ENT;
					end
				end
			
			case 'ENTEROCOCCI_SIMPLE'
			
			
				thesites = fieldnames(fdata);
				for bdb = 1:length(thesites)
					if isfield(fdata.(thesites{bdb}),'ENT')
						fdata.(thesites{bdb}).ENTEROCOCCI_SIMPLE = fdata.(thesites{bdb}).ENT;
					end
				end
				
			otherwise
			
			end
end
	
	







	