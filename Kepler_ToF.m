%this function calculates the time of flight between two points on a given orbit
%this is Kepler's Time of Flight Problem

%INPUTS
%state_0 - initial spacecraft state, Keplerian orbital elements
%state_f - final spacecraft state, Keplerian orbital elements
%mu - 2BP gravitational parameter (km^3/s^2)
%k - number of complete revolutions between states on elliptical orbit
%p - semilatus rectum if orbit is parabolic (p = 2 * radius of periapsis)
%plots - 'plots ON' or 'plots OFF', depending on if plots desired

%OUTPUTS
%ToF - time of flight (seconds)

function ToF = Kepler_ToF(state_0,state_f,mu,k,p,plots)

    %parse orbital elements from input state vectors
    a_0=state_0(1); %initial semimajor axis (km)
    e_0=state_0(2); %initial eccentricity
    nu_0=deg2rad(state_0(6)); %initial true anomaly (rad)
    nu_f=deg2rad(state_f(6)); %final true anomaly (rad)

    if e_0 < 1
        E_f = acos((e_0+cos(nu_f))/(1+e_0*cos(nu_f)));
        E_0 = acos((e_0+cos(nu_0))/(1+e_0*cos(nu_0)));
        ToF = sqrt((a_0^3)/mu)*(2*pi*k+(E_f-e_0*sin(E_f))-(E_0-e_0*sin(E_0)));
    elseif e_0 > 1
        F_f = acosh((e_0+cos(nu_f))/(1+e_0*cos(nu_f)));
        F_0 = acosh((e_0+cos(nu_0))/(1+e_0*cos(nu_0)));
        ToF = sqrt(((-a_0)^3)/mu)*((e_0*sinh(F_f)-F_f)-(e_0*sinh(F_0)-F_0));
    elseif e_0 == 1
        D_f=sqrt(p)*tan(nu_f/2);
        D_0=sqrt(p)*tan(nu_0/2);
        ToF = (1/(2*sqrt(mu)))*((p*D_f+(D_f^3)/3)-(p*D_0+(D_0^3)/3));
    else
        disp('error - eccentricity is out of bounds')
    end

    if strcmpi(plots,'plots ON') == 1
        figure('name','Kepler Time of Flight')
        origin=[0,0,0];
        R_earth=6378; %km
        %plot base
        plot3(0,0,0);
        hold on;
        plot_ECI();
        plot_sphere(origin,R_earth,12,'Earth','b');
        %plot vectors
        state_0=oe2cart(state_0,mu); %convert OE to cartesian coordinates
        state_f=oe2cart(state_f,mu); %convert OE to cartesian coordinates
        plot_vector_3D(state_0(1:3),origin,'g','--','x');
        plot_vector_3D(state_f(1:3),origin,'r','--','x');
        plot_orbit(state_0,'cart',mu,origin,ToF,100,'orbit','k');
        hold off;
    elseif strcmpi(plots,'plots OFF') == 1
        
    else
        disp('Invalid Plots Selection')
    end
