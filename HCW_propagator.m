%this function propagates HCW equations from one waypoint to the next

function r1 = HCW_propagator(r0,n,t)
%initial state vector
r0=r0;
%state transition matrix
Phi=[4-3*cos(n*t),0,0,(1/n)*sin(n*t),(2/n)*(1-cos(n*t)),0;
     6*(sin(n*t)-n*t),1,0,(-2/n)*(1-cos(n*t)),(1/n)*(4*sin(n*t)-3*n*t),0;
     0,0,cos(n*t),0,0,(1/n)*sin(n*t);
     3*n*sin(n*t),0,0,cos(n*t),2*sin(n*t),0;
    -6*n*(1-cos(n*t)),0,0,-2*sin(n*t),4*cos(n*t)-3,0;
     0,0,-n*sin(n*t),0,0,cos(n*t)];
%final state vector
r1=Phi*r0;