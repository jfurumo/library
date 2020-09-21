%% Kepler's Prediction Problem solver
%this function calculates the final state of a spacecraft on a known orbit,
%given its initial state and time of flight between the two states

%INPUTS
%state_0 - initial spacecraft state
%state_format - 'cart' (cartesian coordinates) or 'OE' (orbital elements)
%ToF - time of flight between initial and final states
%ToF_unit - '
%mu - 2BP gravitational parameter (km^3/s^2)
%p - semilatus rectum if orbit is parabolic (p = 2 * radius of periapsis)

%OUTPUTS
%state_f - final spacecraft state
%k - number of complete revolutions between states on closed orbit

function [state_f,k] = KPP(state_0,...
                       state_format,...
                       ToF,...
                       ToF_unit,...
                       mu,...
                       p)

%determine format of input state
    if strcmp(state_format,'cart') == 1
        state_0=cart2oe(state_0,mu); %convert cartesian to OE
    elseif strcmp(state_format,'OE') == 1
        state_0=state_0; %keep state in OE
    end
    
%determine units of ToF and convert to seconds if necessary
    if strcmp(ToF_unit,'year') == 1  
        ToF=ToF*31536000; %year to seconds conversion
    elseif strcmp(ToF_unit,'month') == 1
        ToF=ToF*2592000; %month to seconds conversion (based on 30 days in a month)
    elseif strcmp(ToF_unit,'day') == 1
        ToF=ToF*86400; %day to seconds conversion
    elseif strcmp(ToF_unit,'hour') == 1
        ToF=ToF*3600; %hour to seconds conversion
    elseif strcmp(ToF_unit,'minute') == 1
        ToF=ToF*60; %minute to seconds conversion
    elseif strcmp(ToF_unit,'second') == 1
        ToF=ToF; %units stay in seconds
    end
    
%parse orbital elements from input state vectors
    a_0=state_0(1); %initial semimajor axis (km)
    e_0=state_0(2); %initial eccentricity
    nu_0=deg2rad(state_0(6)); %initial true anomaly (rad)
    n=sqrt(mu/(a_0^3)); %mean motion (rad/s)
    P=2*pi*sqrt((a_0^3)/mu); %orbit period (s)
    k=floor(ToF/P); %number of complete orbits between initial and final states

%solve KPP
    if e_0 < 1
        E_0 = acos((e_0+cos(nu_0))/(1+e_0*cos(nu_0))); %initial eccentric anomaly (rad)
        M_0=E_0-e_0*sin(E_0); %initial mean anomaly (rad)
        M_f=M_0+n*ToF; %final mean anomaly (rad)
        [nu_f,~] = solve_Kepler_NR(M_f,e_0); %final true anomaly (rad)
        nu_f=rad2deg(nu_f); %convert radians to degrees
        state_f=[state_0(1:5);nu_f]; %final state (orbital elements)
    elseif e_0 > 1
        F_0 = acosh((e_0+cos(nu_0))/(1+e_0*cos(nu_0))); %initial eccentric anomaly (rad)
        M_0=e_0*sinh(F_0)-F_0; %initial mean anomaly (rad)
        M_f=M_0+n*ToF; %final mean anomaly (rad)
        [nu_f,~] = solve_Kepler_NR(M_f,e_0); %final true anomaly (rad)
        state_f=[state_0(1:5);nu_f]; %final state (orbital elements)
    elseif e_0 == 1
        D_f=sqrt(p)*tan(nu_f/2);
        D_0=sqrt(p)*tan(nu_0/2);
        ToF = (1/(2*sqrt(mu)))*((p*D_f+(D_f^3)/3)-(p*D_0+(D_0^3)/3));
    else
        disp('error - eccentricity is out of bounds')
    end

