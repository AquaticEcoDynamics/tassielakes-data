# Outflow Data Processing

### Data Extraction
A comparison plot (woods_flow_comparison.png) has been generated from 

- data-lake/HT/Hydrology/454.1_LakeRiverBLWoodsLakeDam_ChannelFlow_Continuous.csv; and
- data-lake/HT/Hydrology/462.1_WoodsLakeAtDam_SpillwayDischarge_Continuous.csv

to compare the data validity of both data files.

Thus, the Lake River Channel Flow was used as the flow rate for the output file (outflow_woods_dam-spillway_19990311-20240416.csv).

### Data Transformation
Raw data were extracted and linearly interpolated into a 15-minute interval within the timeframe.

### Output File Format
| Date  | Data |
| ------------- | ------------- |
| dd/mm/yyyy HH:MM:SS  | Outflow  |

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

---

## Process data and header files
**Assumptions:**
The unit of discharge is assumed to be m<sup>3</sup>/s, not mentioned in raw datasets.

### Output File Format
**Data file:**
| Variable  | Date | Depth | Data | QC |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| variable name | yyyy-mm-dd HH:MM:SS | lake depth | variable value | quality control |

**Header file:**
| Header | Value |
| ------------- | ------------- |
| Agency Name | Hydro Tasmania |
| Agency Code | HT |
| Program | Woods Lake WQ |
| Project | WLWQ |
| Tag | HT-WLWQ-CONT |
| Data File Name | Raw data source file (.csv) |
| Location | Raw data source location (file path) |
| Station Status | Active |
| Lat | Latitude (dam/middle of the lake) |
| Long | Longitude (dam/middle of the lake) |
| Time Zone | GMT +6 |
| Vertical Datum | mAHD |
| National Station ID | 462 |
| Site Description | 462 |
| Deployment | floating |
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

### Data Sources
**Arthurs Lake (data-warehouse/csv/ht/alwq) from:**
| Variables | Source |
| ------------- | ------------- |
| Continuous | *data-lake/HT/Hydrology/454.1_LakeRiverBLWoodsLakeDam_ChannelFlow_Continuous.csv* |
| Continuous | *data-lake/HT/Hydrology/462.1_WoodsLakeAtDam_SpillwayDischarge_Continuous.csv* |