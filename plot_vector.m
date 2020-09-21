%this function plots a vector in 3D space

%inputs
%input is the vector to be plotted, with 3 components (coordinates) given

function [pt_plot,vec_plot] = plot_vector(input,origin,color,line,point)
%p=str2num(p);
vec=linspace(0,norm(input),10);
input_hat=input./norm(input);
for i=1:length(vec)
vector(i,:)=vec(i)*input_hat;
end
pt_plot=plot3(input(1)+origin(1),input(2)+origin(2),input(3)+origin(3),strcat(color,point),'linewidth',2);
vec_plot=plot3(vector(:,1)+origin(1),vector(:,2)+origin(2),vector(:,3)+origin(3),strcat(color,line),'linewidth',2);