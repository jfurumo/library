%% Gibbs's Method solver
%this function determines orbital elements for a spacecraft given three position observations in time

%INPUTS
%r1 - spacecraft position vector at t1 (ECI)
%r2 - spacecraft position vector at t2 (ECI)
%r3 - spacecraft position vector at t3 (ECI)
%mu - 2BP gravitational parameter (km^3/s^2)
%plots - 'plots ON' or 'plots OFF', depending on if plots desired

%OUTPUTS
%state1 - spacecraft state vector at t1 (Keplerian orbital elements)
%state2 - spacecraft state vector at t2 (Keplerian orbital elements)
%state3 - spacecraft state vector at t3 (Keplerian orbital elements)

function OE = Gibbs_Method(r1,r2,r3,mu,plots)

    %Gibbs Method algorithm
    D=cross(r2,r3)+cross(r3,r1)+cross(r1,r2);
    N=cross(norm(r1)*r2,r3)+cross(norm(r2)*r3,r1)+cross(norm(r3)*r1,r2);
    S=(norm(r1)-norm(r2))*r3+(norm(r3)-norm(r1))*r2+(norm(r2)-norm(r3))*r1;
    v2=sqrt(mu/(norm(N)*norm(D)))*(cross(D,r2)/norm(r2)+S)
    %spacecraft state vector
    state2=[r2;v2]; %cartesian state vector
    state2=cart2oe(state2,mu); %orbital elements
    P=2*pi*sqrt((state2(1)^3)/mu); %orbit period (s)
    OE=state2(1:5); %2BP time-invariant orbital elements
    
    %plots
    if strcmpi(plots,'plots ON') == 1
        figure('name','Gibbs Method')
        origin=[0,0,0];
        R_earth=6378; %km
        %plot base
        plot3(0,0,0);
        hold on;
        plot_ECI();
        plot_sphere(origin,R_earth,12,'Earth','b');
        %plot vectors
        plot_vector_3D(r1,origin,'g','--','x');
        plot_vector_3D(r2,origin,'y','--','x');
        plot_vector_3D(r3,origin,'r','--','x');
        plot_orbit(state2,'OE',mu,origin,P,100,'orbit','k');
        hold off;
    elseif strcmpi(plots,'plots OFF') == 1
        
    else
        disp('Invalid Plots Selection')
    end
    
    
