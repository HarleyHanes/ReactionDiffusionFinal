function [sol] = solve2S2DReactionDiffusion(str)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   init=str.init;
   tspan=str.tspan;
   frameSpan=str.frameSpan;
%Load init into solution
   sol.u=init.u;
   sol.v=init.v;
   iFrame=1;
%Load init for solver
   uOld=init.u;
   vOld=init.v;
for it=2:length(tspan)
    %Solve laplacian (unscaled by diffusion Coefficient)
        uDiffusion=str.LaplacianSolver(uOld,str);
        vDiffusion=str.LaplacianSolver(vOld,str);
    %Solve One timestep of ODE
        [uNew,vNew]=str.ODESolver(uOld,vOld,uDiffusion,vDiffusion,str);   
    if sum(sum(isnan(uNew)))~=0
        error('NaN in Solution')
    end
    if sum(sum(isnan(vNew)))~=0
        error('NaN in Solution')
    end
    if sum(it==frameSpan)==1
        iFrame=iFrame+1;
        sol.u(:,:,iFrame)=uNew;
        sol.v(:,:,iFrame)=vNew;
    end
    uOld=uNew;
    vOld=vNew;
end
end

