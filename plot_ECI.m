%this function plots ECI frame

function plot_ECI()
r_earth=6378; %km
%I
I_hat=[1;0;0];
I=linspace(0,r_earth,10);
for i=1:length(I)
I_vec(i,:)=I(i)*I_hat;
end
plot3(r_earth*I_hat,0,0);
plot3(I_vec(:,1),I_vec(:,2),I_vec(:,3),'r-','linewidth',2);
%J
J_hat=[0;1;0];
J=linspace(0,r_earth,10);
for i=1:length(J)
J_vec(i,:)=J(i)*J_hat;
end
plot3(r_earth*J_hat,0,0);
plot3(J_vec(:,1),J_vec(:,2),J_vec(:,3),'g-','linewidth',2);
%K
K_hat=[0;0;1];
K=linspace(0,r_earth,10);
for i=1:length(K)
K_vec(i,:)=K(i)*K_hat;
end
plot3(r_earth*K_hat,0,0);
plot3(K_vec(:,1),K_vec(:,2),K_vec(:,3),'b-','linewidth',2);
axis equal;
xlim([-25000 25000]);
ylim([-25000 25000]);
zlim([-25000 25000]);