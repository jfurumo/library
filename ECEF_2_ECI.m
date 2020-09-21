%function to convert vector in ECEF coordinates to ECI (IJK) coordinates
%date format:           'MM/DD/YYYY'
%solar time format:       'HH:mm:ss'

function vec_ECI = ECEF_2_ECI(vec_ECEF,date,time)
%convert solar time and date to GST
theta = solar_time_2_GST(date,time);
%rotation matrix
R_ECEF_ECI=[cosd(theta),-sind(theta),0;
            sind(theta),cosd(theta),0;
            0,0,1];
%ECI vector
vec_ECI=R_ECEF_ECI*vec_ECEF;