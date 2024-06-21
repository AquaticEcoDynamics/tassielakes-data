function [data,c_units,isConv] = tfv_getmodeldatapolygon(rawData,filename,X,Y,sX,sY,varname,D,depth_range,layerface,NL,surface_offset,use_matfiles)
%--% Function to load the tuflowFV model output at a specified location
% (X,Y).
% Usage: H = H = getmodeldatalocation(filename,X,Y,varname)

rawGeo = tfv_readnetcdf(filename,'timestep',1);





area = rawGeo.cell_A;
		V = D .* area;



dat = tfv_readnetcdf(filename,'time',1);
tdate = dat.Time;

%clear functions
inpol = inpolygon(X,Y,sX,sY);
sss = find(inpol == 1);
if use_matfiles
	[rawData.(varname{1}).outdata.surface,c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1}).outdata.surface,varname{1});
	[rawData.(varname{1}).outdata.bottom,c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1}).outdata.bottom,varname{1});
else
	rawData
	[rawData.(varname{1}),c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1}),varname{1});
end
varname{1}
c_units
pred_lims = [0.05,0.25,0.5,0.75,0.95];
if length(sss) > 1


	
	num_lims = length(pred_lims);
	nn = (num_lims+1)/2;


	

	[iX,iY] = size(rawData.(varname{1}));
	cell_depths(1:iX,1:iY) = NaN;

	if length(rawData.(varname{1})) > length(D)
			if surface_offset ~= 0 % There is an offset
			
			disp('Using surface offset');
			cell_depths = calc_cell_depths(cell_depths,layerface,NL);
			end
	end
	for iii = 1:length(sss)
		pt_id(iii) = sss(iii);
		Cell_3D_IDs = find(rawGeo.idx2==pt_id(iii));
		
		%disp(rawGeo.NL(pt_id));
		
		%if(length(Cell_3D_IDs) ~= rawGeo.NL(pt_id(iii)))
			%disp('cell3DiDs ~=NL');
			%disp(pt_id);
		%end
		
		if surface_offset ~= 0 % There is an offset
			
			the_depths = cell_depths(Cell_3D_IDs,1);
			
			theval = the_depths(1) + surface_offset;
			
			[~,ind] = min(abs(the_depths - theval));
			
			surfIndex(iii) = Cell_3D_IDs(ind);
			
		else
			
		surfIndex(iii) = min(Cell_3D_IDs);
		
		end
		botIndex(iii) = max(Cell_3D_IDs);
		
	end
	
	if ~use_matfiles

		if strcmp(varname{1},'H') == 0 & strcmp(varname{1},'D') == 0 & strcmp(varname{1},'cell_A') == 0 & ...
			strcmp(varname{1},'cell_Zb') == 0 & strcmp(varname{1},'WVHT') == 0 & strcmp(varname{1},'W10_x') == 0 & ...
			strcmp(varname{1},'W10_y') == 0
			
			
			data.surface = rawData.(varname{1})(surfIndex,:);
			data.bottom = rawData.(varname{1})(botIndex,:);
			
			%         [data.surface(iii,:),c_units,isConv] = tfv_Unit_Conversion(rawData.(varname{1})(surfIndex,:),varname{1});
			%         [data.bottom(iii,:),c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1})(botIndex,:),varname{1});
			%data.profile = rawData.(varname{1})(Cell_3D_IDs,:);
			
		else
			data.surface = rawData.(varname{1})(pt_id,:);
			data.bottom = rawData.(varname{1})(pt_id,:);
			
			%         [data.surface(iii,:),c_units,isConv] = tfv_Unit_Conversion(rawData.(varname{1})(pt_id,:),varname{1});
			%         [data.bottom(iii,:),c_units,isConv]  = tfv_Unit_Conversion(rawData.(varname{1})(pt_id,:),varname{1});
			
		end
		
	else
	
		data.surface = rawData.(varname{1}).outdata.surface(pt_id,:);
		data.bottom = rawData.(varname{1}).outdata.bottom(pt_id,:);
	end
	
	

	point_D = D(pt_id,:);
	%point_A = area(pt_id);
	
	
	%Get curtain series of predictive limits for variable varname

	%ddd = find(point_D <= 0.042);
	
	data.area = area(pt_id);
	
	
	for kk = 1:length(tdate)
		data.vol(:,kk) = V(pt_id,kk);
		% Mean Area Surf
		
		eee = find(point_D(:,kk) >= depth_range(1) & point_D(:,kk) <= depth_range(2));
			
		
		surface_area_calc = data.surface(eee,kk) .* data.area(eee);
		surface_area_calc_2 = sum(surface_area_calc) ./ sum(data.area(eee));

		bottom_area_calc = data.bottom(eee,kk) .* data.area(eee);
		bottom_area_calc_2 = sum(bottom_area_calc) ./ sum(data.area(eee));
		
		
		% Mean Vol Surf
		surface_vol_calc = data.surface(eee,kk) .* data.vol(eee,kk);
		surface_vol_calc_2 = sum(surface_vol_calc) ./ sum(data.vol(eee,kk));
		bottom_vol_calc = data.bottom(eee,kk) .* data.vol(eee,kk);
		bottom_vol_calc_2 = sum(bottom_vol_calc) ./ sum(data.vol(eee,kk));	

		data.surface_mean(kk,1) = mean(data.surface(eee,kk),1);
		data.surface_area_mean(kk,1) = surface_area_calc_2;
		data.surface_vol_mean(kk,1) = surface_vol_calc_2;
		
		
		data.bottom_mean(kk,1) = mean(data.bottom(eee,kk),1);
		data.bottom_area_mean(kk,1) = bottom_area_calc_2;
		data.bottom_vol_mean(kk,1) = bottom_vol_calc_2;
	
	end

	
	
	ddd = find(point_D <= depth_range(1) | point_D >= depth_range(2));
	


	data.surface(ddd) = NaN;
	data.bottom(ddd) = NaN;
	


	
	[~,iy] = size(data.surface);

	

	



	inc = 1;
	for i = 1:iy
		xd = data.surface(:,i);
		if sum(isnan(xd)) < length(xd)
			xd(isnan(xd)) = mean(xd(~isnan(xd)));
			data.pred_lim_ts(:,inc) = plims(xd,pred_lims);
			data.date(inc,1) = tdate(i);
			inc = inc + 1;
		end
	end

	inc = 1;
	for i = 1:iy
		xd = data.bottom(:,i);
		if sum(isnan(xd)) < length(xd)
			xd(isnan(xd)) = mean(xd(~isnan(xd)));
			data.pred_lim_ts_b(:,inc) = plims(xd,pred_lims);
			data.date_b(inc,1) = tdate(i);
			inc = inc + 1;
		end
	end

else
	data.surface = [];
	data.bottom = [];
	data.date(:,1) = tdate;
	data.date_b(:,1) = tdate;
	data.pred_lim_ts(1:length(pred_lims),1:length(tdate)) = NaN;
	data.pred_lim_ts_b(1:length(pred_lims),1:length(tdate)) = NaN;
	data.surface_mean = [];
	data.surface_area_mean = [];
	data.surface_vol_mean = [];
end
%
%

% else
%     data.date = tdate;
% end




%Set limits for predictive plot as 2.5%, 50.0% and 97.5%
%pred_lims = [0.025,0.5,0.975];

