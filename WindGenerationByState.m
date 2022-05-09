%% Paths 
% addpath '/Users/juliannamarinelli/Desktop/Envi Data/Github/github_repo'
% addpath '/Users/juliannamarinelli/Desktop/Envi Data' 

addpath('C:\Users\smano32\OneDrive\Desktop\Envi_Data&Exp\FinalProject_Datasets');

%% Load in data 
filename = 'utility-scale-wind-generation.csv';
generationDataRaw = readtable(filename);
% note that the data is in billion kwh

%% Create map w/ differentely colored state groups; define own bins 

load coastlines
figure(1); clf
usamap("conus");

% plot points off-axis for legend
t = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[1 1 1]); %0
t0 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.77 0.83 1]); %0-5
t1 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.61 0.71 1]); %5-10
t2 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.46 0.60 1]); %10-15
t3 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.31 0.49 1]); %15-20
t4 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0.17 0.39 1]); %25-30
t5 = plotm(80,-95,'ks','markersize',5,'MarkerFaceColor',[0 0.27 1]); %30+

ax = usamap('conus');
%set(ax, 'Visible', 'off')
states = shaperead('usastatelo', 'UseGeoCoords', true);
names = {states.Name};

% Indices

indexHawaii = strcmp('Hawaii',names);
indexAlaska = strcmp('Alaska',names);

% subset 1 (=0)
statesSubset1 = {'Alabama','Arkansas','District of Columbia','Florida','Georgia','Kentucky','Louisiana','Mississippi','South Carolina'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset1,  'UniformOutput', false);
indicesSubset1 = indices{1};
for i = 2:numel(indices)
    indicesSubset1 = indicesSubset1 | indices{i} ;
end

% subset 2 (0-5)
statesSubset2 = {'Delaware','Connecticut','New Jersey','Tennessee','Virginia','Rhode Island','Massachusetts','Vermont','Nevada','New Hampshire','North Carolina' ,'Maryland','Utah','Arizona','Wisconsin','West Virginia','Maine','Ohio','Idaho','Montana','Pennsylvania','New York'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset2,  'UniformOutput', false);
% indicesSubset2 = indices{2};
indicesSubset2 = indices{1};
for i = 2:numel(indices)
    indicesSubset2 = indicesSubset2 | indices{i} ;
end

%subset 3 (5-10)
statesSubset3 = {'Missouri','Michigan','Indiana','Wyoming','South Dakota','Washington','Oregon','Nebraska'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset1,  'UniformOutput', false);
% indicesSubset3 = indices{3};
indicesSubset3 = indices{1};
for i = 2:numel(indices)
    indicesSubset3 = indicesSubset3 | indices{i} ;
end

% subset 4 (10-15)
statesSubset4 = {'New Mexico','Minnesota','North Dakota','Colorado','California'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset4,  'UniformOutput', false);
% indicesSubset4 = indices{4};
indicesSubset4 = indices{1};
for i = 2:numel(indices)
    indicesSubset4 = indicesSubset4 | indices{i} ;
end

% subset 5 (15-20)
statesSubset5 = {'Illinois'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset5,  'UniformOutput', false);
% indicesSubset5 = indices{5};
indicesSubset5 = indices{1};
for i = 2:numel(indices)
    indicesSubset5 = indicesSubset5 | indices{i} ;
end

% subset 6 (25-30)
statesSubset6 = {'Kansas'};
indices = cellfun(@(x) strcmp(x,names), statesSubset6,  'UniformOutput', false);
% indicesSubset6 = indices{6};
indicesSubset6 = indices{1};
for i = 2:numel(indices)
    indicesSubset6 = indicesSubset6 | indices{i} ;
end

% subset 7 (30+) 
statesSubset7 = {'Oklahoma','Iowa','Texas'}; 
indices = cellfun(@(x) strcmp(x,names), statesSubset7,  'UniformOutput', false);
% indicesSubset7 = indices{7};
indicesSubset7 = indices{1};
for i = 2:numel(indices)
    indicesSubset7 = indicesSubset7 | indices{i} ;
end

indexConus = 1:numel(states);
% indexConus(indexHawaii|indexAlaska|indicesSubset1) = []; 
indexConus(indexHawaii|indexAlaska) = []; 

% Colors
stateColor0 = [0.61 0.70 1]; %5-10
% stateColor1 = [0.92 0.94 1];
% stateColor1 = [1 0 1];
stateColor2 = [0.77 0.83 1]; %0-5
% stateColor2 = [1 0 1]; 
stateColor3 = [1 1 1];
%stateColor3 = [0.61 0.71 1]; %0
%stateColor3 = [1 0 1];
stateColor4 = [0.46 0.60 1]; %10-15
% stateColor4 = [1 0 1];
stateColor5 = [0.31 0.45 1]; %15-20
% stateColor5 = [1 0 1];
stateColor6 = [0.17 0.35 1]; %20-25
% stateColor6 = [1 0 1];
stateColor7 = [0 0 1]; %25-30
% stateColor7 = [1 0 1]; 

% Display the three regions.
geoshow(ax(1), states(indexConus),  'FaceColor', stateColor0)
geoshow(ax(1), states(indicesSubset1),  'FaceColor', stateColor3)
geoshow(ax(1), states(indicesSubset2),  'FaceColor', stateColor2)
geoshow(ax(1), states(indicesSubset3),  'FaceColor', stateColor3)
geoshow(ax(1), states(indicesSubset4),  'FaceColor', stateColor4)
geoshow(ax(1), states(indicesSubset5),  'FaceColor', stateColor5)
geoshow(ax(1), states(indicesSubset6),  'FaceColor', stateColor6)
geoshow(ax(1), states(indicesSubset7),  'FaceColor', stateColor7)

% %Hide the frame.
% for k = 1:3
%     setm(ax(k), 'Frame', 'off', 'Grid', 'off',...
%       'ParallelLabel', 'off', 'MeridianLabel', 'off')
% end
title('Utility Wind Power Output by State (2021)')
leg = legend([t,t0,t1,t2,t3,t4,t5]);
leg.String = {'0 billion kWh','0-5 billion kWh','5-10 billion kWh','10-15 billion kWh','15-20 billion kWh (IL)','25-30 billion kWh (KS)','30+ billion kWh'};
uistack(ax,'bottom')