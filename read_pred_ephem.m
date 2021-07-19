%This function reads ephemeris data from an L7 predictive ephemeris file into a cell array

function eph_pred = read_pred_eph(path);

%open ephemeris file
fID = fopen(path,'r');
%initialize file line count
line = 1;
%read each file line into a cell
while feof(fID) == 0
    predeph{line} = fgetl(fID);
    if contains(predeph{line},'META_STOP')
        state_start = line + 1;
    end
    if contains(predeph{line},'COVARIANCE_START')
        state_end = line - 2;
        cov_start = line + 1;
    end
    if contains(predeph{line},'COVARIANCE_STOP')
        cov_end = line - 1;
    end
    line = line + 1;
end

predeph = predeph';

%close file
fclose(fID);

%ephem data point counter
n_epoch = 1;

%convert cell strings to state string array
for i = state_start : state_end
    
    %split string into state components
    eph_temp = split(string(predeph(i)))';
    
    %parse epoch from string vector
    epoch = eph_temp(1);
    
    %parse state vector from string vector
    state = double(eph_temp(2:7));
    
    %load epoch and state into cell array
    eph_cell{n_epoch,1} = epoch;
    eph_cell{n_epoch,2} = state;
    n_epoch = n_epoch + 1;
    
end

%covariance file format parameters
int = 8;
gap = int - 6;

%reset data point counter
n_epoch = 1;

for i = cov_start:int:cov_end
    
    %temporarily store covariance matrix as string vector
    cov_mat = string(predeph(i + gap : i + gap + 5));
    
    %split string vector into string array and convert to double data type
    res_cov = zeros(6,6);
    for a = 1:length(cov_mat)
        res_cov(a,1:a) = split(cov_mat(a))';
    end
       
    %convert lower triangular matrix to full 6x6 covariance matrix
    for j = 1:length(res_cov)-1
        for k = 2:length(res_cov)
            res_cov(j,k) = res_cov(k,j);
        end
    end
      
    %load covariance into cell array
    eph_cell{n_epoch,3} = res_cov;
    n_epoch = n_epoch + 1;
end

eph_pred = eph_cell;

%% ARCHIVED CODE


% %folder pathway
% folder=('C:\Users\john.furumo\Documents\repos\restore-gncgs-ggss\data\resources\GGSS\2019\134\ext\');
% %file name
% file=('RSV_2019134_123753_PREDEPHEM_MJ2K_NOMINAL.txt');
% %full pathway
% path=strcat(folder,file);

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
