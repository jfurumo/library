%John Furumo
%Attitude Control test script

%reset workspace
clear;
%clf;
clc;
close all;
format shortg;
set(0,'DefaultFigureWindowStyle','docked');

%% Euler angles
%INPUTS
phi = 45; %deg
theta = 45; %deg
psi = 45; %deg

Phi = [theta;
       psi;
       phi];
   
%first Euler angle rotation matrix
R1 = [1,0,0;
      0,cosd(Phi(1)),sind(Phi(1));
      0,-sind(Phi(1)),cosd(Phi(1))];

%second Euler angle rotation matrix
R2 = [cosd(Phi(2)),0,-sind(Phi(2));
      0,1,0;
      sind(Phi(2)),0,cosd(Phi(2))];
    
%third Euler angle rotation matrix
R3 = [cosd(Phi(3)),sind(Phi(3)),0;
     -sind(Phi(3)),cosd(Phi(3)),0;
      0,0,1];
    
%complete Euler angle rotation sequence
R312 = R2*R1*R3
R123 = R3*R2*R1

R = R123;

%quaternion
q4 = (1/2)*(1+R(1,1)+R(2,2)+R(3,3))^(1/2);
q1 = (1/(4*q4))*(R(2,3)-R(3,2));
q2 = (1/(4*q4))*(R(3,1)-R(1,3));
q3 = (1/(4*q4))*(R(1,2)-R(2,1));

Q = [q1;q2;q3;q4]

quaternion = A2Q(R312)

A = Q2A(Q)

syms theta1 theta2 theta3

syms w1 w2 w3
% 
% R = [1,sin(theta3),0;
%      0,cos(theta1)*cos(theta3),sin(theta1);
%      0,-sin(theta1)*cos(theta3),cos(theta1)]

R = [0,w3,-w2,w1;
     -w3,0,w1,w2;
     w2,-w1,0,w3;
     -w1,-w2,-w3,0]

R'
det_R = det(R)

adjoint(R)

adjoint(R)/det(R)

inv(R)

%% Plot data
figure('name','ACS test figure 1')
plot3(0,0,0,'ko','markersize',10,'linewidth',3)
hold on;
%inertial frame O
plot_inertial_frame([0,0,0])
r_b_a = [1,-1,2];
%inertial frame a
plot_frame(r_b_a);
[~,R_b_a] = plot_vector_3D(r_b_a,[0,0,0],'c','-','^')
%body frame b
plot_frame(r_b_a);
%DCM
r_DCM = [-3,-2,1];
plot_frame(r_DCM);
DCM = eye(3,3);
plot_DCM(r_DCM,R312);
plot_DCM(r_DCM,R123)

lim = 4;
xlim([-lim lim]);
ylim([-lim lim]);
zlim([-lim lim]);

%% slant range calcs

R_km  = 6378;
h_km = 500;
ep = 5; %deg

alpha = asind(R_km*sind(90+ep)/(R_km+h_km))
theta = 180 - 90 - alpha - ep

d_km = sqrt(R_km^2 + (R_km + h_km)^2 - 2*R_km*(R_km + h_km)*cosd(theta))

d_km = (R_km  + h_km)*sind(theta)/sind(90+ep)

d_km = sqrt((R_km^2)*sind(ep)^2 + 2*R_km*h_km + h_km^2) - R_km*sind(ep)

% yyaxis left
% p1=plot(x,y,'bo','linewidth',2);
% hold on;
% p2=plot(x,y,'g*');
% xlabel('x label')
% ylabel('y label')
% xlim([min max]);
% ylim([min max]);
% yyaxis right
% legend([p1 p2],{'p1 title' 'p2 title'})
% title('title')
% hold off;
% 
% subplot(m,n,position)
% 
% %ODE45
% tspan=[t_start:t_step:t_end]; %TU
% tolerance=1e-013;
% options = odeset('RelTol',tolerance,'AbsTol',tolerance);
% [t,rv]=ode45(@integrate_3BP_ND,tspan,state0,options,mu_accept);
