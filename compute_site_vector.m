%this function computes an observatory's site vector using inputs of latitude, longitude, altitude, date, and local solar time

%latitude  format:  'XXdegXX'XX.XX"D'
%longitude format: 'XXXdegXX'XX.XX"D'
%altitude format:            'XXXXUU'
%date format:            'MM/DD/YYYY'
%solar time format:        'hh:mm:ss'

function [R_site,phi,Theta_LST] = compute_site_vector(latitude,longitude,altitude,date,solar_time)
%constants
radius_earth=6378; %km
sidereal_day=86164.090524; %s
w_earth=(2*pi/sidereal_day)*(180/pi); %deg/s
%parse latitude string
deg_lat=str2num(latitude(1:2));
arcmin_lat=str2num(latitude(6:7));
arcsec_lat=str2num(latitude(9:13));
direction_lat=latitude(15);
%compute latitude decimal value (deg)
phi=deg_lat+(arcmin_lat/60)+(arcsec_lat/3600);
%quantify latitude direction
if direction_lat == 'N'
phi=phi; %north latitude is positive
else direction_lat == 'S'
phi=-phi; %south latitude is negative
end
%parse longitude string
deg_long=str2num(longitude(1:3));
arcmin_long=str2num(longitude(7:8));
arcsec_long=str2num(longitude(10:14));
direction_long=longitude(16);
%compute longitude decimal value (deg)
lambda=deg_long+(arcmin_long/60)+(arcsec_long/3600);
%quantify longitude direction
if direction_long == 'E';
lambda=lambda; %east longitude is positive
else direction_long == 'W';
lambda=-lambda; %west longitude is negative
end
%parse altitude string
z=str2num(altitude(1:4));
z_unit=altitude(5);
%ensure altitude units in km
if z_unit == 'k';
z=z; %leave in km
else z_unit == 'm';
z=z/1000; %convert m to km
end
%parse date string 'MM/DD/YYYY'
n_month=str2num(date(1:2));
n_day=str2num(date(4:5));
n_year=str2num(date(7:10));
%J2000 day number data
folder=('C:\Users\jfuru\Desktop\UMD\Fall 2019\ENAE 441\assignments\');
%file name
file=('J2000 day number.txt');
%full pathway
path=strcat(folder,file);
%open TLE file
fID = fopen(path,'r');
%read data from J2000 day number txt file
k=1;
while feof(fID) == 0
L{k} = fgetl(fID);
k=k+1;
end
%find row in data file
i=n_month+1; %row number
%find column in data file
if n_year == 2019
    j=1;
else n_year > 2019
    j=n_year-2019+1;
end
%parse J2000 day number from txt file
J2000_day=str2num(L{i}(7+5*(j-1):7+5*(j-1)+4));
%close J2000 day number txt file
fclose(fID);
T=(J2000_day+n_day+0.5)/36525;
Theta_GST0=100.4606184+36000.77004*T+0.000387933*T^2-(2.583*10^-8)*T^3; %deg
%parse solar time string 'hh:mm:ss'
n_hour=str2num(solar_time(1:2));
n_minute=str2num(solar_time(4:5));
n_second=str2num(solar_time(7:8));
%time from previous midnight to observation
t=n_hour*3600+n_minute*60+n_second; %seconds
%sidereal time at prime meridian
Theta_GST=Theta_GST0+w_earth*t; %deg
%local sidereal time
Theta_LST=Theta_GST+lambda;
%rotation matrix from ECF to IJK coordinates
R_ECF_IJK=[cosd(Theta_LST),-sind(Theta_LST),0 
           sind(Theta_LST), cosd(Theta_LST),0 
                         0,               0,1];
%ECEF site vector  
R_ECF=[(radius_earth+z)*cosd(phi) 
                                0 
       (radius_earth+z)*sind(phi)];
%IJK site vector   
R_site=R_ECF_IJK*R_ECF;
    