%this function solves Kepler's Equation using Newton-Raphson method, 
%converting mean anomaly, M to true anomaly, nu and eccentric anomaly, E

%INPUTS
%M - mean anomaly (radians)
%e - eccentricity

%OUTPUTS
%nu - true anomaly (radians)
%E - eccentric anomaly (radians)

function [nu,E] = solve_Kepler_NR(M,e)

    %Newton-Raphson method to calculate eccentric anomaly E
        tol=1e-013; %tolerance for iterations
        %initialize loop variables
        M1=M; %rad
        E=M1+((e*sin(M1))/(1-sin(M1+e)+sin(M1))); %rad
        M=E-e*sin(E); %rad
        while abs(M1-M)>tol
            E=E+(M1-(E-e*sin(E)))/(1-e*cos(E)); %rad
            M=E-e*sin(E); %rad
        end
    %convert eccentric anomaly, E to true anomaly nu
        nu=acos((e-cos(E))/(e*cos(E)-1));
    %check half-plane
        if (0<=M)&&(M<=pi)
            nu=nu;
        elseif (pi<=M)&&(M<=2*pi)
            nu=2*pi-nu;
        end
