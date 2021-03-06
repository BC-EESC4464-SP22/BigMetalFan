%% Read in Data

% Paths will need to be adjusted per individual user
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets');
addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets\USGS_wind_turbines');
%addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\BigMetalFan\borders');

filename = 'united_states_governors_1775_2020.csv';

data = readtable(filename);

% Assign Variables
state = table2array(data(:,2));
party = table2array(data(:,4));
year = table2array(data(:,5));

state_str = strings(length(state),1);
party_str = strings(length(party),1);
for i = 1:length(state)
    state_str(i) = string(state(i));
    party_str(i) = string(party(i));
end
year_str = string(num2str(year));

%% Filter States to Iclude Only Lower 48

u_state = unique(state_str);
ind_remove = nan(7,1);
for j = 1:length(ind_remove)
    if j == 1
        ind_remove(j) = find(u_state == 'Guam');
    elseif j == 2
        ind_remove(j) = find(u_state == 'Puerto Rico');
    elseif j == 3
        ind_remove(j) = find(u_state == 'Virgin Islands');
    elseif j == 4
        ind_remove(j) = find(u_state == 'American Samoa');
    elseif j == 5
        ind_remove(j) = find(u_state == 'Northern Mariana Islands');
    elseif j == 6
        ind_remove(j) = find(u_state == 'Hawaii');
    else
        ind_remove(j) = find(u_state == 'Alaska');
    end
end

u_state(ind_remove) = '';
u_state(cellfun('isempty',u_state)) = [];

ind_keep = nan(length(state_str),1);
for g = 1:length(state_str)
    if ~isempty(find(u_state == state_str(g)))
        ind_keep(g) = g;
    end
end

ind_keep = ind_keep(~isnan(ind_keep));

state_str = state_str(ind_keep);
party_str = party_str(ind_keep);
year_str = year_str(ind_keep);
year = year(ind_keep);

data_new = horzcat(state_str,party_str,year_str);

%% Filter Data for 2010-2020

inds = nan(length(year),1);
for k = 1:length(year)
    if (year(k) >= 2010) && (year(k) <= 2020)
        inds(k) = k;
    end
end
inds = inds(~isnan(inds));

data_new_filt = data_new(inds,:);
data_new_filt = sortrows(data_new_filt);

%% Assign Political Affiliations to States

% running sum, +1 added for Democratic year and -1 added for Republican
% year
score = zeros(length(u_state),1);
for ii = 1:length(data_new_filt)
    state_ind = find(data_new_filt(ii,1) == u_state);
    if data_new_filt(ii,2) == 'Democrat'
        score(state_ind) = score(state_ind) + 1;
    elseif data_new_filt(ii,2) == 'Republican'
        score(state_ind) = score(state_ind) - 1;
    end
end

associations = horzcat(u_state,score);

% Positive sums indicate Democratic, negative sums indicate Republican,
% sums equal to 0 are neutral
rep_states = strings(length(associations),1);
dem_states = strings(length(associations),1);
neut_states = strings(length(associations),1);
for jj = 1:length(associations)
    if str2double(associations(jj,2)) > 0
        dem_states(jj) = associations(jj,1);
    elseif str2double(associations(jj,2)) < 0
        rep_states(jj) = associations(jj,1);
    else
        neut_states(jj) = associations(jj,1);
    end
end

dem_states(cellfun('isempty',dem_states)) = [];
rep_states(cellfun('isempty',rep_states)) = [];
neut_states(cellfun('isempty',neut_states)) = [];

%% Plot Maps
load coastlines
figure(1); clf
usamap("conus");

% plot points off-axis for legend
t = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor','blue');
t0 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor','red');
t1 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.4940 0.1840 0.5560]);

% Map contiguous USA
ax = usamap('conus');
states = shaperead('usastatelo', 'UseGeoCoords', true);
names = {states.Name};
% Indices
indexHawaii = strcmp('Hawaii',names);
indexAlaska = strcmp('Alaska',names);

statesSubsetRep = {};
for kk = 1:length(rep_states)
    statesSubsetRep = horzcat(statesSubsetRep,rep_states(kk));
end
indices = cellfun(@(x) strcmp(x,names), statesSubsetRep,  'UniformOutput', false);
indicesSubsetRep = indices{1};
for i = 2:numel(indices)
    indicesSubsetRep = indicesSubsetRep | indices{i} ;
end

statesSubsetNeut = {};
for hh = 1:length(neut_states)
    statesSubsetNeut = horzcat(statesSubsetNeut,neut_states(hh));
end
indices2 = cellfun(@(x) strcmp(x,names), statesSubsetNeut,  'UniformOutput', false);
indicesSubsetNeut = indices2{1};
for i = 2:numel(indices2)
    indicesSubsetNeut = indicesSubsetNeut | indices2{i} ;
end


indexConus = 1:numel(states);
indexConus(indexHawaii|indexAlaska|indicesSubsetRep) = []; 
% Colours
stateColor1 = [0.4940 0.1840 0.5560]; % purple
stateColor2 = [1 0 0]; % red
stateColor3 = [0 0 1]; % blue
% Display the three regions.
geoshow(ax(1), states(indexConus),  'FaceColor', stateColor3)
geoshow(ax(1), states(indicesSubsetRep),  'FaceColor', stateColor2)
geoshow(ax(1), states(indicesSubsetNeut), 'FaceColor', stateColor1)
title('Generalized Political Affiliations of State Governors (2010-2020)')

%% Plot Wind Turbine Locations

figure(1); hold on
[turb_lat,turb_lon] = wind_turbine_locations();
t2 = plotm(turb_lat,turb_lon,'k.','markersize',5);
leg = legend([t,t0,t1,t2]);
leg.String = {'Democrat','Republican','Neutral','Wind Turbine'};
uistack(ax,'bottom')
hold off
