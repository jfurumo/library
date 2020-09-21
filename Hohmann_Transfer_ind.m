%this function computes the delta-v (km/s) required for a Hohmann Transfer from one
%circular orbit to another circular orbit

%Inputs
%initial orbit radius, r1 (km)
%final orbit radius r2 (km)

function [dv1,dv2,ToF] = Hohmann_Transfer_ind(r1,r2,mu)
%tangential velocity of initial orbit
v_c1=sqrt(mu/r1); %km/s
%trangential velocity of transfer ellipse at initial apse
a=(r1+r2)/2; %km
v_t1=sqrt(2*mu/r1-mu/a); %km/s
%first burn delta-v
dv1=abs(v_t1-v_c1); %km/s
%tangential velocity of final orbit
v_c2=sqrt(mu/r2); %km/s
%tangential velocity of transfer ellipse at final apse
v_t2=sqrt(2*mu/r2-mu/a); %km/s
%final burn delta-v
dv2=abs(v_t2-v_c2); %km/s
%total delta-v
dv_Hohmann=dv1+dv2; %km/s
%time of flight
ToF=(2*pi*sqrt(a^3/mu))/2; %s