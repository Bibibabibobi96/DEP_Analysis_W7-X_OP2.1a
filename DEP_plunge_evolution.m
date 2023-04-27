%%
clear mesh

mesh.time_gap = 200;
mesh.r_gap = 1000;
if shot < 221206037
    mesh.max_r = 6080;
else
    mesh.max_r = 6130;
end
font_size = 12;

% tic

for i = 1:plunge_n
    %     i = 1

    mesh.min_r(i) = min(position(plunge_index(3*i-2):plunge_index(3*i)))+10;
    %     max_r = max(position(plunge_index(3*i-2):plunge_index(3*i)))+60;
    mesh.r(i,:) = linspace(mesh.min_r(i),mesh.max_r,mesh.r_gap);
    %     clear mesh_IA1 mesh_IA2 mesh_time1 mesh_time2

    [~,mesh.index1(i)] = min(abs(position(plunge_index(3*i-2):plunge_index(3*i-1)) - mesh.max_r));
    mesh.index2(i) = plunge_index(3*i-1) - plunge_index(3*i-2);
    [~,mesh.index3(i)] = min(abs(position(plunge_index(3*i-1):plunge_index(3*i)) - mesh.max_r));

    for j = 1:mesh.time_gap:mesh.index2(i) - mesh.index1(i)
        %     for j = 1:100:mesh.index1
        x = linspace(position( plunge_index(3*i-1) - j)+10 ,position( plunge_index(3*i-1) - j)+60, 11);
        for k = 1:11
            v1(k) = IA(k, plunge_index(3*i-1) - j);
            v2(k) = IB(k, plunge_index(3*i-1) - j);
        end
        mesh.IA1((j-1)/mesh.time_gap + 1,:) = interp1(x,v1,mesh.r(i,:),'cubic');
        mesh.IB1((j-1)/mesh.time_gap + 1,:) = interp1(x,v2,mesh.r(i,:),'cubic');
        mesh.time1((j-1)/mesh.time_gap + 1) = time(plunge_index(3*i-2) + mesh.index1(i) + j);
    end

    for j = 1:mesh.time_gap:mesh.index3(i)
        %     for j = 1:100:mesh.index1
        x = linspace(position( plunge_index(3*i-1) + j)+10 ,position( plunge_index(3*i-1) + j)+60, 11);
        for k = 1:11
            v1(k) = IA(k, plunge_index(3*i-1) + j);
            v2(k) = IB(k, plunge_index(3*i-1) + j);
        end
        mesh.IA2((j-1)/mesh.time_gap + 1,:) = interp1(x,v1,mesh.r(i,:),'cubic');
        mesh.IB2((j-1)/mesh.time_gap + 1,:) = interp1(x,v2,mesh.r(i,:),'cubic');
        mesh.time2((j-1)/mesh.time_gap + 1) = time(plunge_index(3*i-1) + j);
    end

    clear v1 v2 x fields

    mesh.IA{i} = [flip(mesh.IA1,1);mesh.IA2];
    mesh.IB{i} = [flip(mesh.IB1,1);mesh.IB2];
    mesh.time{i} = [flip(mesh.time1,1),mesh.time2];

    fields = {'IA1','IA2','IB1','IB2','time1','time2'};
    mesh = rmfield(mesh,fields);

end

toc

%%

figure  
t = tiledlayout(plunge_n,3);
% clear axes
% [ha, pos] = tight_subplot(plunge_n,3,[.00 .02],[.08 .15],[.1 .05]);

for i = 1:plunge_n
    
    ax(3*i-2) = nexttile(3*i-2);
%     axes(ha(3*i-2));
%     pcolor(mesh.r{i},mesh.time{i},mesh.IA{i});hold on
%     imagesc(mesh.r{i},mesh.time{i},mesh.IA{i});hold on
    imagesc(mesh.r(i,:),mesh.time{i},mesh.IA{i},'AlphaData',~isnan(mesh.IA{i}));hold on
    shading interp
    colormap('hot')
%     freezeColors;
%     colorbar
    ylabel(['plunge ',num2str(i),sprintf('\n'),'time (s)'],'fontsize',font_size+2)

    if shot < 221206050  | shot > 221206037
        caxis([0 .23])
    elseif shot > 221206036
        caxis([0 .28])
    else
        caxis([0 0.055])
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
%     axes(ha(3*i-1));
%     pcolor(mesh.r{i},mesh.time{i},mesh.IB{i});hold on
%     imagesc(mesh.r{i},mesh.time{i},mesh.IB{i});hold on
    imagesc(mesh.r(i,:),mesh.time{i},mesh.IB{i},'AlphaData',~isnan(mesh.IB{i}));hold on
    shading interp
    colormap('hot')
%     freezeColors;
%     colorbar
    if shot < 221206050  | shot > 221206037
        caxis([0 .23])
    elseif shot > 221206036
        caxis([0 .28])
    else
        caxis([0 0.055])
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
%     axes(ha(3*i));
%     pcolor(mesh.r{i},mesh.time{i},mesh.IA{i} - mesh.IB{i});hold on
%     imagesc(mesh.r{i},mesh.time{i},mesh.IA{i} - mesh.IB{i});hold on
    imagesc(mesh.r(i,:),mesh.time{i},mesh.IB{i} - mesh.IA{i},...
        'AlphaData',~isnan(mesh.IB{i} - mesh.IA{i}));hold on
    shading interp
    colormap('turbo')
%     colorbar

    if shot < 221206050  | shot > 221206037
        caxis([-0.12 0.12])
    elseif shot > 221206036
        caxis([-0.09 0.09])
    else
        caxis([0 0.055])
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


