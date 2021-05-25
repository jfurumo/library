%This function reads ephemeris data from an ORB file into an array

% %folder pathway
% folder=('C:\Users\jfuru\Desktop\UMD\Spring 2021\ENAE 741\Assignments\1\');
% %file name
% file=('ast_2013_BS45_1932-01-01_to_2030-02-15_step_1d.orb');
% %full pathway
% path=strcat(folder,file);

function ephemeris = readORB(path);
%open ORB file
fID = fopen(path,'r');
%initialize file line count
line=1;
%read each file line into a cell
while feof(fID) == 0
    ORB{line} = fgetl(fID);
    line=line+1;
end
%total number of lines of data in ORB file
line_count = line-1;
%convert cell strings to numerical array
for i = 1:line_count
    ephemeris(i,:) = str2num(ORB{i});
end
%close file
fclose(fID);