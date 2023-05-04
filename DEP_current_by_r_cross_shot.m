
j = plunge(n);
C = linspecer(analysis_number);

for i = 1:6
    %         ax(i) =subplot(6,3,3*i-2);
    ax3(i) = nexttile(3*i-2);
    %         axes(ha(3*i-2));

    plot(position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i,...
        IA(i,plunge_index(3*j-2):plunge_index(3*j-1)),'color',C(n,:));hold on
    plot(position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i,...
        IA(i,plunge_index(3*j-1):plunge_index(3*j)),'color',C(n,:))   
    set(gca,'fontsize', font_size)
    ylabel({['channel ',num2str(i)]})
    if i < 6
        set(gca,'xticklabel',[])
    end
    if i == 1
        title('I_{A}(A)')
    end

    if i == 6
%         legend('in','out','Location','southwest')
        xlabel('R(mm)','FontSize',font_size+2)
    end

    if shot < 221206033
        ylim([-0.02 0.11])
    elseif shot < 221206050
        ylim([-0.02 0.55])
    else
        ylim([-0.05 0.33])
    end
end
%     linkaxes([ax],'xy')

for i = 1:6
    %         ax(i+6) =subplot(6,3,3*i-1);
    ax3(i+6) = nexttile(3*i-1);
    %         axes(ha(3*i-1))

    plot(position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i,...
        IB(i,plunge_index(3*j-2):plunge_index(3*j-1)),'color',C(n,:));hold on
    plot(position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i,...
        IB(i,plunge_index(3*j-1):plunge_index(3*j)),'color',C(n,:))

    set(gca,'fontsize', font_size,'yticklabel',[])
    if i < 6
        set(gca,'xticklabel',[])
    end
    if i == 1
        title('I_{B}(A)')
    end
    if i == 6
%         legend('in','out','Location','southwest')
        xlabel('R(mm)','FontSize',font_size+2)
    end

    if shot < 221206033
        ylim([-0.02 0.11])
    elseif shot < 221206050
        ylim([-0.02 0.55])
    else
        ylim([-0.05 0.33])
    end
end

for i = 1:6
    %         ax(i+12) =subplot(6,3,3*i);
    ax3(i+12) = nexttile(3*i);
    %         axes(ha(3*i));

    yyaxis right
    plot(position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i,...
        IB(i,plunge_index(3*j-2):plunge_index(3*j-1)) - IA(i,plunge_index(3*j-2):plunge_index(3*j-1)),...
        'color',C(n,:),'LineWidth',0.5,'LineStyle','-','Marker','none');
    hold on
    plot(position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i,...
        IB(i,plunge_index(3*j-1):plunge_index(3*j)) - IA(i,plunge_index(3*j-1):plunge_index(3*j)),...
        'color',C(n,:),'LineWidth',0.5,'LineStyle','-','Marker','none')
    if n == 1
        plot([6030 6130],[0 0],'k','LineWidth',1,'LineStyle','--')

        plot([6081 6081],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
    end
    %         plot([6065 6065],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
    set(gca,'fontsize', font_size)
    yyaxis left
    set(gca,'yticklabel',[])
    yyaxis right

    if i < 6
        set(gca,'xticklabel',[])
    end
    if i == 1
        title('I_{net}(I_B-I_A)')
    end
    if i == 6
%         legend('in','out','Location','southwest')
        xlabel('R(mm)','fontsize',font_size+2)
    end
    %
    if shot < 221206033
        ylim([-0.06 0.06])
    elseif shot < 221206050
        ylim([-0.15 0.22])
    else
        ylim([-0.15 0.11])
    end
end

linkaxes(ax3,'x')


if shot < 221206037
    xlim([min(position) 6080])
else
    xlim([min(position) 6130])
end
% sgtitle([num2str(shot),',plunge ',num2str(n)],'Fontsize',font_size+6)

% clear ax


