%This function reads ephemeris data from an STK ephemeris file into a cell array

function eph_STK = read_STK_ephem(path);

%open ephemeris file
fID = fopen(path,'r');
%initialize file line count
line = 1;
%read each file line into a cell
while feof(fID) == 0
    STKeph{line} = fgetl(fID);
    if contains(STKeph{line},'EphemerisTimePosVel')
        state_start = line + 2;
    end
    if contains(STKeph{line},'CovarianceTimePosVel')
        state_end = line - 3;
        cov_start = line + 2;
    end
    if contains(STKeph{line},'END Ephemeris')
        cov_end = line - 3;
    end
    line = line + 1;
end

STKeph = STKeph';

%close file
fclose(fID);

%ephem data point counter
n_epoch = 1;

%convert cell strings to state string array
for i = state_start : state_end
    
    %split string into state components
    eph_temp = split(string(STKeph(i)))';
    
    %parse epoch from string vector
    epoch = eph_temp(1);
    
    %parse state vector from string vector
    state = double(eph_temp(2:7))/1000;
    
    %load epoch and state into cell array
    eph_cell{n_epoch,1} = epoch;
    eph_cell{n_epoch,2} = state;
    n_epoch = n_epoch + 1;
    
end

%covariance file format parameters
int = 3;
gap = int - 3;

%reset data point counter
n_epoch = 1;

for i = cov_start:int:cov_end
    
    %temporarily store covariance matrix as string vector
    cov_mat = string(STKeph(i + gap : i + gap + 2));
    
    %split string vector into string array and convert to double data type
    res_cov = zeros(3,8);
    for a = 1:length(cov_mat)
        res_cov(a,:) = split(cov_mat(a))';
    end
    
    %remove NaN column (consequence of input file formatting)
    res_cov = res_cov(:,2:8);
    
    %convert 3x7 STK format to 6x6 lower triangular covariance matrix
    res_cov = res_cov';
    element = 1;
    for a = 1:6
        for b = 1:6
            if b > a
                temp_cov(a,b) = 0;
            else    
                temp_cov(a,b) = res_cov(element);
                element = element + 1;
            end
        end
    end
            
    %convert lower triangular matrix to full 6x6 covariance matrix
    for j = 1:length(temp_cov)-1
        for k = 2:length(temp_cov)
            temp_cov(j,k) = temp_cov(k,j);
        end
    end
       
    %load covariance into cell array
    eph_cell{n_epoch,3} = temp_cov;
    n_epoch = n_epoch + 1;
end

eph_STK = eph_cell;

%% ARCHIVED CODE


%         %folder pathway
%         folder=('C:\Users\john.furumo\Documents\repos\restore-gncgs-ggss\data\resources\GGSS\2019\134\ext\');
%         %file name
%         file=('L7_20191341200PREDEPH6X6.e');
%         %full pathway
%         path=strcat(folder,file);


%    state_pred(i - (state_start - 1),:) = split(string(predeph(i)));

    %state_pred(i - (data_start - 1),:) = str2num(state_pred(i - (data_start - 1),:));
%     epoch{i - (data_start - 1)} = predeph{i}(1:26);
%     state_cell{i - (data_start - 1)} = predeph{i}(29:170);
%     state_pred(i - (data_start - 1),:) = [str2num(predeph{i}(29:50)),...
%                                           str2num(predeph{i}(53:74)),...
%                                           str2num(predeph{i}(77:98)),...
%                                           str2num(predeph{i}(101:122)),...
%                                           str2num(predeph{i}(125:146)),...
%                                           str2num(predeph{i}(149:170))];

% 
% %parse epoch vector from array
% epoch_state = state_pred(:,1);
% 
% %convert state string array to numeric array
% state_pred = double(state_pred(:,2:7));


% %convert cell strings to covariance string array
% for i = cov_start:int:cov_end
%     
%     epoch_cov((i - cov_start)/int + 1) = string(predeph(i));
%     %cov_pred(i - (cov_start - 1) - (i - cov_start)/int : i - (cov_start - 1) - (i - cov_start)/int + 5,:) = string(predeph(i + gap : i + gap + 5))
%     cov_pred(((i - cov_start)/int)*6 + 1 : ((i - cov_start)/int)*6 + 6,:) = string(predeph(i + gap : i + gap + 5));
% end
% 
% epoch_cov = epoch_cov';
