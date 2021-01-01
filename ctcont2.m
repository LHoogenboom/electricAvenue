clear; clc;

%% Plant

G = tf((1),[0.2 1.4 2.8 4]);
Gzpk = zpk(G);

%% Controller
Kp = 15.7/2;
Ki = 11.5;
Kd = 4;

C = tf([Kd Kp Ki], [1 0]);

%% System
L = C*G;
H = zpk(L/(1+L));

%% Simulation
t = 0:0.01:99.99;
u = ones(length(t),1);
figure(1);
lsim(H,u,t);
grid on;
grid minor;
set(gca,'xtick',[0:5:100]);
set(gca,'ytick',[0:.05:2]);

set_param(blockName,'paramName','variableName')
