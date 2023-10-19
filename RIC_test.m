clear;
close all;
clc;

mu = 3.986e+05;

L7_fds = [2896.10376668;
          206.319065438;
          -6466.79391366;
          -6.2166021;
          -3.023566355;
          -2.881664767];
      
L7_moc = [3263042.53850501;
          387198.091538119;
          -6281006.74524981;
          -6010.58814839646;
          -3003.7170301892;
          -3309.18875700081]/1000;

r_diff = L7_fds(1:3) - L7_moc(1:3);
v_diff = L7_fds(4:6) - L7_moc(4:6);
      
R = L7_moc(1:3)/norm(L7_moc(1:3));      
h = cross(L7_moc(1:3),L7_moc(4:6));
C = h/norm(h);
I = cross(C,R);
DCM = [R,I,C]';

r_delt = DCM*r_diff

%plot everything
figure('name','RIC position')
orbit = plot_orbit(L7_moc,'cart',mu,[0,0,0],8000,60,'L7 moc','y');
%hold on;
plot_ECI;
[~,~] = plot_vector(L7_moc(1:3),[0,0,0],'c','-','o')
[~,~] = plot_vector(100*L7_moc(4:6),L7_moc(1:3),'c','-','o')
[~,~] = plot_vector(5000*R,L7_moc(1:3),'r','-','>')
[~,~] = plot_vector(5000*I,L7_moc(1:3),'g','-','>')
[~,~] = plot_vector(5000*C,L7_moc(1:3),'b','-','>')

[~,~] = plot_vector(L7_fds(1:3),[0,0,0],'k','-','x')
[~,~] = plot_vector(100*L7_fds(4:6),L7_fds(1:3),'k','-','x')
[~,~] = plot_vector(r_diff,L7_moc(1:3),'m','-','o')

axis equal;
xlim([-10000 10000]);
ylim([-10000 10000]);
zlim([-10000 10000]);



% figure('name','RIC velocity')
% orbit = plot_orbit(L7_moc,'cart',mu,[0,0,0],8000,60,'L7 moc','c');
% %hold on;
% plot_ECI;
% [~,~] = plot_vector(L7_moc(1:3),[0,0,0],'c','-','o')
% [~,~] = plot_vector(5000*R,L7_moc(1:3),'r','-','>')
% [~,~] = plot_vector(5000*I,L7_moc(1:3),'g','-','>')
% [~,~] = plot_vector(5000*C,L7_moc(1:3),'b','-','>')
% 
% [~,~] = plot_vector(L7_fds(1:3),[0,0,0],'k','-','x')
% [~,~] = plot_vector(r_diff,L7_moc(1:3),'m','-','o')
% 
% axis equal;
% xlim([-10000 10000]);
% ylim([-10000 10000]);
% zlim([-10000 10000]);