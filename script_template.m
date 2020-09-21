%John Furumo
%MATLAB script template

clear;
clf;
clc;
close all;
format shortg;
set(0,'DefaultFigureWindowStyle','docked');

figure('name','insert name here')
yyaxis left
p1=plot(x,y,'bo','linewidth',2);
hold on;
p2=plot(x,y,'g*');
xlabel('x label')
ylabel('y label')
xlim([min max]);
ylim([min max]);
yyaxis right
legend([p1 p2],{'p1 title' 'p2 title'})
title('title')
hold off;

subplot(m,n,position)