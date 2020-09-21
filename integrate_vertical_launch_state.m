%ODE45 function to propagate planar launch trajectory for two-body problem using canonical
%planar state parameters

%INPUTS
%t - time span vector (passed through for ODE45 use)
%X - column vector with initial state (r,v,gamma,theta,m)
%mu - central body gravitational parameter (km^3/s^2)
%g0 - gravitational acceleration at central body radius (km/s^2)
%r0 - central body radius (km)
%rho_0 - atmospheric density at central body surface (kg/m^3)
%h_s - scale height of central body (km)
%A - cross sectional area of spacecraft (m^2)
%c_D - drag coefficient of spacecraft
%T - rocket engine thrust (N)
%m_dot_prop - propellant mass flow rate (kg/s)

function launch_state = integrate_vertical_launch_state(t,X,mu,g0,r0,rho_0,h_s,A,c_D,T,m_dot_prop);

%input state vector
r=X(1); %m
v=X(2); %m/s
gamma=X(3); %placeholder for gamma (deg)
theta=X(4); %placeholder for thetaa (deg)
m=X(5); %kg

%calculated parameters
%gravitational acceleration
g=g0*(r0/r)^2; %m/s^2
%atmospheric density at altitude
rho=rho_0*exp(-(r-r0)/h_s); %kg/m^3
%ballistic coefficient
beta=m/(A*c_D); %kg/m^2

%output vector
launch_state(1)=v; %v (m/s)
launch_state(2)=(-g-0.5*(rho*(v^2)/beta)+(T/m)); %v_dot (m/s^2)
launch_state(3)=0; %placeholder for gamma
launch_state(4)=0; %placeholder for theta
launch_state(5)=-m_dot_prop; %m_dot (kg/s)


launch_state=launch_state';

