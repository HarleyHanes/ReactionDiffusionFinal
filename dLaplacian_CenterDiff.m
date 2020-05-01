function UdeltaDif = dLaplacian_CenterDiff(uOld,str)
%Calculates the change due to diffusion with 1st Order centered Difference
%   Approximation
 UdeltaDif=NaN(size(uOld));
 h=str.h;
%Set Interior
    inspan(1,:)=2:size(uOld,1)-1;
    inspan(2,:)=2:size(uOld,2)-1;
%Positive Terms
    %Computer interior Non-linear component
    UdeltaDif(inspan(1,:),inspan(2,:))=(uOld(inspan(1,:)-1,inspan(2,:))+uOld(inspan(1,:)+1,inspan(2,:))...
        +uOld(inspan(1,:),inspan(2,:)-1)+uOld(inspan(1,:),inspan(2,:)+1));
    %COmpute Edges
        %Compute Top Edge
        UdeltaDif(1,inspan(2,:))=(uOld(end,inspan(2,:))+uOld(1+1,inspan(2,:))...
            +uOld(1,inspan(2,:)-1)+uOld(1,inspan(2,:)+1));
        %Compute Bottom Edge
        UdeltaDif(end,inspan(2,:))=(uOld(end-1,inspan(2,:))+uOld(1,inspan(2,:))...
            +uOld(end,inspan(2,:)-1)+uOld(end,inspan(2,:)+1));
        %Compute Left Edge
        UdeltaDif(inspan(1,:),1)=(uOld(inspan(1,:)-1,1)+uOld(inspan(1,:)+1,1)...
            +uOld(inspan(1,:),end)+uOld(inspan(1,:),1+1));
        %Compute Right Edge
        UdeltaDif(inspan(1,:),end)=(uOld(inspan(1,:)-1,end)+uOld(inspan(1,:)+1,end)...
            +uOld(inspan(1,:),end-1)+uOld(inspan(1,:),1));
    %Compute Corners
        %TopLeft
        UdeltaDif(1,1)=(uOld(1,end)+uOld(end,1)+uOld(2,1)+uOld(1,2));
        %TopRight
        UdeltaDif(1,end)=(uOld(2,end)+uOld(1,1)+uOld(end,end)+uOld(1,end-1));
        %BottomLEft
        UdeltaDif(end,1)=(uOld(1,1)+uOld(end-1,1)+uOld(end,2)+uOld(end,end));
        %BottomRight
        UdeltaDif(end,end)=(uOld(1,end)+uOld(end-1,end)+uOld(end,1)+uOld(end,end-1));
%Negative Terms
    UdeltaDif(:,:)=(UdeltaDif(:,:)-4*uOld)/h^2;
end

% for ix=1:size(uOld,1)
%             if ix==1
%                 ixP=ix+1;
%                 ixM=size(uOld,1);
%             elseif ix==size(uOld,1)
%                 ixP=1;
%                 ixM=ix-1;
%             else
%                 ixP=ix+1;
%                 ixM=ix-1;
%             end
%     for iy=1:size(uOld,2)
%             if iy==1
%                 iyP=iy+1;
%                 iyM=size(uOld,2);
%             elseif iy==size(uOld,2)
%                 iyP=1;
%                 iyM=iy-1;
%             else
%                 iyP=iy+1;
%                 iyM=iy-1;
%             end
%         UdeltaDif(ix,iy)=uOld(ixP,iy)+uOld(ixM,iy)+uOld(ix,iyP)+uOld(ix,iyM)-4*uOld(ix,iy);
%     end
% end


