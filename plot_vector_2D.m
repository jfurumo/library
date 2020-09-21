%this function plots a vector in 2D space

%inputs
%input - the vector to be plotted, with 2 components (coordinates) given
%origin - coordinates of vector origin (2 components)
%color - color of plot (string)
%line - line style (string)
%point - vector tip style (string)

function [pt_plot,vec_plot] = plot_vector_2D(input,origin,color,line,point)
%p=str2num(p);
vec=linspace(0,norm(input),10);
input_hat=input./norm(input);
for i=1:length(vec)
vector(i,:)=vec(i)*input_hat;
end
pt_plot=plot(input(1)+origin(1),input(2)+origin(2),strcat(color,point),'linewidth',2);
vec_plot=plot(vector(:,1)+origin(1),vector(:,2)+origin(2),strcat(color,line),'linewidth',2);