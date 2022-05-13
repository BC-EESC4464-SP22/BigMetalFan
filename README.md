# BigMetalFan Repository
Authors: Steven Maniscalco, Julianna Marinelli, Olivia Harby, Ginny Jablonski. Wind energy final project.

# A brief analysis of the allocation and efficiency of wind turbines in the United States
This repository contains the necessary code scripts to conduct the analysis of onshore wind energy development
in the United States that we have carried out. Codes allow for maps to be created in order to view spatial data
dealing with modeled average wind speeds, capacity factor, area availabilty based on capacity factor ratings,
population density, state governor political affiliation, and utility-scale wind power output by state.
The codes also allow for the current distribution of wind turbines in the United States to be plotted in comparison
to these factors. Paths in each of the scripts contained within this repository will need to be changed per individual user.

# Data Sources
Below is the breakdown of the datasets used within this GitHub Repository. These datasets can be found in the 
Google Drive folder "BigMetalFan_data" and can be downloaded from the provided links. 
The folders and files in the drive are set up as follows:

FOLDER NREL_WIND_dataset:
- FILE windspeeds_NREL.csv 
--> contains 2007-2013 NREL modeled wind speed and capacity factor data (https://data.nrel.gov/submissions/54)
- FILE pot_wind_cap_110_current.cst
--> contains 2007-2013 NREL data of land area available for wind turbines with various capacity factors from (https://maps.nrel.gov/wind-prospector/?aL=kWBYWk%255Bv%255D%3Dt&bL=clight&cE=0&lR=0&mC=40.730608477796636%2C-75.9375&zL=5)

FOLDER population_density_datasets:
- FILE ACSST5Y2020.S0101_data_with_overlays_2022-04-26T171210.csv
--> contains 2020 US Census Bureau population density data for the USA (https://data.census.gov/cedsci/table?t=Age%20and%20Sex&g=0100000US%240500000&y=2020&tid=ACSST5Y2020.S0101)
- FILE pop_data_manip.csv
--> identical to the data above with unecessary headers removed due to MATLAB errors
- FILE LND01_2.csv
--> contains 2011 US Census Bureau data of US county areas (https://www.census.gov/library/publications/2011/compendia/usa-counties-2011.html#LND)
- FILE uscounties.csv
--> contains 2021 SimpleMaps coordinate data for US counties (https://simplemaps.com/data/us-counties)

FOLDER USGS_turbine_locations
- FILE uswtdb_v4_3_20220114.csv
--> contains 1990-2022 USGS data for the onshore distribution of wind turbines in the USA (https://eerscmap.usgs.gov/uswtdb/)
- FILE CHANGELOG.txt
--> contains information about the above turbine dataset

FILE united_states_governors_1775_2020.csv
--> contains 1775-2020 data of state governor political affiliation retrieved from the ICPSR (https://www.openicpsr.org/openicpsr/project/102000/version/V3/view?path=/openicpsr/102000/fcr:versions/V3/united_states_governors_1775_2020.csv&type=file)

FILE utility-scale-wind-generation.csv
--> contains 2021 EIA data of utility-scale wind energy output in the USA (https://www.eia.gov/electricity/data/browser/#/topic/0?agg=1,0,2&fuel=008&geo=vvvvvvvvvvvvo&sec=o3g&linechart=ELEC.GEN.WND-US-99.M~ELEC.GEN.WND-IA-99.M~ELEC.GEN.WND-TX-99.M~ELEC.GEN.WND-OK-99.M~~ELEC.GEN.WND-KS-99.M~ELEC.GEN.WND-IL-99.M~~&columnchart=ELEC.GEN.WND-US-99.M~ELEC.GEN.WND-IA-99.M~ELEC.GEN.WND-TX-99.M&map=ELEC.GEN.WND-US-99.M&freq=M&ctype=linechart&ltype=pin&rtype=s&rse=0&maptype=0&pin=)


More information about these datasets is included in the project report 
"A brief analysis of the allocation and efficiency of wind turbines in the United States," Harby et al.
