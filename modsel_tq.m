function Z = modsel_tq(y, x)
% Model selection for (lib)SVM by searching for the best param on a 2D grid

fold = 1;
C =[1:1:3];
epsilon = [1:1:3] / sqrt(length(y));
noise = std(y);
i = 1; j = 1;
for C=1:0.25:4
    for epsilon=1:0.25:3
        cmd = ['-s 3 -q -t 0 -h 0 -c ',num2str(C*noise),' -p ',num2str(epsilon*noise/sqrt(length(y)))];
        m = svmtrain(y,x,cmd);
        disp([num2str(C),' ',num2str(epsilon)] )
        Z(i,j) = m.totalSV/size(x,2);
        j = j+1;
    end
    j = 1;
    i = i+1;
end

xlin = linspace(1,3,size(Z,2));
ylin = linspace(1,4,size(Z,1));
[X,Y] = meshgrid(xlin,ylin); 
mesh(X,Y, Z);
xlabel('epsilon'); ylabel('C');
figure(gcf);

end

 

% %bullseye plot
% hold on;
% plot(log2(bestc),log2(bestg),'o','Color',[0 0.5 0],'LineWidth',2,'MarkerSize',15); 
% axs = get(gca);
% plot([axs.XLim(1) axs.XLim(2)],[log2(bestg) log2(bestg)],'Color',[0 0.5 0],'LineStyle',':')
% plot([log2(bestc) log2(bestc)],[axs.YLim(1) axs.YLim(2)],'Color',[0 0.5 0],'LineStyle',':')
% hold off;
% title({['Best log2(C) = ',num2str(log2(bestc)),',  log2(gamma) = ',num2str(log2(bestg)),',  Accuracy = ',num2str(bestcv),'%'];...
%     ['(C = ',num2str(bestc),',  gamma = ',num2str(bestg),')']})
% xlabel('log2(C)')
% ylabel('log2(gamma)')

