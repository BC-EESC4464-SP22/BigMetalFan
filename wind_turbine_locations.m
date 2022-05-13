%% Read in Data
% function that takes no input and is called to return the latitude and
% longitude coordinates turbines in the contiguous United States
% Path will need to be adjusted per individual user
function [turb_lat,turb_lon] = wind_turbine_locations()
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets\USGS_wind_turbines');

filename = 'uswtdb_v4_3_20220114.csv';

data = readtable(filename);

turb_lat = table2array(data(:,27));
turb_lon = table2array(data(:,26));

%% Create Map of Turbine Locations
% can uncomment to make a map and view turbine locations

% load coastlines
% figure(1); clf
% worldmap([23.5 50], [-127 -65])
% plotm(coastlat,coastlon,'k')
% scatterm(lat,lon,15,'filled')
% plotm(lat,lon,'g.','markersize',10)
% %cb = contourcbar("southoutside");
% %cmocean('balance', 'pivot', 0)
% %cmocean('thermal')
% title('Wind Turbine Location - Contiguous United States')
% %cb.XLabel.String = 'Wind Speed (meters per second)';
end