function PlotSolution(str)
%PlotSolution Summary of this function goes here
%   Detailed explanation goes here
sol=str.sol;
tspan=str.tspan;
xspan=str.xspan;
movieLength=str.movie.length;
movieFrames=str.movie.frames;
tFrame=movieLength/movieFrames;
%Make Colormaps
colormap parula;
if strcmpi(str.movie.makeMovie,'yes')
    fprintf('Making movie\n')
    %Setup base Frame
    if strcmpi(str.EquationType,'Gray-Scott(Pearson)')
        imagesc(xspan(1,:),xspan(2,:),sol.v(:,:,1))
        caxis([0 .4]);
        title(sprintf('V(x,t), t=%i',tspan(1)))
    elseif strcmpi(str.EquationType,'FitzHugh-Nagumo (Murray)')
        imagesc(xspan(1,:),xspan(2,:),sol.u(:,:,1))
    end
    xlabel('x_1')
    ylabel('x_2')
    colorbar
        title(sprintf('V(x,t), t=%i',tspan(1)))
    %Update automatically update next plot
    set(gca,'nextplot','replacechildren')
    v=VideoWriter(str.movie.file);
    open(v);
    for iframe=1:movieFrames
        %Plot U
        if strcmpi(str.EquationType,'Gray-Scott(Pearson)')
            imagesc(xspan(1,:),xspan(2,:),sol.v(:,:,iframe))
            caxis([0 .4]);
        elseif strcmpi(str.EquationType,'FitzHugh-Nagumo (Murray)')
            imagesc(xspan(1,:),xspan(2,:),sol.u(:,:,iframe))
            caxis([0 1])
        end
        xlabel('x_1')
        ylabel('x_2')
        title(sprintf('V(x,t), t=%i',str.tspan(str.frameSpan(iframe))))
        frame=getframe(gcf);
        writeVideo(v,frame);
        %Pause to keep steady frame rate
    end
else
%     fprintf('Plotting Solution\n')
%     %Plot init
%     subplot(1,2,1)
%     %heatmap(xspan(1,:),xspan(2,:),frames.u(:,:,1))
%     imagesc(sol.u(:,:,1))
%     xlabel('x_1')
%     ylabel('x_2')
%     title(sprintf('U(x,t), t=%i',tspan(1)))
%     subplot(1,2,2)
%     %heatmap(xspan(1,:),xspan(2,:),frames.v(:,:,1))
%     imagesc(sol.v(:,:,1))
%     xlabel('x_1')
%     ylabel('x_2')
%     title(sprintf('V(x,t), t=%i',tspan(1)))
%     pause(1)
%     for iframe=1:movieFrames
%         tic
%         subplot(1,2,1,'replace')
%         %Plot U
%         %heatmap(xspan(1,:),xspan(2,:),frames.u(:,:,iframe))
%         imagesc(sol.u(:,:,iframe))
%         xlabel('x_1')
%         ylabel('x_2')
%         title(sprintf('U(x,t), t=%i',str.tspan(iframe)))
%         subplot(1,2,2,'replace')
%         %Plot v
%         %heatmap(xspan(1,:),xspan(2,:),frames.v(:,:,iframe))
%         imagesc(sol.v(:,:,iframe))
%         xlabel('x_1')
%         ylabel('x_2')
%         title(sprintf('V(x,t), t=%i',str.tspan(iframe)))
%         tCalc=toc;
%         %Pause to keep steady frame rate
%         if tCalc<tFrame
%             pause(tFrame-tCalc)
%         end
%     end
end
end

