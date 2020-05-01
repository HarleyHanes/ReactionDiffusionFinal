function str = defineStr(str)
%defineStr: Takes a small structure str with fields ... and outputs the
%   corresponding str with all fields and values required for formation of
%   initial conditions and
fprintf('Loading %s parameter set\n',str.EquationType)
switch str.EquationType
    case 'Gray-Scott(Pearson)'
        %Set k and F terms
        if strcmpi(str.paramSet,'Squiggles')
            params.k=.0625;
            params.F=.04;
            str.movie.file='..\\Figures\\Squiggles.avi';
        elseif strcmpi(str.paramSet,'Maze')
            params.k=.055;
            params.F=.025;
            str.movie.file='..\\Figures\\Maze.avi';
        elseif strcmpi(str.paramSet,'Culture-Squiggles')
            params.k=.0625;
            params.F=.035;
            str.movie.file='..\\Figures\\Culture-Squiggles.avi';
        elseif strcmpi(str.paramSet,'Culture')
            params.k=.0575;
            params.F=.018;
            str.movie.file='..\\Figures\\Culture.avi';
        end
        %Define Difussion Terms
        params.Du=2*10^(-5);
        params.Dv=10^(-5);
        %Set up ODE functions
        str.Ru=@(params,u,v)(params.F*(1-u)-u.*v.^2);
        str.Rv=@(params,u,v)(-(params.F+params.k)*v+u.*v.^2);
        %Inits
        x1min=0; x1max=2.5;
        x2min=0; x2max=2.5;
        tmin=0;  tmax=30000;
        initType='B-Core(Pearson)';
        %Movie Settings
        str.movie.length=20;
        str.movie.frames=240;
        %Set h and dt
        h=x1max/(255);
        dt=1;
end
xpsan=[x1min:h:x1max;x2min:h:x2max];
tspan=tmin:dt:tmax;
%Load into str

str.frameSpan=floor(linspace(1,length(tspan),str.movie.frames));
str.xspan=xpsan;
str.tspan=tspan;
str.params=params;
str.initType=initType;
str.h=h;
str.dt=dt;
end

