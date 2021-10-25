%this function converts a quaternion to an attitude matrix

% INPUTS
% 4x1 quaternion

% OUTPUTS
% 3x3 attitude matrix

function attitude_matrix = Q2A(quaternion)
q1 = quaternion(1);
q2 = quaternion(2);
q3 = quaternion(3);
q4 = quaternion(4);
A = [q1^2 - q2^2 - q3^2 + q4^2, 2*(q1*q2 + q3*q4),         2*(q1*q3 - q2*q4); 
     2*(q1*q2 - q3*q4),        -q1^2 + q2^2 - q3^2 + q4^2, 2*(q2*q3 + q1*q4);
     2*(q1*q3 + q2*q4),         2*(q2*q3 - q1*q4),        -q1^2 - q2^2 + q3^2 + q4^2];
attitude_matrix = A;
