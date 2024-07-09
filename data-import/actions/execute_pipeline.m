% Pipeline to run once new data has been imported
tic;
disp('Importing updated variable key');
import_var_key_info;
disp('Importing raw csv');
csv_2_matfile_tfv_by_agency;
disp('Exporting variable information for MARVL');
export_marvl_info;

cd ../../marvl-config/;

addpath(genpath('../aed-marvl'));
disp('Plotting');

run_AEDmarvl MARVL_FieldData;

clc;
disp('Finished execution');
toc
cd ../data-import/actions/;

