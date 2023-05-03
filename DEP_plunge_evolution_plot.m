%%

figure  
t = tiledlayout(plunge_n,3);
% clear axes
% [ha, pos] = tight_subplot(plunge_n,3,[.00 .02],[.08 .15],[.1 .05]);

for i = 1:plunge_n
    
    ax(3*i-2) = nexttile(3*i-2);

    imagesc(mesh.r(i,:),mesh.time{i},mesh.IA{i},'AlphaData',~isnan(mesh.IA{i}));hold on
    shading interp
    colormap('hot')
%     freezeColors;
%     colorbar
    ylabel(['plunge ',num2str(i),newline,'time (s)'],'fontsize',font_size+2)

    if shot < 221206050  || shot > 221206037
        clim([0 .23])
    elseif shot > 221206036
        clim([0 .28])
    else
        clim([0 0.055])
    end

    if i ~= plunge_n
        set(gca,'xticklabel',[],'fontsize', font_size)
    elseif i == plunge_n
        xlabel('R(mm)')
    end

    if i == 1
        cb = colorbar('Location','northoutside');
        cb.Title.String = "A";
        cb.Title.FontSize = font_size+4; 
    end
    set(gca,'fontsize', font_size)
    
    yyaxis right
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),Te(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'b','LineStyle','-')
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),ne(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'r','LineStyle','-')
    legend('T_e','n_e','Location','east')
    ylim([0 110])
    set(gca,'yticklabel',[],'fontsize', font_size)
    
    
    ax(3*i-1) = nexttile(3*i-1);

    imagesc(mesh.r(i,:),mesh.time{i},mesh.IB{i},'AlphaData',~isnan(mesh.IB{i}));hold on
    shading interp
    colormap('hot')
%     freezeColors;
%     colorbar
    if shot < 221206050  || shot > 221206037
        clim([0 .23])
    elseif shot > 221206036
        clim([0 .28])
    else
        clim([0 0.055])
    end

    if i ~= plunge_n
        set(gca,'xticklabel',[],'fontsize', font_size)
    elseif i == plunge_n
        xlabel('R(mm)')
    end
    if i == 1
        cb = colorbar('Location','northoutside');
        cb.Title.String = "B";
        cb.Title.FontSize = font_size+4; 
    end
    set(gca,'yticklabel',[],'fontsize', font_size)
    
%     cb = colorbar;
%     cb.Layout.Tile = 'east';
    
    yyaxis right
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),Te(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'b','LineStyle','-')
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),ne(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'r','LineStyle','-')
    legend('T_e','n_e','Location','east')
    ylim([0 110])
    set(gca,'yticklabel',[],'fontsize', font_size)
    
    
    
    ax(3*i) = nexttile(3*i);

    imagesc(mesh.r(i,:),mesh.time{i},mesh.IB{i} - mesh.IA{i},...
        'AlphaData',~isnan(mesh.IB{i} - mesh.IA{i}));hold on
    shading interp
    colormap('turbo')
%     colorbar

    if shot < 221206050  || shot > 221206037
        clim([-0.12 0.12])
    elseif shot > 221206036
        clim([-0.09 0.09])
    else
        clim([0 0.055])
    end
    if i ~= plunge_n
        set(gca,'xticklabel',[],'fontsize', font_size)
    elseif i == plunge_n
        xlabel('R(mm)')
    end
    if i == 1
        cb = colorbar('Location','northoutside');
        cb.Title.String = "net (B-A)";
%         cb.Title.String = "B";
        cb.Title.FontSize = font_size+4; 
    end
    set(gca,'yticklabel',[],'fontsize', font_size)
    
    yyaxis right
%     set(gca,'yticklabel',[],'fontsize', font_size)
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),Te(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'b','LineStyle','-')
    plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),ne(plunge_index(3*i-2):plunge_index(3*i-1)),...
        'r','LineStyle','-')
    legend('T_e','n_e','Location','east')
    ylim([0 110])
    set(gca,'fontsize', font_size)
    
    
end
%%
% c1=colorbar([ax(1) ax(2)]);
% cb = colorbar('Location','northoutside');
% cb.Layout.Tile='east';
% linkaxes([ha],'x')
linkaxes(ax,'x')
% for i = 1:plunge_n
%     ax(3*i-2);yyaxis left
%     ax(3*i-1);yyaxis left
%     ax(3*i);yyaxis left
%     linkaxes([ax(3*i-2),ax(3*i-1),ax(3*i)],'y')
% end

t.TileSpacing = 'none';
t.Padding = 'none';

if exist('ratio')
    sgtitle(['#',num2str(shot), ', current (A), T_e (eV) & n_e (10^{19}m^{-3}), calibratied  by '...
        ,num2str(cali_shot)],'FontSize',font_size+6)

else
    sgtitle(['#',num2str(shot), ', current (A), T_e (eV) & n_e (10^{19}m^{-3}), calibratied  by '...
        ,num2str(0)],'FontSize',font_size+6)
end

toc