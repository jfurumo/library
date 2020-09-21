%this function plots Earth as a spherical distribution of points in 3D space

%INPUTS
%radius of sphere (km)
%resolution of sphere - number of points per arc
%name (string) - name of body (sphere)

function sphere_surface = plot_sphere(center,radius,resolution,name,color);
sphere_center=plot3(center(1),center(2),center(3),strcat(color,'o'));
axis equal
hold on
%azimuth
alpha=linspace(0,2*pi,resolution);
%elevation
delta=linspace(0,2*pi,resolution);
for a=1:resolution
    for d=1:resolution
        sphere_surface=plot3(radius*cos(alpha(a))*cos(delta(d))+center(1),radius*sin(alpha(a))*cos(delta(d))+center(2),radius*sin(delta(d))+center(3),strcat(color,'.'),'linewidth',2,'markersize',10,'DisplayName',name);
    end
end