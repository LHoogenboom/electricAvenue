clear; clc;

s = tf("s");

G = (1)/(0.2*s+1)/(s^2+2*s+4);
Gzpk = zpk(G)

figure(1)
margin(G)

figure(2)
nyquist(G)