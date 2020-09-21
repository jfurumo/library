%this function converts a satellite's topocentric horizon (ENZ) coordinates to geocentric equatorial (IJK) coordinates

%latitude  format:  'XXdegXX'XX.XX"D'
%longitude format: 'XXXdegXX'XX.XX"D'
%altitude format:  'XXXXUU'
%date format:      'MM/DD/YYYY'
%LST format:       'HH:mm:ss'

function r_IJK = ENZ_2_IJK(azimuth,elevation,range,latitude,longitude,altitude,date,solar_time)
%convert angles and range to topocentric horizon vector
p_ENZ=[range*cosd(elevation)*sind(azimuth);
       range*cosd(elevation)*cosd(azimuth);
       range*sind(elevation)];
%compute site vector, latitude angle (decimal), and local sidereal time
[R_site,phi,Theta_LST] = compute_site_vector(latitude,longitude,altitude,date,solar_time);   
%latitude rotation matrix
R_lat=[1,0,0;
       0,cosd(phi-90),sind(phi-90);
       0,-sind(phi-90),cosd(phi-90)];
%longitude rotation matrix
R_long=[cosd(-90-Theta_LST),sind(-90-Theta_LST),0
        -sind(-90-Theta_LST),cosd(-90-Theta_LST),0
        0,0,1];
%convert vector from ENZ to TCE coordinates
p_TCE=R_long*R_lat*p_ENZ;
%add site vector
R_site
%compute geocentric equatorial vector
r_IJK=p_TCE+R_site;

