clear; clc; close all;

%% Plant analysis

s = tf("s");

G = (1)/(0.2*s+1)/(s^2+2*s+4);
Gzpk = zpk(G);

[tau, Tfunc] = TimeConstant(1/(s^2+2*s+4));

Ti = .5;
Td = .2;
Tf = Td/5;

C = (1/Ti)*(1+(Ti+Tf)*s+Ti*(Td+Tf)*s^2)/s/(1+Tf*s);

[mag,phase,w] = bode(G*C);
K = margin(mag,phase+-69,w);
C=K*C;
L = G*C;

%% plotting
% figure(1)
% margin(G)
% 
% figure(2)
% nyquist(G)
% 
% figure(3)
% hold on;
% step(G)
% step(L/(1+L))


% figure(4)
% margin(L/(1+L))
% 
% figure(5)
% nyquist(L/(1+L))

t = 0:0.01:99.99;
u = ones(length(t),1);
H = L/(1+L);
figure(1);
lsim(G,u,t);
hold on;
lsim(H,u,t);
grid on;
grid minor;
set(gca,'xtick',[0:1:20]);
set(gca,'ytick',[0:.05:2]);
legend("Plant", "Controlled Plant")
axis([0 20 0 1.2]);


%% function

function [tau, TFunc]=TimeConstant(TF)
%%time constant for first order continuous transfer functions.
den=cell2mat(TF.Denominator);
num=cell2mat(TF.Numerator);
len=length(den);
if(den(len)~=1)
    den=den/den(len);
    num=num/den(len);
end
tau=den(len-1);
TFunc=tf(num,den);
end