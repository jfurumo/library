clear all
clc
close all
format shortg

%% EPHEMERIS DATA FILES

%folder pathway
folder = ('C:\Users\john.furumo\Documents\repos\restore-gncgs-ggss\data\resources\GGSS\2019\134\ext\');
%ephemeris file names
def_file = ('RSV_20190514_000000_DEFEPHEM_MJ2K_02_NOMINAL.oem');
pred_file = ('L7_2019134_123753_PREDEPHEM_MJ2K_NOMINAL.txt');
STK_file = ('L7_20191341200PREDEPH6X6.e');
%full pathways
def_path = strcat(folder,def_file);
pred_path = strcat(folder,pred_file);
STK_path = strcat(folder,STK_file);

%read def ephem data
def_eph = read_def_ephem(def_path);
for i = 1:length(def_eph)
    state_def(i,:) = def_eph{i,2};
end

%read pred ephem data
pred_eph = read_pred_ephem(pred_path);
for i = 1:length(pred_eph)
    state_pred(i,:) = pred_eph{i,2};
end

%read STK ephem data
STK_eph = read_STK_ephem(STK_path);
for i = 1:length(STK_eph)
    state_STK(i,:) = STK_eph{i,2};
end

%plot data
figure('name','L7 MOC Definitive Ephemeris')
plot3(0,0,0,'bo')
hold on;
plot3(state_def(:,1),state_def(:,2),state_def(:,3),'r')
plot3(state_pred(:,1),state_pred(:,2),state_pred(:,3),'g')
plot3(state_STK(:,1),state_STK(:,2),state_STK(:,3),'c')
sphere_surface = plot_sphere([0 0 0],6378,48,'earth','b')
axis equal

%TDRS ephemeris
folder = ('C:\Users\john.furumo\Documents\repos\library\');
%ephemeris file names
TDRS_file = ('TDRS_long.txt');
%full pathways
TDRS_path = strcat(folder,TDRS_file);

%read TDRS ephem data
TDRS_eph = read_TDRS_ephem(TDRS_path);
for i = 1:length(TDRS_eph)
    state_TDRS(i,:) = TDRS_eph{i,2};
end

plot3(state_TDRS(:,1),state_TDRS(:,2),state_TDRS(:,3),'m')

