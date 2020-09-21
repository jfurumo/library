%ODE45 function to propagate orbit for two-body problem using canonical orbital
%planar state paramters

%INPUTS
%t - time span vector (passed through for ODE45 use)
%input - column vector with initial state (r,v,gamma,theta)
%mu - central body gravitational parameter (km^3/s^2)
%g0 - gravitational acceleration at central body radius (km/s^2)
%r0 - central body radius (km)
%rho_0 - atmospheric density at central body surface (kg/m^3)
%h_s - scale height of central body (km)
%m - mass of spacecraft (kg)
%A - cross sectional area of spacecraft (m^2)
%cD - drag coefficient of spacecraft
%beta - ballistic coefficient
%L_D - lift to drag ratio

function output = integrate_2BP_canonical_LD(t,input,mu,g0,r0,rho_0,h_s,beta,L_D,theta0);
%input vector
r=input(1); %km
v=input(2); %km/s
gamma=input(3); %rad
theta=input(4); %rad
% gamma=rad2deg(input(3)); %deg
% theta=rad2deg(input(4)); %deg

%calculated parameters
%gravitational acceleration
g=g0*(r0/r)^2; %km/s^2
%circular orbital velocity at altitude
vc=sqrt(mu/r); %km/s
%atmospheric density at altitude
rho=rho_0*exp(-(r-r0)/h_s); %kg/m^3
%lift/drag force parameter
D_m=(rho*(v*1000)^2)/(2*beta); %m/s^2
%deceleration
%n=-1/((2*beta/(rho_0*r0*1000))*exp((r-r0)/h_s)+L_D);
n=D_m*sqrt(1+L_D^2)*exp(-(r-r0)/h_s); %m/s^2
%terminal velocity
vT=sqrt(-(2*g*(beta*1e+06)*sin(-pi/2))/(rho*1e+09)); %km/s
%downrange distance
dd=(2*pi*r0)*(theta-theta0)/(2*pi); %km

%output vector
output(1)=v*sin(gamma);
output(2)=-D_m-g*sin(gamma);
output(3)=(1/v)*(D_m*L_D-(1-((v^2)/(vc^2)))*g*cos(gamma));
output(4)=(v/r)*cos(gamma);
output(5)=-n;
output(6)=vT;
output(7)=dd;
output=output';

