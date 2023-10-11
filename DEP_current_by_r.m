%%
for n = 1:plunge_n

    figure(10+n)

    t = tiledlayout(3,3);
%     [ha, pos] = tight_subplot(6,3,[.00 .02],[.05 .05],[.08 .08]);

    font_size = 12;
    
    for i = 1:3
%         ax(i) =subplot(6,3,3*i-2);
        ax(i) = nexttile(3*i-2);
%         axes(ha(3*i-2));
        
        plot(position(plunge_index(3*n-2):plunge_index(3*n-1))+5+5*i,...
                IA(i,plunge_index(3*n-2):plunge_index(3*n-1)),'b');hold on
        plot(position(plunge_index(3*n-1):plunge_index(3*n))+5+5*i,...
                IA(i,plunge_index(3*n-1):plunge_index(3*n)),'r')
        set(gca,'fontsize', font_size)
        ylabel({['channel ',num2str(i)]})
        if i < 3
            set(gca,'xticklabel',[])
        end
        if i == 1
            title('I_{A}(A)')
        end
       
        if i == 3
            legend('in','out','Location','southwest')            
            xlabel('R(mm)','FontSize',font_size+2)
        end
    end
%     linkaxes([ax],'xy')
    
    for i = 1:3
%         ax(i+6) =subplot(6,3,3*i-1);
        ax(i+3) = nexttile(3*i-1);
%         axes(ha(3*i-1))
        
        plot(position(plunge_index(3*n-2):plunge_index(3*n-1))+5+5*i,...
                IB(i,plunge_index(3*n-2):plunge_index(3*n-1)),'b');hold on
        plot(position(plunge_index(3*n-1):plunge_index(3*n))+5+5*i,...
                IB(i,plunge_index(3*n-1):plunge_index(3*n)),'r')
        
        set(gca,'fontsize', font_size,'yticklabel',[])
        if i < 3
            set(gca,'xticklabel',[])
        end
        if i == 1
            title('I_{B}(A)')
        end
        if i == 3
            legend('in','out','Location','southwest')
            xlabel('R(mm)','FontSize',font_size+2)
        end
    end
    
    for i = 1:3
%         ax(i+12) =subplot(6,3,3*i);
        ax(i+6) = nexttile(3*i);
%         axes(ha(3*i));

        yyaxis right
        plot(position(plunge_index(3*n-2):plunge_index(3*n-1))+5+5*i,...
                IB(i,plunge_index(3*n-2):plunge_index(3*n-1)) - IA(i,plunge_index(3*n-2):plunge_index(3*n-1)),'b');hold on
        plot(position(plunge_index(3*n-1):plunge_index(3*n))+5+5*i,...
                IB(i,plunge_index(3*n-1):plunge_index(3*n)) - IA(i,plunge_index(3*n-1):plunge_index(3*n)),'r','LineStyle','-')
        plot([6030 6130],[0 0],'k','LineWidth',1,'LineStyle','--')

        plot([6081 6081],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
%         plot([6065 6065],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
        set(gca,'fontsize', font_size)  
        yyaxis left
        set(gca,'yticklabel',[])
        yyaxis right
        
        if i < 3
            set(gca,'xticklabel',[])
        end
        if i == 1
            title('I_{net}(I_B-I_A)')
        end
        if i == 3
            legend('in','out','Location','southwest')
            xlabel('R(mm)','fontsize',font_size+2)
        end
%       
    end
    
    linkaxes([ax],'x')
if shot < 221206037
    xlim([min(position) 6080])
else
    xlim([min(position) 6130])
end

    linkaxes([ax(1:6)],'xy')
    linkaxes([ax(7:9)],'xy')
%     linkaxes([ha([2:3:18,1:3:18])],'y');
%     linkaxes([ha(3:3:18)],'y');
%     linkaxes([ha],'x');
% if shot < 221206037
%     xlim([min(position) 6080])
% else
%     xlim([min(position) 6130])
% end
    sgtitle([num2str(shot),',plunge ',num2str(n)],'Fontsize',font_size+6)
    t.TileSpacing = 'none';
    t.Padding = 'none';
    clear ax
    

end