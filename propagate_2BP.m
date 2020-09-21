%this function propagates a 2BP orbit forward in time

%INPUTS
%state_initial - initial state vector in cartesian coordinates
%delta_t - time interval for propagation (s)
%mu - central body gravitational parameter (km^3/s^2)

%TEST
% clear all
% close all
% clc
% mu=3.986e+05; %km^3/s^2
% r=42164; %km
% v_0_HEO=1.1*sqrt(mu/r); %km/s
% state_initial=[r;0;0;0;v_0_HEO;0]; %initial state
% a=-mu/(v_0_HEO^2-2*mu/r); %km
% delta_t=12*3600; %s

function state_final = propagate_2BP(state_initial,delta_t,mu)

%convert initial state from cartesian coordinates to Keplerian orbital elements
state_oe=cart2oe(state_initial,mu);
r0=state_initial(1:3); %km
a=state_oe(1); %km
e=state_oe(2);
nu0=(state_oe(6)); %rad
%convert true anomaly to eccentric anomaly
E0=acos((e+cos(nu0))/(1+e*cos(nu0))); %rad
%solve Kepler's equation to find E after delta t
M0=E0-e*sin(E0); %rad
n=sqrt(mu/a^3); %rad/s
M=M0+n*delta_t; %rad
[~,E] = solve_Kepler_NR(M,e);

delta_E=E-E0; %rad

%Lagrange coefficients
f=1-(a/norm(r0))*(1-cos(delta_E));
g=delta_t-sqrt(a^3/mu)*(delta_E-sin(delta_E));
%state transition matrix
Phi_r=[f,0,0,g,0,0 ;
       0,f,0,0,g,0 ;
       0,0,f,0,0,g];     
r=Phi_r*state_initial; %km      

%Lagrange coefficients
f_dot=-sqrt(mu*a)*sin(delta_E)/(norm(r)*norm(r0));
g_dot=1-(a/norm(r))*(1-cos(delta_E));
%state transition matrix     
Phi_r_dot=[f_dot,0,0,g_dot,0,0 ;
           0,f_dot,0,0,g_dot,0 ;
           0,0,f_dot,0,0,g_dot];
r_dot=Phi_r_dot*state_initial; %km/s

state_final=[r;r_dot];