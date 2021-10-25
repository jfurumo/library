%this function converts an attitude matrix to a quaternion

% INPUTS
% 3x3 attitude matrix

% OUTPUTS
% 4x1 quaternion

function quaternion = A2Q(attitude_matrix)
R = attitude_matrix;
q4 = (1/2)*(1+R(1,1)+R(2,2)+R(3,3))^(1/2);
q1 = (1/(4*q4))*(R(2,3)-R(3,2));
q2 = (1/(4*q4))*(R(3,1)-R(1,3));
q3 = (1/(4*q4))*(R(1,2)-R(2,1));
quaternion = [q1;q2;q3;q4];