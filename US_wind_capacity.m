%% Read in Data

% Paths will need to be adjusted per individual user
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets\wind_capacity');
 
filename1 = 'pot_wind_cap_110_current.csv'; % land area available

data1 = readtable(filename1);

% Assign variables for area availability dataset
lat_1 = table2array(data1(:,3));
lon_1 = table2array(data1(:,4));
tot_area = table2array(data1(:,6));
area40 = table2array(data1(:,10));
ratio40 = (area40./tot_area); % calculate ratio of land area available

%look at data for wind capacity of 40% or higher because average cap was
%41% (calculated in 2019) for turbines built 2014-2018

addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets');
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\BigMetalFan\borders');

filename = 'windspeeds_NREL.csv'; % NREL capacity factor dataset

data = readtable(filename);

% Assign variables for capacity factors
lat = table2array(data(:,3));
lon = table2array(data(:,2));
capfact = table2array(data(:,10));
capfact = capfact.*100;

rating = table2array(data(:,8));
frac_area = table2array(data(:,6));

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

% capacity factor at 0.50 degree resolution
avg_capfact = nan(length(u_coord),1);
for k = 1:length(u_coord)
    ind = find(coord(:,1) == u_coord(k,1) & coord(:,2) == u_coord(k,2));
    avg = sum(capfact(ind)) / length(ind);
    avg_capfact(k) = avg;
end

all = horzcat(u_coord,avg_capfact);

%% Create Capacity Factor Grid

capfact_grid = nan(length(u_lon)+1,length(u_lat)+1);
capfact_grid(2:end,1) = u_lon;
capfact_grid(1,2:end) = u_lat;

for i = 1:length(all)
    latInd = find(capfact_grid(1,:) == all(i,1));
    lonInd = find(capfact_grid(:,1) == all(i,2));
    if all(i,1) < 24.5 % filter out southern-most data in Mexico
        capfact_grid(lonInd,latInd) = nan;
    else
        capfact_grid(lonInd,latInd) = all(i,3);
    end
end

capfact_grid = capfact_grid(2:end,2:end);

%% Filter Area Data 
% some area measurements appear to be misreported, portions with over 100%
% area available
for i = 1:length(tot_area)
    if area40(i) > tot_area(i)
        ratio40(i) = nan;
    end
end
ratio40 = ratio40.*100;

%% Create Maps of Capacity Factor
load coastlines
figure(1); clf
usamap conus
plotm(coastlat,coastlon,'k')
contourfm(u_lat,u_lon,capfact_grid','linecolor','none');
bordersm('continental us','k')
cb = contourcbar("southoutside");
cmocean('speed') % nondiverging scheme
title('Modeled Wind Capacity Factor (2007-2013)')
cb.XLabel.String = 'Wind Capacity Factor (%)';

figure(2); clf
usamap conus
plotm(coastlat,coastlon,'k')
contourfm(u_lat,u_lon,capfact_grid','linecolor','none');
bordersm('continental us','k')
cb = contourcbar("southoutside");
cmocean('delta','pivot',41) % diverging scheme
cb.XLabel.String = 'Wind Capacity Factor (%)';

%% Plot Wind Turbine Locations

figure(1); hold on
[turb_lat,turb_lon] = wind_turbine_locations();
tl = plotm(turb_lat,turb_lon,'m.','markersize',5);
leg = legend([tl]);
leg.String = {'Wind Turbine'};
hold off

figure(2); hold on
[turb_lat,turb_lon] = wind_turbine_locations();
tl = plotm(turb_lat,turb_lon,'r.','markersize',5);
leg = legend([tl]);
leg.String = {'Wind Turbine'};
hold off

%% Create Map of Capacity Factor Area Available

load coastlines
figure(3); clf
usamap conus
plotm(coastlat,coastlon,'k')
scatterm(lat_1,lon_1,10,ratio40,'filled')
bordersm('continental us','k')
cb = contourcbar("southoutside");
cmocean('matter')
title('Land Area Available for Efficient Turbines')
cb.XLabel.String = 'Area Available (%)';
