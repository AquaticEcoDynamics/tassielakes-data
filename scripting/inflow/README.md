# Inflow Data Processing

### Data Extraction
A comparison plot (flow_comparison.png) has been generated from 

- data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/Inflow.csv; and
- data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/SpillwayDischarge.csv

to compare the data validity of both data files.

Thus, the Inflow was used as the flow rate for the output file (inflow_woods_dam_20170908-20240514.csv).

Temperature, salinity, and chlorophyll-a data were extracted from continuous data (data-lake/HT/Hydrology/Arthurs Lake Spillway (418.1)/WQ at Morass Bay (418.24)/Continuous/).

Other water qualities (including total suspended solid, ammonium, nitrate, dissolved oxygen, filtered reactive phosphorus, total nitrogen, and total phosphorus) were extracted from samples data (data-warehouse/csv/ht/alwq/).

---

### Data Transformation
Raw data were extracted and linearly interpolated into a 15-minute interval within the timeframe, based on the data availability of flow, temperature, and salinity.

Unavailable outside this time frame for the water qualities were then extrapolated, using the mean of the available data within the time frame.

The data of organic nitrogen were derived from the difference among total nitrogen, nitrate, and ammonium.

The data of organic phoshorus were derived from the difference between total phosphorus and filtered reactive phosphorus.

Unit conversion for water qualities (except total suspended solids)
| Variable | Previous unit |  Conversion factor | Current unit |
| ------------- | ------------- | ------------- | ------------- |
| Dissolved oxygen | mg O<sub>2</sub>/L | 1/32 | mmol O2/m3 |
| Ammonium | mg N/L | 1/32 | mmol N/m3 |
| Nitrate | mg N/L | 1/32 | mmol N/m3 |
| Filtered reactive phosphorus | mg P/L | 1/32 | mmol P/m3 |
| Organic carbon | mg C/L | 1/32 | mmol C/m3 |
| Organic nitrogen | mg N/L | 1/32 | mmol N/m3 |
| Organic phosphorus | mg P/L | 1/32 | mmol P/m3 |
| Chlorophyll-a | mg C<sub>55</sub>H<sub>72</sub>O<sub>5</sub>N<sub>4</sub>Mg/L | 1/32 | mmol /m3 |

Calculation of on and op...

---

### Assumptions

organic carbon ...

---

### Output File Format ...
| Date  | Data |
| ------------- | ------------- |
| dd/mm/yyyy HH:MM:SS  | Outflow  |

---

### File Description ...
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
