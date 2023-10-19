%John Furumo
%MATLAB script template

% clear;
% clf;
% clc;
% close all;
% format shortg;
% set(0,'DefaultFigureWindowStyle','docked');

x = [1:1:4320];

GGSS_R = dR_RIC.R.data(2:4321);
GGSS_I = dR_RIC.I.data(2:4321);
GGSS_C = dR_RIC.C.data(2:4321);


FF_R = num(:,1);
FF_I = num(:,2);
FF_C = num(:,3);

figure('name','RIC Error')
%yyaxis left
p1=plot(x,GGSS_R,'bo','linewidth',2);
hold on;
p2=plot(x,FF_R,'g*');
xlabel('Epoch')
ylabel('R (m)')
%xlim([min max]);
%ylim([min max]);
%yyaxis right
legend([p1 p2],{'GGSS' 'FreeFlyer'})
%title('title')
hold off;

%subplot(m,n,position)