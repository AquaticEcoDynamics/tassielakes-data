function export_marvl_info

load ../../data-warehouse/mat/agency/csiem_HT_public.mat;

sites = fieldnames(csiem);

vars = [];

sites = fieldnames(csiem);
for j = 1:length(sites)
    thevars = fieldnames(csiem.(sites{j}));
    vars = [vars;thevars];
end
uvars = unique(vars);

fid = fopen('../../marvl-config/marvl_information.m','wt');
fprintf(fid,'master.varname = {...\n');

uvars = unique(vars);
for i = 1:length(uvars)

            fprintf(fid,'''%s'',''%s'';...\n',uvars{i},uvars{i});
end
fprintf(fid,'};');
fprintf(fid,'\n');
fprintf(fid,'\n');

fprintf(fid,'timeseries.start_plot_ID = 1;\n');
fprintf(fid,'timeseries.end_plot_ID = %d;\n',length(uvars));