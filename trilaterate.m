%this function performs trilateration to determine the position of a spacecraft
%given 3 ranges to 3 known ground stations

%Inputs
%range - vector of three ranges
%site1 - position vector of first reference site
%site2 - position vector of second reference site
%site3 - position vector of third reference site
%initial_guess - initial guess for location vector

function location = trilaterate(range,site1,site2,site3,initial_guess)
%ranges from observer to reference points
p_obs_1=range(1); %km
p_obs_2=range(2); %km
p_obs_3=range(3); %km
%reference point locations in cartesian space
%point 1
x1=site1(1); %km
y1=site1(2); %km
z1=site1(3); %km
%point 2
x2=site2(1); %km
y2=site2(2); %km
z2=site2(3); %km
%point 3
x3=site3(1); %km
y3=site3(2); %km
z3=site3(3); %km
%initial guess
x=initial_guess(1);
y=initial_guess(2);
z=initial_guess(3);
X=[x;y;z];
%predicted ranges to reference points
p_pred_1=sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2);
p_pred_2=sqrt((x-x2)^2+(y-y2)^2+(z-z2)^2);
p_pred_3=sqrt((x-x3)^2+(y-y3)^2+(z-z3)^2);
%residual
epsilon_1=-(p_obs_1-p_pred_1);
epsilon_2=-(p_obs_2-p_pred_2);
epsilon_3=-(p_obs_3-p_pred_3);
E=[epsilon_1;epsilon_2;epsilon_3];
%residual tolerance
tol=1e-006;
%Newton-Raphson iteration
while (norm(E)>tol)
%Jacobian matrix
A=[(X(1)-x1)/p_pred_1,(X(2)-y1)/p_pred_1,(X(3)-z1)/p_pred_1 ;
   (X(1)-x2)/p_pred_2,(X(2)-y2)/p_pred_2,(X(3)-z2)/p_pred_2 ;
   (X(1)-x3)/p_pred_3,(X(2)-y3)/p_pred_3,(X(3)-z3)/p_pred_3];
X=X+A^-1*E;
p_pred_1=sqrt((X(1)-x1)^2+(X(2)-y1)^2+(X(3)-z1)^2);
p_pred_2=sqrt((X(1)-x2)^2+(X(2)-y2)^2+(X(3)-z2)^2);
p_pred_3=sqrt((X(1)-x3)^2+(X(2)-y3)^2+(X(3)-z3)^2);
epsilon_1=p_obs_1-p_pred_1;
epsilon_2=p_obs_2-p_pred_2;
epsilon_3=p_obs_3-p_pred_3;
E=[epsilon_1;epsilon_2;epsilon_3];
end
location=X;