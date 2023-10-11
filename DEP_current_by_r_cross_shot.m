nsmooth = 100;
j = plunge(n);
C = linspecer(analysis_number);
% n_channel = 5;

for i = 1:n_channel
    %         ax(i) =subplot(6,3,3*i-2);
    ax3(i) = nexttile(3*i-2);
    %         axes(ha(3*i-2));

    plot(downsample( position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i, ndowns),...
        smoothdata(downsample( IA(i,plunge_index(3*j-2):plunge_index(3*j-1)), ndowns),"gaussian",nsmooth), ...
        'color',C(n,:),'LineWidth',2);hold on
    plot(downsample( position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i, ndowns),...
        smoothdata(downsample( IA(i,plunge_index(3*j-1):plunge_index(3*j)), ndowns),"gaussian",nsmooth), ...
        'color',C(n,:),'LineWidth',2)   
    set(gca,'fontsize', font_size + 5)
    ylabel({['channel ',num2str(i)]})
    plot([6080 6080],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6070 6070],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6100 6100],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
%     if i < 6
        set(gca,'xticklabel',[])
%     end
    if i == 1
        title('I_{Backward} d(A)')
    end

%     if i == 6
%         legend('in','out','Location','southwest')
%         xlabel('R(mm)','FontSize',font_size+2)
%     end

    if sum(shot_list < 221206033) == length(shot_list)
        ylim([-0.02 0.11])
    elseif sum(shot_list < 221206050) ~= 0 
        ylim([-0.02 0.55])
    else
        ylim([-0.05 0.33])
    end
end
%     linkaxes([ax],'xy')

for i = 1:n_channel
    %         ax(i+6) =subplot(6,3,3*i-1);
    ax3(i + n_channel) = nexttile(3*i-1);
    %         axes(ha(3*i-1))

    plot(downsample( position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i, ndowns),...
        smoothdata(downsample( IB(i,plunge_index(3*j-2):plunge_index(3*j-1)), ndowns),"gaussian",nsmooth), ...
        'color',C(n,:),'LineWidth',2);hold on
    plot(downsample( position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i, ndowns),...
        smoothdata(downsample( IB(i,plunge_index(3*j-1):plunge_index(3*j)), ndowns),"gaussian",nsmooth), ...
        'color',C(n,:),'LineWidth',2)
    plot([6080 6080],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6075 6075],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6100 6100],[-0.02 0.3],'LineWidth',1,'LineStyle','--','Color','k')
    set(gca,'fontsize', font_size + 5,'yticklabel',[])
%     if i < 6
        set(gca,'xticklabel',[])
%     end
    if i == 1
        title('I_{Forward} (A)')
    end
%     if i == 6
%         legend('in','out','Location','southwest')
%         xlabel('R(mm)','FontSize',font_size+2)
%     end

    if sum(shot_list < 221206033) == length(shot_list)
        ylim([-0.02 0.11])
    elseif sum(shot_list < 221206050) ~= 0 
        ylim([-0.02 0.55])
    else
        ylim([-0.05 0.33])
    end
end

for i = 1:n_channel
    %         ax(i+12) =subplot(6,3,3*i);
    ax3(i + 2 * n_channel) = nexttile(3*i);
    %         axes(ha(3*i));

    yyaxis right
    plot(downsample( position(plunge_index(3*j-2):plunge_index(3*j-1))+5+5*i, ndowns),...
        smoothdata(downsample( IB(i,plunge_index(3*j-2):plunge_index(3*j-1)) - IA(i,plunge_index(3*j-2):plunge_index(3*j-1)), ndowns),"gaussian",nsmooth),...
        'color',C(n,:),'LineWidth',2,'LineStyle','-','Marker','none');
    hold on
    plot(downsample( position(plunge_index(3*j-1):plunge_index(3*j))+5+5*i, ndowns),...
        smoothdata(downsample( IB(i,plunge_index(3*j-1):plunge_index(3*j)) - IA(i,plunge_index(3*j-1):plunge_index(3*j)), ndowns),"gaussian",nsmooth),...
        'color',C(n,:),'LineWidth',2,'LineStyle','-','Marker','none')
    if n == 1
        plot([6030 6130],[0 0],'k','LineWidth',1,'LineStyle','--')

        plot([6081 6081],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
    end
    %         plot([6065 6065],[0.3 -0.3],'k','LineWidth',1,'LineStyle','--')
    set(gca,'fontsize', font_size + 5)
    yyaxis left
    set(gca,'yticklabel',[])
    yyaxis right

%     if i < 6
        set(gca,'xticklabel',[])
%     end
    if i == 1
        title('I_{net} = I_{Forward} - I_{Backward}')
    end
%     if i == 6
%         legend('in','out','Location','southwest')
%         xlabel('R(mm)','fontsize',font_size+2)
%     end
    %
    if sum(shot_list < 221206033) == length(shot_list)
        ylim([-0.06 0.06])
    elseif sum(shot_list < 221206050) ~= 0 
        ylim([-0.15 0.22])
    else
        ylim([-0.15 0.11])
    end
end

if n == length(shot_list)
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\HINT equilibrium with beta=1.08%Lc.mat')
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\HINT equilibrium with beta=0.11%Lc11.mat')

ax3(3 * n_channel + 1) = nexttile(3 * n_channel + 1);
if sum(shot_list > 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=1.08%.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=0.11% + 3kA.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 Standard (CAD)HINT equilibrium with beta=1.08%+5kA.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd{1}.length,'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2000,Icc=0,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenBwd(85,:),'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2500,Icc=2500,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenBwd(85,:),'LineWidth',2);hold on
end
if sum(shot_list < 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 High-Iota (CAD)HINT equilibrium with beta=1.15%.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd{1}.length,'LineWidth',2);hold on
end
if sum(shot_list > 221206036) == length(shot_list)
    legend('EJM (1% \beta)','EJM+3kA(1% \beta)','EJM+5kA(1% \beta)', ...
        'Box','off','Location','best','color','none','fontsize',10)
elseif sum(shot_list < 221206036) == length(shot_list)
    legend('FTM (1% \beta)', ...
        'Box','off','Location','best','color','none','fontsize',10)
else
legend('EJM (1% \beta)','EJM+3kA(1% \beta)','EJM+5kA(1% \beta)','FTM (1% \beta)', ...
    'Box','off','Location','best','color','none','fontsize',10)
% legend('EJM, Ip = 2kA Icc = 0kA (1% \beta)','EJM, Ip = 2.5kA Icc = 2.5kA (1% \beta)', ...
%     'Box','off','Location','best','color','none','fontsize',10)
end
xlabel('R(mm)','FontSize',font_size+4);
set(gca,'fontsize', font_size + 4)
ylabel('L_c(m)')

ax3(3 * n_channel + 2) = nexttile(3 * n_channel + 2);
if sum(shot_list > 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=1.08%.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=0.11% + 3kA.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 Standard (CAD)HINT equilibrium with beta=1.08%+5kA.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd{1}.length,'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2000,Icc=0,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenFwd(85,:),'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2500,Icc=2500,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenFwd(85,:),'LineWidth',2);hold on
end
if sum(shot_list < 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 High-Iota (CAD)HINT equilibrium with beta=1.15%.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd{1}.length,'LineWidth',2);hold on
end
set(gca,'yticklabel',[]);
set(gca,'fontsize', font_size + 4)
xlabel('R(mm)','FontSize',font_size+4)

ax3(3 * n_channel + 3) = nexttile(3 * n_channel + 3);
if sum(shot_list > 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=1.08%.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd.length(425,:) + clenBwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\2D\' ...
    'OP1.2 Standard (CAD) HINT equilibrium with beta=0.11% + 3kA.mat'])
semilogy(linspace(6000, 6100, 250),clenFwd.length(425,:) + clenBwd.length(425,:),'LineWidth',2);hold on
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 Standard (CAD)HINT equilibrium with beta=1.08%+5kA.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd{1}.length + clenFwd{1}.length,'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2000,Icc=0,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenBwd(85,:) + cLenFwd(85,:),'LineWidth',2);hold on
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2500,Icc=2500,Lc.mat')
% plot(linspace(6000, 6100, 50),cLenBwd(85,:) + cLenFwd(85,:),'LineWidth',2);hold on
end
if sum(shot_list < 221206036) > 0
load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\' ...
    'OP1.2 High-Iota (CAD)HINT equilibrium with beta=1.15%.mat'])
semilogy(linspace(6000, 6100, 250),clenBwd{1}.length + clenFwd{1}.length,'LineWidth',2);hold on
end
set(gca,'yticklabel',[]);
set(gca,'fontsize', font_size + 4);
xlabel('R(mm)','FontSize',font_size + 4)


linkaxes(ax3(3 * n_channel + 1 : 3 * n_channel + 3),'y')
end

linkaxes(ax3,'x')


if sum(shot_list < 221206033) == length(shot_list)
    xlim([min(position) 6080])
else
    xlim([min(position) 6130])
end
% sgtitle([num2str(shot),',plunge ',num2str(n)],'Fontsize',font_size+6)

% clear ax


