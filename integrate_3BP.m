%ODE45 function to propagate orbit for Circular Restricted 3 Body Problem

function output = integrate_3BP(t,input,m1,m2,r1,r2);
G=6.67430e-20; %km^3/kg*s^2
r12=r1+r2; %km
w=sqrt(G*(m1+m2)/norm(r12)^3); %rad/s
%vector from m1 to 3rd body
% p1=[input(1)+mu;
%     input(2);
%     input(3)];
% %vector from m2 to 3rd body
% p2=[input(1)-1+mu;
%     input(2);
%     input(3)];
%output vector
output(1)=input(4);
output(2)=input(5);
output(3)=input(6);
r=norm(input(1:3));
output(4)=-((G*m1)/(norm(r-r1))*(input(1)+(m2/(m1+m2))*r12)-((G*m2)/(norm(r-r2)))*(input(1)-(m1/(m1+m2))*r12)+2*w*input(5)+(w^2)*input(1);
output(5)=-((G*m1)/(norm(r-r1))*(input(2))-((G*m2)/(norm(r-r2)))*(input(2))+2*w*-input(4)+(w^2)*input(2);
output(6)=-((G*m1)/(norm(r-r1))*(input(3))-((G*m2)/(norm(r-r2)))*(input(3));
output=output';
