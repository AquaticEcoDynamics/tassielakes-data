# Meteorology Data Processing

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
| Program | Woods Lake / BOM |
| Project | MET |
| Tag | HT-MET |
| Data File Name | Raw data source file (.csv) |
| Location | Raw data source location (file path) |
| Station Status | Active |
| Lat | Latitude (dam/middle of the lake / BOM Station ID) |
| Long | Longitude (dam/middle of the lake / BOM Station ID) |
| Time Zone | GMT +6 |
| Vertical Datum | mAHD |
| National Station ID | 462 / 96033 |
| Site Description | 462 / 96033 |
| Deployment | profile |
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
| QC | int / Y/N |

### Data Sources
**Woods Lake (data-warehouse/csv/ht/met) from:**
| Variables | Source |
| ------------- | ------------- |
| Samples | *data-lake/HT/Meteorology/Rainfall Woods Lake At Dam.csv* |

**BOM (data-warehouse/csv/ht/met) from:**
| Variables | Source |
| ------------- | ------------- |
| Samples | *data-lake/BOM/HT/Hourly aggregate/AirTemp.csv* |
| Samples | *data-lake/BOM/HT/Hourly aggregate/Humidity.csv* |
| Samples | *data-lake/BOM/HT/Hourly aggregate/Rainfall.csv* |
| Samples | *data-lake/BOM/HT/Hourly aggregate/WD.csv* |
| Samples | *data-lake/BOM/HT/Hourly aggregate/WS.csv* |
| Samples | *data-lake/BOM/IDC/IDCJAC0009_096033_1800_Data.csv* |
