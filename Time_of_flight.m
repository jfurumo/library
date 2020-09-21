%this function calculates the time of flight (ToF) between two points on a defined elliptical orbit

%INPUTS
%a = orbit semimajor axis (km)
%e = orbit eccentricity
%mu = gravitational parameter of central body (2BP)
%nu1 = initial true anomaly (deg)
%nu2 = final true anomaly (deg)
%k = number of orbits completed between initial and final positions

%OUTPUTS
%ToF = time of flight between initial and final positions (s)

function ToF = Time_of_flight(a,e,mu,nu1,nu2,k)
nu1=deg2rad(nu1); %rad
nu2=deg2rad(nu2); %rad
E1=acos((e+cos(nu1))/(1+e*cos(nu1))); %rad
E2=acos((e+cos(nu2))/(1+e*cos(nu2))); %rad
ToF=sqrt(a^3/mu)*(2*pi*k+(E2-e*sin(E2))-(E1-e*sin(E1))); %s