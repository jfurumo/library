%function to convert TLE data from text file to state vector of Keplerian OEs
function state_oe = TLE2state(path);
format shortg;
% %folder pathway
%     folder=('C:\Users\jfuru\Desktop\UMD\Fall 2019\ENAE 441\assignments\TLE\');
% %file name
%     file=('ISS.txt');
% %full pathway
%     path=[folder file];
%open TLE file
fID = fopen(path,'r');
%read data from TLE txt file - Line 1
L1 = fgetl(fID);
%read data from TLE txt file - Line 2
L2 = fgetl(fID);
%read orbital elements from TLE line 2
i    = str2num(L2(9:16)); %deg
RAAN = str2num(L2(18:25)); %deg
e    = str2num(strcat('.',L2(27:33))); %unitless
w    = str2num(L2(35:42)); %deg
M    = str2num(L2(44:51)); %deg
n    = str2num(L2(53:63)); %rev/day
%close file
fclose(fID);
%convert mean motion to semi-major axis, a
mu=3.986e+005; %mu Earth (km^3/s^2)
n=n*(2*pi/86400); %rad/s
a=(mu/n^2)^(1/3); %km
%convert mean anomaly, M to true anomaly, nu
nu = solve_Kepler_NR(M,e);
%output state vector of Keplerian OEs
state_oe=[a;e;i;RAAN;w;nu];