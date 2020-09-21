%this function makes a 3D plot of the NAVSTAR GPS constellation

function p = GPS_plot()
%given inputs
mu_earth=3.986e+005; %km^3/s^2
a=26610; %km
%Numerical integration of 2BP
tspan=[0:600:43200]; %s
tolerance=1e-013;
options = odeset('RelTol',tolerance,'AbsTol',tolerance);
%plane 1
plane1=[a;0;55;0;0;0];
plane1_0 = oe2cart(plane1);
[t1,rv1]=ode45(@integrate_2BP,tspan,plane1_0,options,mu_earth);
%plane 2
plane2=[a;0;55;60;0;0];
plane2_0 = oe2cart(plane2);
[t2,rv2]=ode45(@integrate_2BP,tspan,plane2_0,options,mu_earth);
%plane 3
plane3=[a;0;55;120;0;0];
plane3_0 = oe2cart(plane3);
[t3,rv3]=ode45(@integrate_2BP,tspan,plane3_0,options,mu_earth);
%plane 4
plane4=[a;0;55;180;0;0];
plane4_0 = oe2cart(plane4);
[t4,rv4]=ode45(@integrate_2BP,tspan,plane4_0,options,mu_earth);
%plane 5
plane5=[a;0;55;240;0;0];
plane5_0 = oe2cart(plane5);
[t5,rv5]=ode45(@integrate_2BP,tspan,plane5_0,options,mu_earth);
%plane 6
plane6=[a;0;55;300;0;0];
plane6_0 = oe2cart(plane6);
[t6,rv6]=ode45(@integrate_2BP,tspan,plane6_0,options,mu_earth);
%plot GPS
figure('name','NAVSTAR Fleet')
hold on
plot_ECI();
p(1)=plot3(rv1(:,1),rv1(:,2),rv1(:,3),'linewidth',2);
p(2)=plot3(rv2(:,1),rv2(:,2),rv2(:,3),'linewidth',2);
p(3)=plot3(rv3(:,1),rv3(:,2),rv3(:,3),'linewidth',2);
p(4)=plot3(rv4(:,1),rv4(:,2),rv4(:,3),'linewidth',2);
p(5)=plot3(rv5(:,1),rv5(:,2),rv5(:,3),'linewidth',2);
p(6)=plot3(rv6(:,1),rv6(:,2),rv6(:,3),'linewidth',2);
%equatorial plane
xy=100000;
p(7)=patch(xy*[1 -1 -1 1],xy*[1 1 -1 -1],xy*[0 0 0 0],xy*[1 1 -1 -1]);
p(8)=plot3(0,0,0,'y*','markersize',10); %origin, center of Earth