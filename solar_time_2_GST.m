%this function converts local date and solar time to local sidereal time

%date format:           'MM/DD/YYYY'
%solar time format:       'HH:mm:ss'

function Theta_GST = solar_time_2_GST(date,solar_time)
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
%open txt file
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
%parse solar_time string 'HH:mm:ss'
n_hour=str2num(solar_time(1:2));
n_minute=str2num(solar_time(4:5));
n_second=str2num(solar_time(7:8));
%time from previous midnight to observation
t=n_hour*3600+n_minute*60+n_second; %seconds
%Greenwich sidereal time (at prime meridian)
w_earth=0.004178074; %deg/s
Theta_GST=Theta_GST0+w_earth*t; %deg