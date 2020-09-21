%function to convert from canonical state elements to cartesian coordinates

%INPUTS
%state_oe is satellite state (column) vector in canonical orbital elements with the
%following format:
% radius, r (km)
% velocity, v (km/s)     
% FPA, gamma (deg)
% True anomaly, theta (deg)
% mass, m (kg)
% gravitational parameter, mu (km^3/s^2)

function state_cart = oe2cart(state_canon,mu)
    
    %parse canonical state vector
    r=state_canon(1); %km
    v=state_canon(2); %km/s
    gamma=state_canon(3); %deg
    theta=state_canon(4); %deg
    m=state_canon(5); %kg
    
    %derived quantities
    p=((r^2)*(v^2)*(cosd(gamma))^2)/mu; %semi-latus rectum (km)
    e=(1/cosd(theta))*(p/r-1); %eccentricity
    
    
    %perifocal position vector, r_p (km)
    r_pqw=[r*cosd(theta);r*sind(theta);0];
    %perifocal velocity vector, v_p (km/s)
    v_pqw=sqrt(mu/p)*[(-sind(theta));(e+cosd(theta));0];
    %Rotation matrix, w
    R_w=[cosd(w),sind(w),0;-sind(w),cosd(w),0;0,0,1];
    %Rotation matrix, i
    R_i=[1,0,0;0,cosd(i),sind(i);0,-sind(i),cosd(i)];
    %Rotation matrix, Omega
    R_Omega=[cosd(Omega),sind(Omega),0;-sind(Omega),cosd(Omega),0;0,0,1];
    %Combined rotation matrix 3-1-3
    R_131=(R_w*R_i*R_Omega)';
    %R_131=(R_Omega*R_i*R_w)';
    %ECI spacecraft position vector (km)
    r_i=R_131*r_pqw;
    %r_i_mag=norm(r_pqw);
    %ECI spacecraft velocity vector (km/s)
    v_i=R_131*v_pqw;
    %v_i_mag=norm(v_pqw);
    %initial orbit vector
    state_cart=[r_i;v_i];