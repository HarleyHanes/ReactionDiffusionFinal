function [uNew,vNew] = ForwardEuler(uOld,vOld,uDiffusion,vDiffusion,str)
%GS_FirstOrderExplicit_Periodic: Explicit Solver for Gray-Scott system
%using 1st order forward difference approximation of time derivate and 1st
%order centered difference approximation of laplacian
%   Detailed explanation goes here
%Load Params
   params=str.params;
   Du=params.Du;
   Dv=params.Dv;
   dt=str.dt;
   %Integrate system
    uNew=uOld+dt*(Du*uDiffusion+str.Ru(params,uOld,vOld));
    vNew=vOld+dt*(Dv*vDiffusion+str.Rv(params,uOld,vOld));
end
