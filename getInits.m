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
end
%Load into sol
init.u=u;
init.v=v;
end

