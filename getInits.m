function init = getInits(str)
%getInits defines the lattice and initial conditions from str definition
%       for input into numerical solver
fprintf('Loading %s initial conditions\n',str.initType)
%% Load str fields
    xspan=str.xspan;
%% Set Intial Conditions
lattice=NaN([length(xspan(1,:)) length(xspan(2,:))]);
switch str.initType
    case 'Normalized Random'
    %Randomize
        u(:,:,1)=rand(size(lattice));
        v(:,:,1)=rand(size(lattice));
    %Normalize-set mean=1
        u(:,:,1)=u(:,:,1)/mean(mean(u(:,:,1)));
        v(:,:,1)=v(:,:,1)/mean(mean(v(:,:,1)));
    case 'B-Core(Pearson)'
        %Set all U
        u(:,:,1)=ones(size(lattice));
        v(:,:,1)=zeros(size(lattice));
        %Define inner 10% 
        boundaryStep=round(length(xspan)*.45);
        innerArea=boundaryStep:1:length(xspan)-boundaryStep;
        %Reset inner squares of u and v
        u(innerArea,innerArea,1)=1/2;
        v(innerArea,innerArea,1)=1/4;
        %Add random perturbation
        u(innerArea,innerArea,1)=u(innerArea,innerArea,1)+.01*(rand([length(innerArea),length(innerArea),1])-.5);
        v(innerArea,innerArea,1)=v(innerArea,innerArea,1)+.01*(rand([length(innerArea),length(innerArea),1])-.5);     
    case 'V-Bar (Wallisch)'
        u(:,:,1)=zeros(size(lattice));
        v(:,:,1)=zeros(size(lattice));
        u(:,1:4,1)=ones(size(u(:,1:4,1)))-.01*rand(size(u(:,1:4,1)));
    case 'V-core (Center)'
        %Set all U
        u(:,:,1)=zeros(size(lattice));
        v(:,:,1)=zeros(size(lattice));
        %Define inner 10% 
        boundaryStep=round(length(xspan)*.45);
        innerArea=boundaryStep:1:length(xspan)-boundaryStep;
        %Reset inner squares of u and v
        u(innerArea,innerArea,1)=1;
        v(innerArea,innerArea,1)=0;
        %Add random perturbation
        u(innerArea,innerArea,1)=u(innerArea,innerArea,1)+.01*(rand([length(innerArea),length(innerArea),1])-.5);
        v(innerArea,innerArea,1)=v(innerArea,innerArea,1)+.01*(rand([length(innerArea),length(innerArea),1])-.5);     
    case 'V-core (Off-Center)'
        %Set all U
        u(:,:,1)=zeros(size(lattice));
        v(:,:,1)=zeros(size(lattice));
        %Define inner 10% 
        boundaryStep=round(length(xspan)*.45);
        innerAreax=boundaryStep-30:1:length(xspan)-boundaryStep-30;
        innerAreay=boundaryStep-15:1:length(xspan)-boundaryStep-15;
        %Reset inner squares of u and v
        u(innerAreax,innerAreay,1)=1;
        v(innerAreax,innerAreay,1)=0;
        %Add random perturbation
        u(innerAreax,innerAreay,1)=u(innerAreax,innerAreay,1)+.01*(rand([length(innerAreax),length(innerAreay),1])-.5);
        v(innerAreax,innerAreay,1)=v(innerAreax,innerAreay,1)+.01*(rand([length(innerAreax),length(innerAreay),1])-.5);     
    case 'Scatter'
        uPoint=ones(4);
        %Set all U
        u(:,:,1)=zeros(size(lattice));
        v(:,:,1)=zeros(size(lattice));
        %Scatter 4 uPoints
        u(4:7,15:18,1)=uPoint;
        u(1:4,50:53,1)=uPoint;
        u(48:51,30:33,1)=uPoint;
        u(80:83,80:83,1)=uPoint;
end
%Load into sol
init.u=u;
init.v=v;
end

