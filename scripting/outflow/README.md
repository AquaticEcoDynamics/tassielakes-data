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
[ .csv ]
