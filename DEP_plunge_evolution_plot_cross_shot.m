
i = plunge( n );


%----------------------------------------
ax1(3*n-2) = nexttile(3*n-2);

imagesc(mesh.r(i,:),mesh.time{i}, mesh.IA{i},'AlphaData',~isnan(mesh.IA{i}));hold on
shading interp
% colormap('hot')
%     freezeColors;
%     colorbar
ylabel(['shot #',num2str(shot),newline,'plunge ',num2str(i),...
    newline,'time (s)'],'fontsize',font_size+2)

if shot < 221206033
    clim([0 0.055])
elseif shot < 221206050
    clim([0 .28])
else
    clim([0 .23])
end

if n ~= analysis_number
    set(gca,'xticklabel',[],'fontsize', font_size)
elseif n == analysis_number
    xlabel('R(mm)')
end

if n == 1
    cb = colorbar('Location','northoutside');
    cb.Title.String = "A";
    cb.Title.FontSize = font_size+4;
end
set(gca,'fontsize', font_size)

yyaxis right
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    Te(plunge_index(3*i-2):plunge_index(3*i-1)),'b','LineStyle','-')
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    ne(plunge_index(3*i-2):plunge_index(3*i-1)),'r','LineStyle','-')
legend('T_e','n_e','Location','east')
ylim([0 110])
set(gca,'yticklabel',[],'fontsize', font_size)

%----------------------------------------
ax1(3*n-1) = nexttile(3*n-1);

imagesc(mesh.r(i,:),mesh.time{i}, mesh.IB{i},'AlphaData',~isnan(mesh.IB{i}));hold on
shading interp
% colormap('hot')
%     freezeColors;
%     colorbar

if shot < 221206033
    clim([0 0.055])
elseif shot < 221206050
    clim([0 .28])
else
    clim([0 .23])
end

if n ~= analysis_number
    set(gca,'xticklabel',[],'fontsize', font_size)
elseif n == analysis_number
    xlabel('R(mm)')
end

if n == 1
    cb = colorbar('Location','northoutside');
    cb.Title.String = "B";
    cb.Title.FontSize = font_size+4;
end
set(gca,'fontsize', font_size)
set(gca,'yticklabel',[],'fontsize', font_size)

yyaxis right
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    Te(plunge_index(3*i-2):plunge_index(3*i-1)),'b','LineStyle','-')
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    ne(plunge_index(3*i-2):plunge_index(3*i-1)),'r','LineStyle','-')
legend('T_e','n_e','Location','east')
ylim([0 110])
set(gca,'yticklabel',[],'fontsize', font_size)

%----------------------------------------
ax1(3*n) = nexttile(3*n);
imagesc(mesh.r(i,:),mesh.time{i},mesh.IB{i} - mesh.IA{i},'AlphaData',~isnan(mesh.IB{i} - mesh.IA{i}));hold on
shading interp
% colormap('turbo')
%     colorbar

if shot < 221206033
    clim([-0.022 0.022])
elseif shot < 221206050
    clim([-0.12 0.12])
else
    clim([-0.12 0.12])
end

if n ~= analysis_number
    set(gca,'xticklabel',[],'fontsize', font_size)
elseif n == analysis_number
    xlabel('R(mm)')
end
if n == 1
    cb = colorbar('Location','northoutside');
    cb.Title.String = "net (B-A)";
    %         cb.Title.String = "B";
    cb.Title.FontSize = font_size+4;
end
set(gca,'yticklabel',[],'fontsize', font_size)

yyaxis right
%     set(gca,'yticklabel',[],'fontsize', font_size)
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    Te(plunge_index(3*i-2):plunge_index(3*i-1)),'b','LineStyle','-')
plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),...
    ne(plunge_index(3*i-2):plunge_index(3*i-1)),'r','LineStyle','-')
legend('T_e','n_e','Location','east')
ylim([0 110])
set(gca,'fontsize', font_size)



