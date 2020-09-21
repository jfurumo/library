%ODE45 function to propagate planar launch trajectory for two-body problem using canonical
%planar state parameters

%INPUTS
%t - time span vector (passed through for ODE45 use)
%X - column vector with initial state (r,v,gamma,theta,m)
%U - column vector with control inputs (T,phi)
%mu - central body gravitational parameter (km^3/s^2)
%r0 - central body radius (km)
%rho_0 - atmospheric density at central body surface (kg/m^3)
%h_s - scale height of central body (km)
%A - cross sectional area of spacecraft (m^2)
%c_D - drag coefficient of spacecraft
%L_D - lift to drag ratio

function launch_state = integrate_planar_launch_state(t,X,U,mu,r0,rho_0,h_s,A,c_D,L_D);

%input state vector
r=X(1); %km
v=X(2); %km/s
gamma=X(3); %rad
theta=X(4); %rad
m=X(5); %kg

%input control vector
T=U(1); %thrust (N)
phi=U(2); %thrust vector angle (rad)
v_e=U(3); %exhaust velocity (km/s)

%calculated parameters
%atmospheric density at altitude
rho=rho_0*exp(-(r-r0)/h_s); %kg/m^3

%output vector
launch_state(1)=v*sin(gamma); %r (km)
launch_state(2)=(-mu*sin(gamma)/r^2)-0.5*(rho*(v^2)*(c_D*A/m))+(T/m)*cos(phi); %v (km/s)
launch_state(3)=(-mu*cos(gamma)/r^2)+0.5*(rho*(v^2)*(c_D*A/m)*(L_D))+v*cos(gamma)/r+(T/(v*m))*sin(phi); %gamma (rad)
launch_state(4)=(v/r)*cos(gamma); %theta (rad)
launch_state(5)=-T/v_e; %m (kg)

launch_state=launch_state';

