% This script reads ephemeris data from an STK ephemeris (.e) file into a 
% MATLAB struct (.mat) file containing the following information:
%
%   Coordinate system (string)
%   Start time        (struct)
%   State epochs      (n x 1 array)
%   State vectors     (n x 6 array)

% clear workspace and command window
clear all
clc

%% STK ephem path
folder = 'C:\Users\john.furumo\Documents\repos\DOWD\TDM\LandSat-8_DOWD\Ephemeris';
ephem_file = 'Sat_TDRS-12_Smooth_20210428_130000.e';
mat_file = 'ephem.mat';
ephem_path = [folder,'\',ephem_file];
mat_path = [folder,'\',mat_file];

%% Read STK ephem file into cell array and parse header

%open ephemeris file
fID = fopen(ephem_path,'r');

%initialize file line count
line = 1;

%covariance flag denotes presence of covariance data in file (will be
%ignored)
covariance_flag = 0;

%read each file line into a cell
while feof(fID) == 0
    
    STKeph{line} = fgetl(fID);
    
    %parse coordinate system from header
    if contains(STKeph{line},'CoordinateSystem')
        
        coord_sys = split(strip(string(STKeph(line))));
        ephem.coordinate_system = coord_sys(2); %coordinate system string
        
    end
    
    %parse time of first point from header
    if contains(STKeph{line},'# Time of first point')
        
        tfirstpt = strip(split(string(STKeph(line)),'='));
        
        %UTC format
        temp_UTC = regexp(tfirstpt(1),':','split','once');
        temp_UTC = strip(temp_UTC(2));
        temp_UTC = split(temp_UTC);        
        
            %parse UTC date
            start_time.date = double(temp_UTC(1));

            %parse UTC month
            if temp_UTC(2) == "Jan"
                start_time.month = 1;
            elseif temp_UTC(2) == "Feb"
                start_time.month = 2;
            elseif temp_UTC(2) == "Mar"
                start_time.month = 3;
            elseif temp_UTC(2) == "Apr"
                start_time.month = 4;    
            elseif temp_UTC(2) == "May"
                start_time.month = 5;
            elseif temp_UTC(2) == "Jun"
                start_time.month = 6;
            elseif temp_UTC(2) == "Jul"
                start_time.month = 7;
            elseif temp_UTC(2) == "Aug"
                start_time.month = 8;
            elseif temp_UTC(2) == "Sep"
                start_time.month = 9;
            elseif temp_UTC(2) == "Oct"
                start_time.month = 10;
            elseif temp_UTC(2) == "Nov"
                start_time.month = 11;
            elseif temp_UTC(2) == "Dec"
                start_time.month = 12;
            end    

            %parse UTC year    
            start_time.year = double(temp_UTC(3));

            %parse UTC hh:mm:ss
            temp_hhmmss = double(split(temp_UTC(4),':'));
            start_time.hour = temp_hhmmss(1);
            start_time.minute = temp_hhmmss(2);
            start_time.second = temp_hhmmss(3);

            %parse UTC string
            temp_UTC = temp_UTC(1:4);
            start_time.UTC = join(temp_UTC);
        
        %JD format
        temp_JD = split(tfirstpt(2));
        start_time.JD = double(temp_JD(1));
        
        %YYDDD format
        temp_YYDDD = split(tfirstpt(3));
        start_time.YYDDD = double(temp_YYDDD(1));
        
        %load ephem struct
        ephem.start_time = start_time;

    end
    
    %parse ephem start line from file
    if contains(STKeph{line},'EphemerisTimePosVel')
        header_end = line - 1;
        state_start = line + 2;
    end
    
    if contains(STKeph{line},'CovarianceTimePos')
        covariance_flag = 1;
        state_end = line - 3;
    elseif contains(STKeph{line},'END Ephemeris') & covariance_flag == 0
        state_end = line - 3;
    end
    
    line = line + 1;
    
end

STKeph = STKeph';

%number of state vectors in file
n_state = state_end + 1 - state_start;

%close file
fclose(fID);

%% Parse epoch and state from cell array

%loop over all state vectors
for i = 1 : n_state
        
    %split string into epoch and state components
    eph_temp = split(strip(string(STKeph(i + state_start - 1))))';

    %parse epoch from string vector
    epoch(i) = double(eph_temp(1));

    %parse state vector from string vector
    state(i,:) = double(eph_temp(2:7));
    
end

%load ephem struct
ephem.epoch = epoch';
ephem.state = state;

%% Save struct

%save test data struct to .mat file
save(mat_path,'ephem');

clearvars -except ephem



