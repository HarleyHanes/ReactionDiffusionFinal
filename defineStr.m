function str = defineStr(str)
%defineStr: Takes a small structure str with fields ... and outputs the
%   corresponding str with all fields and values required for formation of
%   initial conditions and
fprintf('Loading %s parameter set\n',str.EquationType)
switch str.EquationType
    case 'Gray-Scott(Pearson)'
        h=1/(256+1);
        dt=1;
        params.k=.00625;
        params.F=.004;
        params.Du=2*10^(-5);
        params.Dv=10^(-5);
        solver=@(str)GS_FirstOrderExplicit_Periodic(str);
        x1min=0; x1max=1;
        x2min=0; x2max=1;
        tmin=0;  tmax=10000;
        initType='B-Core(Pearson)';
        str.movie.length=20;
        str.movie.frames=60;
end
xpsan=[x1min:h:x1max;x2min:h:x2max];
tspan=tmin:dt:tmax;
%Load into str
str.solver=solver;
str.xspan=xpsan;
str.tspan=tspan;
str.params=params;
str.initType=initType;
str.h=h;
str.dt=dt;
end

