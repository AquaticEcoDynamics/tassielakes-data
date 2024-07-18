# Organise output MARVL plots in MARVL_IMPORT_TEST

Output marvl plots with field data generated from running matlab code are saved into MARVL_IMPORT_TEST. This script is to reorganise the outputs by selecting the required variables and saved them into MAIN and PHYTOPLANKTON folders under MARVL_IMPORT_TEST_REQUIRED.

There are two separate folders under the PHYTOPLANKTON:
- TOTAL (Aggregation of different group of that species)
- INDIVIDUAL (Individual group)

### File Description
| Format  | Name  | Description  |
| ------------- | ------------- | ------------- |
| .ipynb | organise_files.ipynb | Python script written in Jupyter notebook for organising the output plots from MARVL_IMPORT_TEST to MARVL_IMPORT_TEST_REQUIRED |