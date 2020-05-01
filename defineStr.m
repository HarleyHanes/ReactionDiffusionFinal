function str = defineStr(str)
%defineStr: Takes a small structure str with fields ... and outputs the
%   corresponding str with all fields and values required for formation of
%   initial conditions and
fprintf('Loading %s parameter set\n',str.EquationType)
switch str.EquationType
    case 'Gray-Scott(Pearson)'
        dt=1;
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
        params.Du=2*10^(-5);
        params.Dv=10^(-5);
        solver=@(str)GS_FirstOrderExplicit_Periodic(str);
        x1min=0; x1max=2.5;
        x2min=0; x2max=2.5;
        h=x1max/(255);
        tmin=0;  tmax=30000;
        initType='B-Core(Pearson)';
        str.movie.length=20;
        str.movie.frames=240;
end
xpsan=[x1min:h:x1max;x2min:h:x2max];
tspan=tmin:dt:tmax;
%Load into str

str.frameSpan=floor(linspace(1,length(tspan),str.movie.frames));
str.solver=solver;
str.xspan=xpsan;
str.tspan=tspan;
str.params=params;
str.initType=initType;
str.h=h;
str.dt=dt;
end

