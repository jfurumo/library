%this function rotates a vector in 3D space a given angle about a specified
%vector

%INPUTS
%input - vector to be rotated (column vector)
%angle - angle of rotation (rad)
%axis - axis of rotation (column vector)

function output = rotate_vector(input,angle,axis)
kx=axis(1)/norm(axis);
ky=axis(2)/norm(axis);
kz=axis(3)/norm(axis);
v=(1-cos(angle));
c=cos(angle);
s=sin(angle);
R=[kx*kx*v+c,kx*ky*v-kz*s,kx*kz*v+ky*s;
   kx*ky*v+kz*s,ky*ky*v+c,ky*kz*v-kx*s;
   kx*kz*v-ky*s,ky*kz*v+kx*s,kz*kz*v+c];
output=R*input;
