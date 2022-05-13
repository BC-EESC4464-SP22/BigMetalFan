%% Read in Data

% Paths will need to be adjusted per individual user
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets');
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets\USGS_wind_turbines');
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\BigMetalFan\borders');

filename = 'windspeeds_NREL.csv'; % NREL average wind speed dataset
filename2 = 'uswtdb_v4_3_20220114.csv'; % turbine locations dataset

data = readtable(filename);
data_turb = readtable(filename2);

% Assign turbine coordinates
lat_turb = table2array(data_turb(:,27));
lon_turb = table2array(data_turb(:,26));

% Assign variables for average wind speeds dataset
lat = table2array(data(:,3));
lon = table2array(data(:,2));
windspd = table2array(data(:,9));

%% Redefine resolution to be 0.50 degree

maxlat = round(max(lat));
minlat = round(min(lat));
maxlon = round(max(lon));
minlon = round(min(lon));

r_lat = nan(length(lat),1);
r_lon = nan(length(lon),1);
for i = 1:length(lat)
    r_lat(i) = 0.5*round(lat(i)/0.5);
    r_lon(i) = 0.5*round(lon(i)/0.5);
end
coord = horzcat(r_lat,r_lon);

% unique coordinates (lat,lon) at 0.50 degree resolution
u_coord = unique(coord,'rows','stable');
u_lat = unique(u_coord(:,1),'sorted');
u_lon = unique(u_coord(:,2),'sorted');

% average wind speeds at 0.50 degree resolution
avg_windspd = nan(length(u_coord),1);
for k = 1:length(u_coord)
    ind = find(coord(:,1) == u_coord(k,1) & coord(:,2) == u_coord(k,2));
    avg = sum(windspd(ind)) / length(ind);
    avg_windspd(k) = avg;
end

all = horzcat(u_coord,avg_windspd);

%% Create Wind Speed Grid
% used for contour map
windspd_grid = nan(length(u_lon)+1,length(u_lat)+1);
windspd_grid(2:end,1) = u_lon;
windspd_grid(1,2:end) = u_lat;

for i = 1:length(all)
    latInd = find(windspd_grid(1,:) == all(i,1));
    lonInd = find(windspd_grid(:,1) == all(i,2));
    if all(i,1) < 24.5 % filter out southern-most data in Mexico
        windspd_grid(lonInd,latInd) = nan;
    else
        windspd_grid(lonInd,latInd) = all(i,3);
    end
end

windspd_grid = windspd_grid(2:end,2:end);

%% Create Map of Average Wind Speeds

load coastlines
figure(1); clf
usamap conus
plotm(coastlat,coastlon,'k')
contourfm(u_lat,u_lon,windspd_grid','linecolor','none');
cmocean('-ice')
bordersm('continental us','k')

cb = contourcbar("southoutside");

title('Modeled Average Wind Speed (2007-2013)')
cb.XLabel.String = 'Wind Speed (m/s)';

%% Plot Turbine Locations on Same Map

figure(1); hold on
tl = plotm(lat_turb,lon_turb,'r.','markersize',5);
leg = legend([tl]);
leg.String = {'Wind Turbine'};
hold off
