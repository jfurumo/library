%ODE45 function to propagate orbit for two-body problem using Cartesian position
%and velocity state variables

%INPUTS
%t - time interval (passed through to ODE45) %s
%input - initial Cartesian state vector (column) %km & %km/s
%mu - gravitational parameter of central body %km^3/s^2

function output = integrate_2BP(t,input,mu);
output(1)=input(4);
output(2)=input(5);
output(3)=input(6);
r=norm(input(1:3));
output(4)=(-mu/r^3)*input(1);
output(5)=(-mu/r^3)*input(2);
output(6)=(-mu/r^3)*input(3);
output=output';
