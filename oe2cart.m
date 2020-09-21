%function to convert from orbital elements to cartesian coordinates

%INPUTS
%state_oe is satellite state (column) vector in Keplerian orbital elements with the
%following format:
%[a (km)
% e     
% i (deg)
% Omega (deg)
% w (deg)
% nu (deg)]

%OUTPUTS
%state_cart is satellite state (column) vector in cartesian coordinates with the
%following format:
%[x (km)
% y (km)     
% z (km)
% x_dot (km/s)
% y_dot (km/s)
% z_dot (km/s)]

function state_cart = oe2cart(state_oe,mu)
    %mu=3.986e+005; %km^3/s^2
    %parse OE state vector
    a=state_oe(1); %km
    e=state_oe(2); %unitless
    i=state_oe(3); %deg
    Omega=state_oe(4); %deg
    w=state_oe(5); %deg
    nu=state_oe(6); %deg
    %range at true anomaly (km)    
    r=(a*(1-e^2))/(1+e*cosd(nu));
    %perifocal position vector, r_p (km)
    r_pqw=[r*cosd(nu);r*sind(nu);0];
    %perifocal velocity vector, v_p (km/s)
    v_pqw=sqrt(mu/(a*(1-e^2)))*[(-sind(nu));(e+cosd(nu));0];
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