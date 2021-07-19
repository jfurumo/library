%This function reads ephemeris data from an L7 definitive ephemeris file into a cell array

function eph_def = read_def_eph(path);

%open epheneris file
fID = fopen(path,'r');
%initialize file line count
line = 1;
%read each file line into a cell
while feof(fID) == 0
    defeph{line} = fgetl(fID);
    if contains(defeph{line},'META_STOP')
        state_start = line + 2;
    end
    if contains(defeph{line},'COVARIANCE_START')
        state_end = line - 2;
        cov_start = line + 1;
    end
    if contains(defeph{line},'COVARIANCE_STOP')
        cov_end = line - 1;
    end
    line = line + 1;
end

defeph = defeph';

%close file
fclose(fID);

%ephem data point counter
n_epoch = 1;

%convert cell strings to state string array
for i = state_start : state_end

    %split string into state components
    eph_temp = split(string(defeph(i)))';
    
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
int = 7;
gap = int - 6;

%reset data point counter
n_epoch = 1;

for i = cov_start:int:cov_end
    
    %temporarily store covariance matrix as string vector
    cov_mat = string(defeph(i + gap : i + gap + 5));
    
    %split string vector into string array and convert to double data type
    res_cov = zeros(6,7);
    for a = 1:length(cov_mat)
        res_cov(a,1:a+1) = split(cov_mat(a))';
    end
    
    %remove NaN column (consequence of input file formatting)
    res_cov = res_cov(:,2:7);
    
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

eph_def = eph_cell;

%% ARCHIVED CODE

% clear all
% clc
% close all

% %folder pathway
% folder=('C:\Users\john.furumo\Documents\repos\restore-gncgs-ggss\data\resources\GGSS\2019\134\ext\');
% %file name
% file=('RSV_20190514_000000_DEFEPHEM_MJ2K_02_NOMINAL.oem');
% %full pathway
% path=strcat(folder,file);

    %split string into state components
%     state_def(i - (state_start - 1),:) = split(string(defeph(i)))';
    %     epoch_cov((i - cov_start)/int + gap) = string(defeph(i));
%     cov_def(((i - cov_start)/int)*6 + 1 : ((i - cov_start)/int)*6 + 6,:) = res_cov;

%convert cell strings to state string array
% for i = state_start : state_end
%     
%     state_def(i - (state_start - 1),:) = split(string(defeph(i)));
%     epoch{i - (data_start - 1)} = defeph{i}(1:26);
%     state_cell{i - (data_start - 1)} = defeph{i}(29:170);
%     state_def(i - (data_start - 1),:) = [str2num(defeph{i}(29:50)),...
%                                          str2num(defeph{i}(53:74)),...
%                                          str2num(defeph{i}(77:98)),...
%                                          str2num(defeph{i}(101:122)),...
%                                          str2num(defeph{i}(125:146)),...
%                                          str2num(defeph{i}(149:170))];
% 
% end


% %parse epoch vector from array
% epoch_state = state_def(:,1);
% 
% %convert state string array to numeric array
% state_def = double(state_def(:,2:7));


% epoch_cov = epoch_cov';
% 
% for b = 1:length(epoch_cov)
%         eph_cell{b,1} = epoch_cov(b);
%         eph_cell{b,2} = state_def(b,:);
%         eph_cell{b,3} = cov_def(b,res_cov;
% end





% %convert cell strings to covariance string array
% for i = cov_start:int:cov_end
%     
%     epoch_cov((i - cov_start)/int + gap) = string(defeph(i));
%     %cov_def(i - (cov_start - 1) - (i - cov_start)/int : i - (cov_start - 1) - (i - cov_start)/int + 5,:) = string(defeph(i + gap : i + gap + 5));
%     cov_def(((i - cov_start)/int)*6 + 1 : ((i - cov_start)/int)*6 + 6,:) = string(defeph(i + gap : i + gap + 5));
% 
% end
% 
% 
% epoch_cov = epoch_cov';
% 
% test_cov = cov_def(1:6);
% res_cov = zeros(6,7);
% for a = 1:length(test_cov)
%     res_cov(a,1:a+1) = split(test_cov(a))';
% end
% 
% res_cov = res_cov(:,2:7);
% 
% for i = 1:length(res_cov)-1
%     for j = 2:length(res_cov)
%         res_cov(i,j) = res_cov(j,i);
%     end
% end



%Structures and cell arrays
% eph_struct.epoch = epoch_state(1);
% eph_struct.state = state_def(1,:);
% eph_struct.cov = res_cov;
% 
% eph_cell{1,1} = epoch_state(1);
% eph_cell{1,2} = state_def(1,:);
% eph_cell{1,3} = res_cov;
% 
% eph_cell{2,1} = epoch_state(2);
% eph_cell{2,2} = state_def(2,:);
% eph_cell{2,3} = res_cov;