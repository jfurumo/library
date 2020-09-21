%ODE45 function to propagate orbit for two-body problem using canonical orbital
%planar state paramters

%INPUTS
%t - time span vector (passed through for ODE45 use)
%input - column vector with initial state (r,v,gamma,theta,m)
%mu - central body gravitational parameter (km^3/s^2)
%g0 - gravitational acceleration at central body radius (km/s^2)
%r0 - central body radius (km)

function output = integrate_2BP_canonical(t,input,mu,g0,r0);
%input vector
r=input(1); %km
v=input(2); %km/s
gamma=input(3); %rad
theta=input(4); %rad
%calculated parameters
g=g0*(r0/r)^2; %km/s^2
vc=sqrt(mu/r); %km/s
%output vector
output(1)=v*sin(gamma);
output(2)=-g*sin(gamma);
output(3)=(-1/v)*(1-v^2/vc^2)*g*cos(gamma);
output(4)=(v/r)*cos(gamma);
output(5)=0; %placeholder for mass
output=output';

