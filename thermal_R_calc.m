%this function calculates thermal resistance of a material to conductive heat
%transfer

%INPUTS
%L - length (m)
%k - thermal conductivity (W/m*K)
%A - area (m^2)

function R = thermal_R_calc(L,k,A)

R=L/(k*A);

