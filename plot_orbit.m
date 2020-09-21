%this function plots an orbit in inertial space

%INPUTS
%state - state vector of body on orbit in orbital elements or cartesian
%        coordinates
%state_format - 'cart' (cartesian coordinates) or 'OE' (orbital elements)
%mu - 2BP gravitational parameter (km^3/s^2)
%center - origin of orbit, attracting focus in 2BP
%time_span - time to propagate orbit (s)
%resolution - data sampling rate
%name (string) - name of body or orbit
%color - color of plot

function orbit = plot_orbit(state,...
                            state_format,...
                            mu,...
                            center,...
                            time_span,...
                            resolution,...
                            name,...
                            color);

%determine format of input state
    if strcmp(state_format,'cart') == 1
        state=state; %keep state in cartesian coordinates
    elseif strcmp(state_format,'OE') == 1
        state=oe2cart(state,mu); %convert OE to cartesian coordinates
    end
    
%Numerical integration of orbits (2BP)
    tspan=linspace(0,time_span,resolution); %s
    tolerance=1e-013;
    options = odeset('RelTol',tolerance,'AbsTol',tolerance);
    [t,rv]=ode45(@integrate_2BP,tspan,state,options,mu);

%plot orbit
    sphere_center=plot3(center(1),center(2),center(3),strcat(color,'o'));
    axis equal
    hold on
    orbit=plot3(rv(:,1),rv(:,2),rv(:,3),color);