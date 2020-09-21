%this function solves Lambert's Problem
%inputs
%r1 = spacecraft position at t1
%r2 = spacecraft position at t2
%ToF = time of flight (t2-t1)
%way = short (nu < 180 deg) or long (nu > 180 deg)
%mu = gravitational parameter of central body (2BP)

function [v1,v2] = Lambert_solver(r1,r2,ToF,way,mu)

if strcmpi(way,'short')
t_m=1; %(short way)
elseif strcmpi(way,'long')
t_m=-1; %(long way)
end

delta_nu=acos(dot(r1,r2)/(norm(r1)*norm(r2)));
A=t_m*sqrt(norm(r1)*norm(r2)*(1+cos(delta_nu)));

%initial guesses
psi_n=0;
c2=1/2;
c3=1/6;
psi_low=-4*pi;
psi_up=4*pi^2;
y_n=norm(r1)+norm(r2)+(A*(psi_n*c3-1))/sqrt(c2);
x_n=sqrt(y_n/c2);
t_n=(x_n^3*c3+A*sqrt(y_n))/sqrt(mu);

while(abs(t_n-ToF)>1e-003)
    y_n=norm(r1)+norm(r2)+(A*(psi_n*c3-1))/sqrt(c2);
    x_n=sqrt(y_n/c2);
    t_n=(x_n^3*c3+A*sqrt(y_n))/sqrt(mu);
    if (t_n<ToF)
        psi_low=psi_n;
    else 
        psi_up=psi_n;
    end
    psi_n=(psi_up+psi_low)/2;
    if (psi_n > 1e-006)
        c2=(1-cos(sqrt(psi_n)))/psi_n;
        c3=(sqrt(psi_n)-sin(sqrt(psi_n)))/sqrt(psi_n^3);
    else if (psi_n < 1e-006)
        c2=(1-cosh(sqrt(-psi_n)))/psi_n;
        c3=(sinh(sqrt(-psi_n))-sqrt(-psi_n))/sqrt((-psi_n)^3);
    else
        c2=1/2;
        c3=1/6;
        end 
    end
end

f2=1-(y_n/norm(r1));
%change sign of g2 to change sign of v1, v2 outputs
g2=A*sqrt(y_n/mu);
g2_dot=1-(y_n/norm(r2));
%initial velocity (km/s)
v1=(r2-f2*r1)/g2;
%final velocity (km/s)
v2=(g2_dot*r2-r1)/g2;
