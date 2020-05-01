function PlotSolution(str)
%PlotSolution Summary of this function goes here
%   Detailed explanation goes here
fprintf('Plotting Solution\n')
sol=str.sol;
tspan=str.tspan;
xspan=str.xspan;
movieLength=str.movie.length;
movieFrames=str.movie.frames;
tFrame=movieLength/movieFrames;
%Make Colormaps
colormap gray;
%Plot init
subplot(1,2,1)
%heatmap(xspan(1,:),xspan(2,:),frames.u(:,:,1))
imagesc(sol.u(:,:,1))
xlabel('x_1')
ylabel('x_2')
title(sprintf('U(x,t), t=%i',tspan(1)))
subplot(1,2,2)
%heatmap(xspan(1,:),xspan(2,:),frames.v(:,:,1))
imagesc(sol.v(:,:,1))
xlabel('x_1')
ylabel('x_2')
title(sprintf('V(x,t), t=%i',tspan(1)))
pause(1)
for iframe=1:movieFrames
    tic
    subplot(1,2,1,'replace')
    %Plot U
    %heatmap(xspan(1,:),xspan(2,:),frames.u(:,:,iframe))
    imagesc(frames.u(:,:,iframe))
    xlabel('x_1')
    ylabel('x_2')
    title(sprintf('U(x,t), t=%i',tspanFrame(iframe)))
    subplot(1,2,2,'replace')
    %Plot v
    %heatmap(xspan(1,:),xspan(2,:),frames.v(:,:,iframe))
    imagesc(frames.v(:,:,iframe))
    xlabel('x_1')
    ylabel('x_2')
    title(sprintf('V(x,t), t=%i',tspanFrame(iframe)))
    tCalc=toc;
    %Pause to keep steady frame rate
    if tCalc<tFrame
        pause(tFrame-tCalc)
    end
end
end

