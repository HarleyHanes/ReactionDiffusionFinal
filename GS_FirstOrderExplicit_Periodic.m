function sol = GS_FirstOrderExplicit_Periodic(str)
%GS_FirstOrderExplicit_Periodic: Explicit Solver for Gray-Scott system
%using 1st order forward difference approximation of time derivate and 1st
%order centered difference approximation of laplacian
%   Detailed explanation goes here
%Load Params
   params=str.params;
   k=params.k;
   F=params.F;
   Du=params.Du;
   Dv=params.Dv;
   h=str.h;
   dt=str.dt;
   init=str.init;
   tspan=str.tspan;
   frameSpan=str.frameSpan;
%Load init into solution
   sol.u=init.u;
   sol.v=init.v;
%Load init for solver
   uOld=init.u;
   vOld=init.v;
for it=2:length(tspan)
    %Solve change due to laplacian (unscaled by diffusion or h)
    uDeltaDif=dLaplacian_CenterDiff(uOld);
    vDeltaDif=dLaplacian_CenterDiff(vOld);
    %Compute Linear Component
    uNew=uOld+dt*(Du*uDeltaDif/h^2+F*(1-uOld)-uOld*vOld.^2);
    vNew=vOld+dt*(Dv*vDeltaDif/h^2-(F+k)*vOld+uOld*vOld.^2);
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
%Load into sol
sol.u=u;
sol.v=v;
end

%     for ix1=1:length(xspan(1,:))
%             %Determine centered difference points- Periodic Boundary
%             if ix1==1
%                 ix1P=ix1+1;
%                 ix1M=length(xspan(1,:));
%             elseif ix1==length(xspan(1,:))
%                 ix1P=1;
%                 ix1M=ix1-1;
%             else
%                 ix1P=ix1+1;
%                 ix1M=ix1-1;
%             end
%         for ix2=1:length(xspan(2,:))
%             %Determine centered difference points- Periodic Boundary
%             if ix2==1
%                 ix2P=ix2+1;
%                 ix2M=length(xspan(2,:));
%             elseif ix2==length(xspan(2,:))
%                 ix2P=1;
%                 ix2M=ix2-1;
%             else
%                 ix2P=ix2+1;
%                 ix2M=ix2-1;
%             end
%             u(ix1,ix2,it+1)=uOld(ix1,ix2)+dt*(...
%                 Du*h^2*(uOld(ix1P,ix2)+uOld(ix1,ix2P)+uOld(ix1M,ix2)+uOld(ix1,ix2M)-4*uOld(ix1,ix2))...
%                 +F*(1-uOld(ix1,ix2))...
%                 -uOld(ix1,ix2)*vOld(ix1,ix2).^2);
%             v(ix1,ix2,it+1)=vOld(ix1,ix2)+dt*(...
%                 Dv*h^2*(vOld(ix1P,ix2)+vOld(ix1,ix2P)+vOld(ix1M,ix2)+vOld(ix1,ix2M)-4*vOld(ix1,ix2))...
%                 -(F+k)*vOld(ix1,ix2)...
%                 +uOld(ix1,ix2)*vOld(ix1,ix2).^2);
%         end
%     end


    
%     u(2:end-1,:,it+1)=u(2:end-1,:,it+1)+Du*dt/h^2*(...
%         uOld(1:end-2,:)+uOld(3:end,:));
%     u(:,2:end-1,it+1)=u(:,2:end-1,it+1)+Du*dt/h^2*(...
%         uOld(:,1:end-2)+uOld(:,3:end));
%     u(1,:,it+1)=u(1,:,it+1)+Du*dt/h^2*(...
%         uOld(end,:)+uOld(2,:));
%     u(end,:,it+1)=u(end,:,it+1)+Du*dt/h^2*(...
%         uOld(end-1,:)+uOld(1,:));
%     u(:,1,it+1)=u(:,1,it+1)+Du*dt/h^2*(...
%         uOld(:,end)+uOld(:,2));
%     u(:,end,it+1)=u(:,end,it+1)+Du*dt/h^2*(...
%         uOld(:,end-1)+uOld(:,1));
%     u(:,:,it+1)=u(:,:,it+1)-4*Du*dt/h^2*uOld

    
%     
%     u(2:end-1,2:end-1,it+1)=u(2:end-1,2:end-1,it+1)+Du*dt/h^2*(...
%         uOld(1:end-2,2:end-1)+uOld(3:end,2:end-1));
%     u(2:end-1,2:end-1,it+1)=u(2:end-1,2:end-1,it+1)+Du*dt/h^2*(...
%         uOld(2:end-1,1:end-2)+uOld(2:end-1,3:end));
%     u(1,:,it+1)=u(1,:,it+1)+Du*dt/h^2*(...
%         uOld(end,:)+uOld(2,:));
%     u(end,:,it+1)=u(end,:,it+1)+Du*dt/h^2*(...
%         uOld(end-1,:)+uOld(1,:));
%     u(:,1,it+1)=u(:,1,it+1)+Du*dt/h^2*(...
%         uOld(:,end)+uOld(:,2));
%     u(:,end,it+1)=u(:,end,it+1)+Du*dt/h^2*(...
%         uOld(:,end-1)+uOld(:,1));
%     u(:,:,it+1)=u(:,:,it+1)-4*Du*dt/h^2*uOld
%     

