%this function solves the Tsiolkovsky Rocket Equation

%INPUTS - vector 'input' with subset of following variables known:
%[Isp; - specific impulse of rocket engine (s)
% dv; - delta-v needed (km/s)
% m_0; - initial mass of spacecraft, e.g. wet mass (kg)
% m_f; - final mass of spacecraft, e.g. dry mass (kg) 
% m_prop]; - %propellant mass required for maneuver (kg)

%unknown variables will have 'NaN' entered in their place
%Isp must be known
%2 basic input cases:
%case 1 - delta-v unknown, some or all masses known -> solve for delta-v
%case 2 - delta-v known, some masses known -> solve for remaining masses

%OUTPUTS - vector 'output' with all following variables known:
%[Isp; - specific impulse of rocket engine (s)
% dv; - delta-v needed (km/s)
% m_0; - initial mass of spacecraft, e.g. wet mass (kg)
% m_f; - final mass of spacecraft, e.g. dry mass (kg) 
% m_prop]; - %propellant mass required for maneuver (kg)

function output = rocket_equation(input)

    g0=9.81e-03; %km/s^2
    Isp=input(1);
    dv=input(2);
    m_0=input(3);
    m_f=input(4);
    m_prop=input(5);

if input(1)<0....
  |input(2)<0....
  |input(3)<0....
  |input(4)<0....
  |input(5)<0....
    output=NaN(5,1);
    disp('ERROR - inputs cannot be less than zero')
    return
     
elseif isnan(input(1))
    output=NaN(5,1);
    disp('ERROR - Isp must be known')
    return
    
elseif isnan(input(2))
    
    if isnan(input(3)) & isnan(input(4))....
     | isnan(input(3)) & isnan(input(5))....
     | isnan(input(4)) & isnan(input(5))....
     | isnan(input(3)) & isnan(input(4)) & isnan(input(5))
        output=NaN(5,1);
        disp('ERROR - more information needed')
        return
    elseif isnan(input(3))
        m_0=input(4)+input(5);
    elseif isnan(input(4))
        m_f=input(3)-input(5);
    elseif isnan(input(5))
        m_prop=m_0-m_f;
    end
    dv=Isp*g0*log(m_0/m_f); %delta-v provided by given propellant mass (km/s)
    input(2)=dv;
    input(3)=m_0;
    input(4)=m_f;
    input(5)=m_prop;
    output=input;
    
elseif ~isnan(input(2)) & input(2)>=0    
    
    if isnan(input(3)) & isnan(input(4))....
     | isnan(input(3)) & isnan(input(4)) & isnan(input(5))
        output=NaN(5,1);
        disp('ERROR - more information needed')
        return
    elseif isnan(input(3)) & isnan(input(5))
        m_0=m_f*exp(dv/(Isp*g0));
        m_prop=m_0-m_f;
    elseif isnan(input(4)) & isnan(input(5))
        m_f=m_0/exp(dv/(Isp*g0));   
        m_prop=m_0-m_f;
    end    
        input(3)=m_0;
        input(4)=m_f;
        input(5)=m_prop;
        output=input;
       
end