# Boundary Conditions Data Processing

### Data Extraction
**Woods Lake (data-warehouse/csv/ht/wlwq) from:**

*data-lake/HT/WaterQuality/462.5_WoodsLakeMiddle_AllData.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Conductivity_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_DO%25_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_DO(mgperl)_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_pH_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Salinity_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Turbidity_Continuous.csv*

*data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_WaterTemp_Continuous.csv*

*data-lake/HT/WaterQuality/462_WoodsLake_LightProfile.csv*

**Arthurs Lake (data-warehouse/csv/ht/alwq) from:**

data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Samples/WQSamples.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/DO(%25).csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/Water%20Temp.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/chloro_a.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/conductivity.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/phyco.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/salinity.csv

data-lake/HT/Hydrology/Arthurs%20Lake%20Spillway%20(418.1)/WQ%20at%20Morass%20Bay%20(418.24)/Continuous/turbidity.csv

### Output File Format
**Data file:**
| Variable  | Date | Depth | Data | QC |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| variable name | yyyy-mm-dd HH:MM:SS | lake depth | variable value | quality control|

**Header file:**
| Header | Value |
| ------------- | ------------- |
| Agency Name | Hydro Tasmania |
| Agency Code | HT |
| Program | Arthurs/Woods Lake WQ |
| Project | ALWQ/WLWQ |
| Tag | HT-ALWQ/HT-WLWQ/HT-ALWQ-CONT/HT-WLWQ-CONT |
| Data File Name | Raw data source file (.csv) |
| Location | Raw data source location (file path) |
| Station Status | Active |
| Lat | Latitude (dam/middle of the lake) |
| Long | Longitude (dam/middle of the lake) |
| Time Zone | GMT +6 |
| Vertical Datum | mAHD |
| National Station ID | 418/462 |
| Site Description | 418/462 |
| Deployment | profile/floating |
| Deployment position | m from surface |
| Vertial Reference | Water Surface |
| Site Mean Depth | - |
| Bad or Unavailable Data Value | NaN |
| Contact Email | - |
| Variable ID | standardised mapping key |
| Data Category | standardised mapping variable category |
| Sampling Rate (min) | - |
| Date | yyyy-mm-dd HH:MM:SS |
| Depth | decimal |
| Variable | variable name in raw data |
| QC | int |

### File Description
| Format  | Name  | Description  |
| ------------- | ------------- | ------------- |
| .csv  | Interpolated_454.1_LakeRiverBLWoodsLakeDam_ChannelFlow_Continuous.csv  | Interpolated lake river flow |
| .csv  | Interpolated_462.1_WoodsLakeAtDam_SpillwayDischarge_Continuous.csv  | Interpolated spillway flow |
| .csv  | outflow_woods_dam-spillway_19990311-20240416.csv | Interpolated outflow of Woods Lake |
| .ipynb  | comparison_plot.ipynb | Python script written in Jupyter notebook for plotting comparison graph|
| .ipynb  | lakeriver_processing.ipynb | Python script written in Jupyter notebook for processing lake river data|
| .ipynb  | outflow_processing.ipynb | Python script written in Jupyter notebook for processing Woods lake outflow|
| .ipynb  | spillway_processing.ipynb | Python script written in Jupyter notebook for processing spillway data|
| .png  | woods_flow_comparison.png | Comparison plot between the flow of lake river and spillway |
