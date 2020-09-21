%this function propagates HCW equations from one waypoint to the next

function r1 = HCW_propagator_2D(r0,n,t)
%initial state vector
%r0=r0;
%state transition matrix
Phi=[4-3*cos(n*t),     0, (1/n)*sin(n*t),     (2/n)*(1-cos(n*t));
     6*(sin(n*t)-n*t), 1, (-2/n)*(1-cos(n*t)),(1/n)*(4*sin(n*t)-3*n*t);
     3*n*sin(n*t),     0,  cos(n*t),           2*sin(n*t);
    -6*n*(1-cos(n*t)), 0, -2*sin(n*t),         4*cos(n*t)-3];
%final state vector
r1=Phi*r0;