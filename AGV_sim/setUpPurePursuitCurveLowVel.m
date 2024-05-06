% Pure Pursuit Model Initialization

% Copyright 2020 The MathWorks, Inc.

%% add Image to the path
addpath(genpath('Images'));

%% load the scene data file generated from Driving Scenario Designer
load('guiji.mat');

%% define reference points
refPose = data.ActorSpecifications.Waypoints;
refyaw=data.ActorSpecifications.Yaw;
xRef = refPose(:,1);
yRef = -refPose(:,2);

%% define reference time for plotting 
Ts = 23; % simulation time
s = size(xRef);
tRef = (linspace(0,Ts,s(1)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 

%% define parameters used in the models
L = 3; % bicycle length
ld = 5; % lookahead distance
X_o = refPose(1,1); % initial vehicle position
Y_o = -refPose(1,2); % initial vehicle position 
psi_o =-refyaw*(pi/180) ;  % initial yaw angle

