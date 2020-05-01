function sol = GS_FirstOrderExplicit_Periodic(str)
%GS_FirstOrderExplicit_Periodic: Explicit Solver for Gray-Scott system
%using 1st order forward difference approximation of time derivate and 1st
%order centered difference approximation of laplacian
%   Detailed explanation goes here
%Set up lattice
xspan=str.xspan;
tspan=str.tspan;
u=NaN(length(xspan(1,:)),length(xspan(2,:)),length(tspan));
v=NaN(length(xspan(1,:)),length(xspan(2,:)),length(tspan));
u(:,:,1)=str.init.u;
v(:,:,1)=str.init.v;
%Load Params
   params=str.params;
   k=params.k;
   F=params.F;
   Du=params.Du;
   Dv=params.Dv;
   h=str.h;
   dt=str.dt;
for it=1:length(tspan)-1
    %Define current timestep as uOld
    uOld=u(:,:,it);
    vOld=v(:,:,it);
    for ix1=1:length(xspan(1,:))
            %Determine centered difference points- Periodic Boundary
            if ix1==1
                ix1P=ix1+1;
                ix1M=length(xspan(1,:));
            elseif ix1==length(xspan(1,:))
                ix1P=1;
                ix1M=ix1-1;
            else
                ix1P=ix1+1;
                ix1M=ix1-1;
            end
        for ix2=1:length(xspan(2,:))
            %Determine centered difference points- Periodic Boundary
            if ix2==1
                ix2P=ix2+1;
                ix2M=length(xspan(2,:));
            elseif ix2==length(xspan(2,:))
                ix2P=1;
                ix2M=ix2-1;
            else
                ix2P=ix2+1;
                ix2M=ix2-1;
            end
            u(ix1,ix2,it+1)=uOld(ix1,ix2)+dt*(...
                Du*h^2*(uOld(ix1P,ix2)+uOld(ix1,ix2P)+uOld(ix1M,ix2)+uOld(ix1,ix2M)-4*uOld(ix1,ix2))...
                +F*(1-uOld(ix1,ix2))...
                -uOld(ix1,ix2)*vOld(ix1,ix2).^2);
            v(ix1,ix2,it+1)=vOld(ix1,ix2)+dt*(...
                Dv*h^2*(vOld(ix1P,ix2)+vOld(ix1,ix2P)+vOld(ix1M,ix2)+vOld(ix1,ix2M)-4*vOld(ix1,ix2))...
                -(F+k)*vOld(ix1,ix2)...
                +uOld(ix1,ix2)*vOld(ix1,ix2).^2);
        end
    end
    if sum(sum(isnan(u(:,:,it))))~=0
        error('NaN in Solution')
    end
    if sum(sum(isnan(v(:,:,it))))~=0
        error('NaN in Solution')
    end
end
%Load into sol
sol.u=u;
sol.v=v;
sol.t=tspan;
end

