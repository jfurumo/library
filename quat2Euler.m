% this function convert quaternion to Euler angles

function Euler = quat2Euler(quaternion)

q = quaternion;

theta = asind(2*(q(2)*q(4) - q(1)*q(3)));

phi = atan2d(2*(q(2)*q(3) + q(1)*q(4)),(1 - 2*(q(1)^2 + q(2)^2)));

psi = atan2d(2*(q(1)*q(2) + q(3)*q(4)),(1 - 2*(q(2)^2 + q(3)^2)));

Euler = [phi,theta,psi];

end