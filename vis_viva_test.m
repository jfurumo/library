clear
clc

mu = 3.986e+05;

R_E = 6378; %Earth radius (km)
alt = 500; %orbit perigee altitude (km)
r_p = R_E + alt;
e = [0:0.01:1]';
a = r_p./(1-e);

v = sqrt(mu*(2/r_p - 1./a));

plot(e,v)
