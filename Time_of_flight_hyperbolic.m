%this function calculates the time of flight (ToF) between two points on a defined hyperbolic orbit

%INPUTS
%a = orbit semimajor axis (km)
%e = orbit eccentricity
%mu = gravitational parameter of central body (2BP)
%nu1 = initial true anomaly (deg)
%nu2 = final true anomaly (deg)

%OUTPUTS
%ToF = time of flight between initial and final positions (s)

function ToF = Time_of_flight(a,e,mu,nu1,nu2)
nu1=deg2rad(nu1); %rad
nu2=deg2rad(nu2); %rad
F1=acosh((e+cos(nu1))/(1+e*cos(nu1))); %rad
F2=acosh((e+cos(nu2))/(1+e*cos(nu2))); %rad
ToF=sqrt((-a)^3/mu)*((e*sinh(F2)-F2)-(e*sinh(F1)-F1)); %s