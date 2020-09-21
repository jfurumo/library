%ODE45 function to propagate orbit for non-dimensionalized Circular Restricted 3 Body Problem

function output = integrate_3BP_ND(t,input,mu);
%vector from m1 to 3rd body
p1=[input(1)+mu;
    input(2);
    input(3)];
%vector from m2 to 3rd body
p2=[input(1)-1+mu;
    input(2);
    input(3)];
%output vector
output(1)=input(4);
output(2)=input(5);
output(3)=input(6);
output(4)=-(1-mu)/(norm(p1)^3)*(input(1)+mu)-((mu/norm(p2)^3)*(input(1)-1+mu))+2*input(5)+input(1);
output(5)=-(1-mu)/(norm(p1)^3)*(input(2))   -((mu/norm(p2)^3)*(input(2)))     -2*input(4)+input(2);
output(6)=-(1-mu)/(norm(p1)^3)*(input(3))   -((mu/norm(p2)^3)*(input(3)));
output=output';
