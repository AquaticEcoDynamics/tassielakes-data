# Water Level Data Processing

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

### Data Sources
**Woods Lake (data-warehouse/csv/ht/wlwq) from:**
| Variables | Source |
| ------------- | ------------- |
| Samples | *data-lake/HT/WaterQuality/462.5_WoodsLakeMiddle_AllData.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Conductivity_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_DO%25_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_DO(mgperl)_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_pH_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Salinity_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_Turbidity_Continuous.csv* |
| Continuous | *data-lake/HT/WaterQuality/462.15_WoodsLakeMiddleLakeBed_WaterTemp_Continuous.csv* |
| Light profile | *data-lake/HT/WaterQuality/462_WoodsLake_LightProfile.csv* |

**Arthurs Lake (data-warehouse/csv/ht/alwq) from:**
| Variables | Source |
| ------------- | ------------- |
| Samples | *data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WaterLevel.csv* |
| Continuous | ** |
