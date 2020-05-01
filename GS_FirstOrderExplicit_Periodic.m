function uNew = ForwardEuler(uDiffusion,uOld,str)
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
   dt=str.dt;
   init=str.init;
%Load init for solver
   uOld=init.u;
   vOld=init.v;
for it=2:length(tspan)
    %Solve change due to laplacian (unscaled by diffusion or h)
    uDiffusion=solveLaplacian(uOld,str);
    vDiffusion=solveLaplcaian(vOld,str);
    %Compute NonLinear Component
    uNew=uOld+dt*(Du*uDiffusion+  F  *(1-uOld)-uOld.*vOld.^2);
    vNew=vOld+dt*(Dv*vDiffusion-(F+k)*  vOld  +uOld.*vOld.^2);
end

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

