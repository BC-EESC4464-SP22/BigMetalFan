READ ME 
Authors: Steven Maniscalco, Olivia Harby, Julianna Marinelli, Ginny Jablonski

This repository contains the necessary code scripts to conduct the analysis of onshore wind energy development
in the United States that we have carried out. Codes allow for maps to be created in order to view spatial data
dealing with modeled average wind speeds, capacity factor, area availabilty based on capacity factor ratings,
population density, state governor political affiliation, and utility-scale wind power output by state.
The codes also allow for the current distribution of wind turbines in the United States to be plotted in comparison
to these factors. Paths in each of the scripts contained within this repository will need to be changed per individual user.

Below is the breakdown of the datasets used within this GitHub Repository. These datasets can be found in the 
Google Drive folder: BigMetalFan_data. The folders and files in the drive are set up as follows:


FOLDER NREL_WIND_dataset:
- FILE windspeeds_NREL.csv 
--> contains 2007-2013 NREL modeled wind speed and capacity factor data (from NREL WIND)
- FILE pot_wind_cap_110_current.cst
--> contains 2007-2013 NREL data of land area available for wind turbines with various capacity factors from (NREL WIND)

FOLDER population_density_datasets:
- FILE ACSST5Y2020.S0101_data_with_overlays_2022-04-26T171210.csv
--> contains 2020 US Census Bureau population density data for the USA 
- FILE pop_data_manip.csv
--> identical to the data above with unecessary headers removed (which gave MATLAB issues)
- FILE LND01_2.csv
--> contains 2011 US Census Bureau data of US county areas
- FILE uscounties.csv
--> contains 2021 SimpleMaps coordinate data for US counties

FOLDER USGS_turbine_locations
- FILE uswtdb_v4_3_20220114.csv
--> contains 1990-2022 USGS data for the onshore distribution of wind turbines in the USA
- FILE CHANGELOG.txt
--> contains information about the above turbine dataset

FILE united_states_governors_1775_2020.csv
--> contains 1775-2020 data of state governor political affiliation retrieved from the ICPSR 

FILE utility-scale-wind-generation.csv
--> contains 2021 EIA data of utility-scale wind energy output in the USA 


More information about these datasets is included in the project report 
"A brief analysis of the allocation and efficiency of wind turbines in the United States," Harby et al.