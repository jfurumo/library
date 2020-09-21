%function to convert from cartesian coordinates to orbital elements

%INPUTS
%state_cart is satellite state (column) vector in cartesian coordinates with the
%following format:
%[x (km)
% y (km)     
% z (km)
% x_dot (km/s)
% y_dot (km/s)
% z_dot (km/s)]

%OUPUTS
%state_oe is satellite state (column) vector in Keplerian orbital elements with the
%following format:
%[a (km)
% e     
% i (deg)
% Omega (deg)
% w (deg)
% nu (deg)]

function state_oe=cart2oe(state_cart,mu)
    %constants
    %mu=3.986e+005; %Earth gravitational parameter (km^3/s^2)
    x_hat=[1,0,0];
    y_hat=[0,1,0];
    z_hat=[0,0,1];
    %parse Cartesian state vector
    r=state_cart(1:3);
    v=state_cart(4:6);
    r_mag=norm(r);
    v_mag=norm(v);
    h=cross(r,v);
    h_mag=norm(h);
    n=cross(z_hat,h);
    n_mag=norm(n);
    n_hat=n/n_mag;
    epsilon=(v_mag^2/2)-(mu/r_mag);
    %semi-major axis, a (km)
    if epsilon == 0
        a = inf;
    else
        a=(-mu/(2*epsilon));
    end
    %eccentricity vector, e
    e=(1/mu)*(((v_mag)^2-(mu/r_mag))*r-dot(r,v)*v);
    e_mag=norm(e);
    %inclination, i (deg)
    i=acosd(dot(h,z_hat)/h_mag);
    %longitude of the ascending node, Omega (deg)
    Omega=acosd(dot(n_hat,x_hat));
    if dot(n,y_hat)<0
        Omega=360-Omega;
    else
        Omega=Omega;
    end
    %Omega=acosd(dot((cross(z_hat,h)/n),x_hat));
    %argument of periapsis, 2 (deg)
    w=acosd(dot(n,e)/(n_mag*e_mag));
    if e(3)<0
        w=360-w;
    else 
        w=w;
    end
    %true anomaly, nu (deg)
    nu=acosd(dot(e,r)/(e_mag*r_mag));
    if dot(r,v)/(r_mag*v_mag)>=0
        nu=nu;
        %nu=360-nu;
    elseif dot(r,v)/(r_mag*v_mag)<0
        nu=180+nu;
    end
    e=e_mag;
state_oe=[a;e;i;Omega;w;nu];