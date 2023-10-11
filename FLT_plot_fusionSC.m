

%% poincare plot
figure
t = tiledlayout(1,2);

ha(1) = nexttile;
load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\high iota\Ip=0,Icc=0,poin_high.mat')
mask = (cLenF > 0) & (cLenB > 0);
mask2 = (cLenF < 0) & (cLenB < 0);

cmap = cool(256);
color_indices = interp1([0, 1000], [1, 256], cLenF(mask)+cLenB(mask));
colors = cmap(round(color_indices), :);

% scatter(r_flt(mask),z_flt(mask),4 ,ones(length(colors),3) - colors, 'filled');hold on
scatter(r_flt(mask),z_flt(mask),4 ,colors, 'filled');hold on
scatter(r_flt(mask2),z_flt(mask2),4,'filled','k');
plot([5.9 6.2],[-0.17 -0.17],'r',LineWidth=3)
axis equal
axis tight
box on
set(gca,'fontsize', 24)
ylabel('Z (m)')
xlabel('R (m)')
colormap(cool)

ha(2) = nexttile;
load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=0,Icc=0,poin.mat')
mask = (cLenF > 0) & (cLenB > 0);
mask2 = (cLenF < 0) & (cLenB < 0);

cmap = cool(256);
color_indices = interp1([0, 1000], [1, 256], cLenF(mask)+cLenB(mask));
colors = cmap(round(color_indices), :);

% scatter(r_flt(mask),z_flt(mask),4 ,ones(length(colors),3) - colors, 'filled');hold on
scatter(r_flt(mask),z_flt(mask),4 ,colors, 'filled');hold on
scatter(r_flt(mask2),z_flt(mask2),4,'filled','k');
plot([5.9 6.2],[-0.17 -0.17],'r',LineWidth=3)
axis equal
axis tight
box on
xlabel('R (m)')
set(gca,'fontsize',24,'yticklabel',[])
colormap(cool)

colorbar
clim([0,1000])

t.Padding = 'none';
t.TileSpacing = 'none';
linkaxes(ha,'xy')
xlim([4.75 6.22])
ylim([-1.2 1])
%% 2D connection length

% r_flt(r_flt > 6.1 | r_flt < 6.0) = NaN;
% r_flt(z_flt > 0 | z_flt < -0.34) = NaN;

font_size = 10;

figure

% [ha, pos] = tight_subplot(2,2,[.05 0],[.1 .1],[.1 .1])
% axes(ha(1));
% % plot(randn(10,ii));
%
% % set(ha(1:2),'XTickLabel','');
% set(ha([2,4]),'YTickLabel','');

t = tiledlayout(1,2);
nexttile


% pcolor(r,z,cLenBwd)
% pcolor(trace_r,trace_z,reshape(endPoints2(4,:,:),[250,850])')
pcolor(trace_r,trace_z,reshape(endPoints2(4,:,:),[length(endPoints2(1,:,1)),length(endPoints2(1,1,:))])')
shading interp
hold on
ylabel(['Ip = ',num2str(Ip),'kA, Icc = ',num2str(Icc),'kA',newline,'Z(m)'])

% scatter(trace_r,trace_z,4,'filled','k')
scatter(r_flt,z_flt,4,'filled','k')
% axis equal
xlim([6.0 6.1])
ylim([-0.34 0])
% title('Backward')
plot([6.0 6.1],[-0.17 -0.17],'k','LineWidth',1)
set(gca,'fontsize', 14);

nexttile
% pcolor(r,z,cLenFwd)
pcolor(trace_r,trace_z,reshape(endPoints1(4,:,:),[length(endPoints2(1,:,1)),length(endPoints2(1,1,:))])')
shading interp
hold on

scatter(r_flt,z_flt,4,'filled','k')
% axis equalcle

xlim([6.0 6.1])
ylim([-0.34 0])
set(gca,'yticklabel',[])
% title('Forward')


% colorbar
plot([6.0 6.1],[-0.17 -0.17],'k','LineWidth',1)
set(gca,'fontsize', 14);

t.TileSpacing = 'none';
t.Padding = 'none';

%% divertor intersection

font_size = 10;
% configuration = 'high iota';
configuration = 'standard';

% array = clenFwd.part_id(425,:);
% index = find(~isnan(array), 1);
load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\components.mat')
moduleNo1 = double(moduleNo1);
moduleNo2 = double(moduleNo2);

array = moduleNo1(:,425);
index = find(array ~=0, 1);
index = 125;

array = components{165,3};
array(array < 0) = NaN;
divertor.U1 = [components{165,1};components{165,2};array];

array = components{165,3};
array(array > 0) = NaN;
divertor.L1 = [components{165,1};components{165,2};array];

array = components{166,3};
array(array > 0) = NaN;
divertor.L2 = [components{166,1};components{166,2};array];

array = components{167,3};
array(array > 0) = NaN;
divertor.L3 = [components{167,1};components{167,2};array];

array = components{167,3};
array(array < 0) = NaN;
divertor.U3 = [components{167,1};components{167,2};array];

array = components{168,3};
array(array > 0) = NaN;
divertor.L4 = [components{168,1};components{168,2};array];

array = components{169,3};
array(array < 0) = NaN;
divertor.U5 = [components{169,1};components{169,2};array];

array = components{169,3};
array(array > 0) = NaN;
divertor.L5 = [components{169,1};components{169,2};array];

array = reshape(endPoints1(4,:,425),1,250);
indices1 = find(array - 500 < 0);
array = reshape(endPoints2(4,:,425),1,250);
indices2 = find(array - 500 < 0);

figure

t = tiledlayout(4,3);

nexttile(1)
array = moduleNo2;
array(array > 5) = nan;
array(array == 0) = nan;
pcolor(linspace(6.0, 6.1, 250),linspace(-0.34, 0, 850),array');hold on
shading interp
plot([6.000 6.100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',font_size + 4);
% set
title(gca,'divertor id','FontSize',font_size + 4)
set(gca,'FontSize',font_size + 4)
text(6.010, -0.05, 'Backward','FontSize',14);
xticks([]);colorbar

nexttile(4)
array = moduleNo1;
array(array > 5) = nan;
array(array == 0) = nan;
pcolor(linspace(6.000, 6.100, 250),linspace(-0.34, 0, 850),array');hold on
shading interp
plot([6.000 6.100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',font_size + 4);
% xlabel('R(mm)','FontSize',font_size + 4);
text(6.010, -0.05, 'Forward','FontSize',14);

nexttile(2,[2,2]);

for i = 165:169
    scatter3(components{i,1},components{i,2},components{i,3},0.3,[.7 .7 .7]);hold on
end

colormap(hsv);
colorbar('Location','southoutside','AxisLocation','in')

clear C
C = colormap;

if strcmp(configuration, 'standard')
    index_diff = index;
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), length(endPoints1(1,:,1)) - index + 1));
    divertor_list = [5,2,3;3,1,5];
    clim([6050 6100]);
elseif strcmp(configuration, 'high iota')
    index_diff = 0;
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), length(endPoints1(1,:,1))));
    divertor_list = [5,4,3;3,2,5];
    clim([6010 6100]);
end

scatter3(endPoints1(1,indices1,425),endPoints1(2,indices1,425),endPoints1(3,indices1,425),5,'green','filled')
scatter3(endPoints2(1,indices2,425),endPoints2(2,indices2,425),endPoints2(3,indices2,425),5,'red','filled')

clear x y z
[x(1), y(1)] = pol2cart(deg2rad(200.8), 6);
[x(2), y(2)] = pol2cart(deg2rad(200.8), 6.1);

z = [-0.17,-0.17];
plot3(x,y,z,'k')

view(-55,160)

h(1) = plot(NaN,NaN,'color','red','LineStyle','-','Marker','none','LineWidth',2);
h(2) = plot(NaN,NaN,'color','green','LineStyle','-','Marker','none','LineWidth',2);
h(3) = plot(NaN,NaN,'color',[.7 .7 .7],'LineStyle','-','Marker','none','LineWidth',2);
h(4) = plot(NaN,NaN,'color','k','LineStyle','-','Marker','none','LineWidth',2);
legend_text = char({'Backward';'Forward';'divertor';'probe path'});
legend(h, legend_text,'Box','off','Location','best','color','none','Fontsize',font_size + 4);
axis equal
axis off
title(['standard (1% \beta)',newline,'I_p=',num2str(Ip),'A, I_{cc}=',num2str(Icc),'A'],'FontSize',16)

% for n = [2,3,5]
for n = divertor_list(1,:)
    nexttile
    % if n == 1;title('Backward');end
    % scatter3(components{i,1},components{i,2},components{i,3},0.3,[.7 .7 .7]);hold on
    scatter3(divertor.L1(1,:),divertor.L1(2,:),divertor.L1(3,:),0.3,[.7 .7 .7]);hold on;

    % view(-180,160)

    x = endPoints2(1,index:end,425) .* (moduleNo2(index:end,425) == n)';
    y = endPoints2(2,index:end,425) .* (moduleNo2(index:end,425) == n)';
    z = endPoints2(3,index:end,425) .* (moduleNo2(index:end,425) == n)';
    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;
    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);
    h = scatter3(x,y,z,15,C(index-index_diff+1:length(C),:),"filled");
    % h.MarkerEdgeColor = [0 1 0];
    % h.LineWidth = 0.001;
    % h.SizeData = 50;
    title(['divertor ',num2str(n)],'FontSize',font_size + 2 )
    axis equal
    axis off
end


for n = divertor_list(2,:)
    nexttile
    scatter3(divertor.L1(1,:),divertor.L1(2,:),divertor.L1(3,:),0.3,[.7 .7 .7]);hold on;
    %view(-15,180);
    % view(172.4361,0)
    % TextLocation('B','Location','westoutside','Fontsize',18);

    x = endPoints1(1,index:end,425) .* (moduleNo1(index:end,425) == n)';
    y = endPoints1(2,index:end,425) .* (moduleNo1(index:end,425) == n)';
    z = endPoints1(3,index:end,425) .* (moduleNo1(index:end,425) == n)';

    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;
    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);
    h = scatter3(x,y,z,15,C(index-index_diff+1:length(C),:),"filled");

    % h.MarkerEdgeColor = [1 0 0];
    % h.LineWidth = 0.001;
    % h.SizeData = 50;

    title(['divertor ',num2str(n)],'FontSize',font_size + 2 )
    axis equal
    axis off
    % if sum(z>0) >0
    %     zlim([0 1])
    % else
    %     zlim([-1 0])
    % end
end

t.TileSpacing = 'none';
t.Padding = 'none';

%% 1D connection length

figure
C = linspecer(3);
legend_text = [];
ha = tight_subplot(1,2,[.05 .0],[.2 .2],[.1 .03]);
i = 1;
z0 = floor(length(trace_z)/2)+1-0;

% for n = [1,2,3,5]
for n = [4,2,3,5]

    moduleNo1 = double(moduleNo1);
    moduleNo2 = double(moduleNo2);

    array = moduleNo1(:,z0);
    index = find(array ~=0, 1);

    Lc1 = endPoints1(4,index:end,z0) .* (moduleNo1(index:end,z0) == n)';
    Lc2 = endPoints2(4,index:end,z0) .* (moduleNo2(index:end,z0) == n)';
    Lc1(Lc1 == 0) = NaN;
    Lc2(Lc2 == 0) = NaN;

    % subplot(1,2,1)
    axes(ha(1));    
    plot([6100 6100],[0 500],'LineWidth',1,'LineStyle','--','Color','k');hold on
    plot([6087 6087],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6075 6075],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6070 6070],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6050 6050],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    % plot(r,endPoints2(4,:,425))
    % p = semilogy(r(index:1:end),Lc2(1:1:end),'color',C(i,:));
    p = scatter(1000 * trace_r(index:5:end),Lc2(1:5:end),'MarkerFaceColor',C(i,:),'MarkerEdgeColor',C(i,:));
    if n == 4; p.Marker = "o";
%     if n == 1; p.Marker = "o";
    elseif n == 2; p.Marker = "+";
    elseif n == 3; p.Marker = "^";
    elseif n == 5; p.Marker = "square";
    end
    p.LineWidth = 5;
    s.SizeData = 100;
    hold on
    %     semilogy(r,endPoints2(4,:,425),'color',C(i,:));
    plot(1000 * trace_r,endPoints2(4,:,z0),'color',C(i,:));


    set(gca,'yscale','log')
    ylabel('Lc (m)')
    xlabel('R (mm)')
    box on

    % subplot(1,2,2)
    axes(ha(2));
    plot([6100 6100],[0 500],'LineWidth',1,'LineStyle','--','Color','k');hold on
    plot([6087 6087],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6075 6075],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6070 6070],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    plot([6050 6050],[0 500],'LineWidth',1,'LineStyle','--','Color','k')
    % plot(r,endPoints1(4,:,425))
    % semilogy(r,endPoints1(4,:,425),'color',C(i,:));
    % p = semilogy(r(index:end),Lc1,'color',C(i,:));
    p = scatter(1000 * trace_r(index:5:end),Lc1(1:5:end),'MarkerFaceColor',C(i,:),'MarkerEdgeColor',C(i,:));
    if n == 4; p.Marker = "o";
%     if n == 1; p.Marker = "o";
    elseif n == 2; p.Marker = "+";
    elseif n == 3; p.Marker = "^";
    elseif n == 5; p.Marker = "square";
    end
    p.LineWidth = 2;
    hold on
    %     semilogy(r,endPoints1(4,:,425),'color',C(i,:));
    plot(1000 * trace_r,endPoints1(4,:,z0),'color',C(i,:));
    set(gca,'yscale','log')
    set(ha(2),'YTickLabel','')
    xlabel('R (mm)')
    box on
end

I(i,1) = Ip;
I(i,2) = Icc;
i = i+1;

linkaxes(ha,'xy');

% for n = 1:i-1
% legend_text(1,i-1) =  ['I_p=',num2str(Ip),'A, I_{cc}=',num2str(Icc),'A'];
% end

i = 1;
for n = [1,2,3,5]
    legend_text{i} =  ['divertor module ',num2str(n)];
    i=i+1;
end
legend_marker{1} = 'o';
legend_marker{2} = '+';
legend_marker{3} = '^';
legend_marker{4} = 'square';

for j = 1:4
    h(j) = plot(NaN,NaN,'color',C(1,:),'LineStyle','-','Marker',legend_marker{j},'LineWidth',2);
end

% legend(h, legend_text,'Box','off','Location','best','color','none','Fontsize',11);
% xlim([6040 6120])
% ylim([3 300])
%% divertor IR
% configuration = 'high iota';
configuration = 'standard';
% load('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\FusionSC_version1.1\Ip=2000,Icc=0,trace2.mat')

colormap('jet');
% colorbar('Location','southoutside','AxisLocation','in')


clear C
C = colormap;
if strcmp(configuration, 'standard')
    index_r = find(trace_r == 6.0485);
    index_r2 = length(trace_r);
    index_z = find(trace_z == -0.169);
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), length(endPoints1(1,:,1)) - index_r + 1));
    divertor_list = [5,2,3;3,1,5];
    clim([6050 6120]);
elseif strcmp(configuration, 'high iota')
    index_r = find(trace_r == 6.015);
    index_r2 = find(trace_r == 6.08025);
    index_z = find(trace_z == -0.169);
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), index_r2 - index_r + 1));
    divertor_list = [3,4;5,3];
    clim([6010 6080]);
end

divertor_x = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\x.txt', ' ');
divertor_y = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\y.txt', ' ');
divertor_z = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\z.txt', ' ');
% AEF11 = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\AEF51.txt', ' ');
T_max = 250;
AEF11 = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s_T\datas_T\AEF11.txt', ' ');
AEF11(AEF11 < 0) = 0;
AEF11(AEF11 > T_max) = T_max;

AEF20 = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s_T\datas_T\AEF20.txt', ' ');
AEF20(AEF20 < 0) = 0;
AEF20(AEF20 > T_max) = T_max;

AEA30 = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s_T\datas_T\AEA30.txt', ' ');
AEA30(AEA30 < 0) = 0;
AEA30(AEA30 > T_max) = T_max;

AEA51 = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s_T\datas_T\AEF51.txt', ' ');
AEA51(AEA51 < 0) = 0;
AEA51(AEA51 > T_max) = T_max;

% 定义colorbar的颜色映射
cmap = jet(256); % 这里使用jet colormap，你也可以选择其他颜色映射

% 将0-2的数字映射到colorbar的位置（范围为1-256）
color_indices(:,1) = interp1([0, T_max], [1, 256], AEF11);
color_indices(:,2) = interp1([0, T_max], [1, 256], AEF20);
color_indices(:,3) = interp1([0, T_max], [1, 256], AEA30);
color_indices(:,4) = interp1([0, T_max], [1, 256], AEA51);

% 根据color_indices获取RGB颜色
colors{1} = cmap(round(color_indices(:,1)), :);
colors{2} = cmap(round(color_indices(:,2)), :);
colors{3} = cmap(round(color_indices(:,3)), :);
colors{4} = cmap(round(color_indices(:,4)), :);

if strcmp(configuration, 'high iota')
    for i = 1:4
        colors{i} = 0 .* colors{i} + 0.7;
    end
end

% 在三维空间中使用scatter3函数绘制带有颜色映射的散点图
figure



i = 0;
if strcmp(configuration, 'standard')
    divertor_T_list = [4,2,3,3,1,4];
    t = tiledlayout(2,3);
elseif strcmp(configuration, 'high iota')
    divertor_T_list = [1,1,1,1];
    t = tiledlayout(2,2);
end

for n = divertor_T_list
    i = i + 1;
    nexttile(i);
%     title(['divertor ',num2str(n)])
    scatter3(divertor_x, divertor_y, divertor_z, 3, colors{n}, 'filled');hold on

    %     colorbar; % 添加colorbar显示颜色对应的值
    axis equal
    clim([0 300])
    colormap(jet)

end

i = 0;
for n = [divertor_list(1,:),divertor_list(2,:)]
    i = i + 1;

    if i < 3
        x = endPoints2(1,index_r:index_r2,index_z) .* (moduleNo2(index_r:index_r2,index_z) == n)';
        y = endPoints2(2,index_r:index_r2,index_z) .* (moduleNo2(index_r:index_r2,index_z) == n)';
        z = endPoints2(3,index_r:index_r2,index_z) .* (moduleNo2(index_r:index_r2,index_z) == n)';
    else
        x = endPoints1(1,index_r:index_r2,index_z) .* (moduleNo1(index_r:index_r2,index_z) == n)';
        y = endPoints1(2,index_r:index_r2,index_z) .* (moduleNo1(index_r:index_r2,index_z) == n)';
        z = endPoints1(3,index_r:index_r2,index_z) .* (moduleNo1(index_r:index_r2,index_z) == n)';
    end
    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;

    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);

    ha(i) = nexttile(i);
    h = scatter3(x,y,z,50,C,'filled');

    %h.MarkerEdgeColor = [0 0 0];
    %h.LineWidth = 0.01;
    %h.SizeData = 50;

%     title(['divertor ',num2str(n)],'FontSize',15 )
    axis equal
    axis off

end
clear x y z i
t.Padding = 'none';
t.TileSpacing = 'none';

%% divertor T
x_given = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\x.txt', ' ');
y_given = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\y.txt', ' ');
z_given = dlmread('C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\20230316_049_12s\datas\z.txt', ' ');

% 给定点的三维坐标
givenPoint = [x_given, y_given, z_given];

m = 0;
nonNaNIndices = [];
clear endPoints_T nonNaNIndices
for n = [3,2,5]
    m = m + 1;
    x = endPoints2(1,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    y = endPoints2(2,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    z = endPoints2(3,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;

    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);

    %找出非NaN的元素索引
    nonNaNIndices{m} = find(~isnan(x));
    for i = 1:length(nonNaNIndices{m})
        points = [x(nonNaNIndices{m}(i)),y(nonNaNIndices{m}(i)),z(nonNaNIndices{m}(i))];

        % 计算空间距离
        distances = sqrt(sum((points - givenPoint).^2, 2));

        % 找出距离在1mm以内的点
        givenPointIndexWithin1mm = find(distances <= 0.05);
        givenPointsWithin1mm = givenPoint(givenPointIndexWithin1mm,:);

        if n == 3
            endPoints2_T.L3(i,:) = mean(AEA30(givenPointIndexWithin1mm));

        elseif n == 2
            endPoints2_T.L2(i,:) = mean(AEF20(givenPointIndexWithin1mm));
            %             endPoints_T.U1(i,:) = mean(AEF11(givenPointIndexWithin1mm));
        elseif n == 5
            endPoints2_T.U5(i,:) = mean(AEA51(givenPointIndexWithin1mm));
        end

    end
end

figure
t = tiledlayout(1,3);
ha(1) = nexttile;
d = ( trace_r(2) - trace_r(1) )*1000;
scatter(6000 + index_r*d + d * nonNaNIndices{1},endPoints2_T.L3','^');hold on
scatter(6000 + index_r*d + d * nonNaNIndices{2},endPoints2_T.L2','+');
scatter(6000 + index_r*d + d * nonNaNIndices{3},endPoints2_T.U5','square');

% m = 0;
% nonNaNIndices = [];
% clear endPoints_T nonNaNIndices
for n = [5,1,3]
    m = m + 1;
    x = endPoints1(1,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';
    y = endPoints1(2,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';
    z = endPoints1(3,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';
    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;

    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);

    %找出非NaN的元素索引
    nonNaNIndices{m} = find(~isnan(x));
    for i = 1:length(nonNaNIndices{m})
        points = [x(nonNaNIndices{m}(i)),y(nonNaNIndices{m}(i)),z(nonNaNIndices{m}(i))];

        % 计算空间距离
        distances = sqrt(sum((points - givenPoint).^2, 2));

        % 找出距离在1mm以内的点
        givenPointIndexWithin1mm = find(distances <= 0.05);
        givenPointsWithin1mm = givenPoint(givenPointIndexWithin1mm,:);

        if n == 1
            endPoints1_T.U1(i,:) = mean(AEF11(givenPointIndexWithin1mm));
        elseif n == 3
            endPoints1_T.L3(i,:) = mean(AEA30(givenPointIndexWithin1mm));
            %             endPoints_T.U1(i,:) = mean(AEF11(givenPointIndexWithin1mm));
        elseif n == 5
            endPoints1_T.U5(i,:) = mean(AEA51(givenPointIndexWithin1mm));
        end

    end
end

ha(2) = nexttile;
scatter(6000 + index_r*d + d * nonNaNIndices{4},endPoints1_T.U5','square');hold on
scatter(6000 + index_r*d + d * nonNaNIndices{5},endPoints1_T.U1','o');
scatter(6000 + index_r*d + d * nonNaNIndices{6},endPoints1_T.L3','^');
set(gca,'ytick',[])

ha(3) = nexttile;
A = [nonNaNIndices{2}';nonNaNIndices{3}'];
B = [endPoints2_T.L2;endPoints2_T.U5];
C = [nonNaNIndices{4}';nonNaNIndices{5}'];
D = [endPoints1_T.U5;endPoints1_T.U1];
E = [nonNaNIndices{1}';nonNaNIndices{2}';nonNaNIndices{3}'];
F = [endPoints2_T.L3;endPoints2_T.L2;endPoints2_T.U5];
G = [nonNaNIndices{4}';nonNaNIndices{5}';nonNaNIndices{6}'];
H = [endPoints1_T.U5;endPoints1_T.U1;endPoints1_T.L3];

[sortedA, sortedIndices] = sortrows([A, B]);
% sortedB = B(sortedIndices);
[sortedC, sortedIndices] = sortrows([C, D]);
% sortedD = D(sortedIndices);
[sortedE, sortedIndices] = sortrows([E, F]);
% sortedF = F(sortedIndices);
[sortedG, sortedIndices] = sortrows([G, H]);
% sortedH = H(sortedIndices);

commonElements = intersect(sortedA(:,1), sortedC(:,1));
commonIndicesArray1 = find(ismember(sortedA(:,1), commonElements));
commonIndicesArray2 = find(ismember(sortedC(:,1), commonElements));

scatter(6000 + index_r*d + d * sortedE(:,1), ...
    sortedG(:,2) - sortedE(:,2),'b');hold on
scatter(6000 + index_r*d + d * commonElements, ...
    sortedC(commonIndicesArray2,2) - sortedA(commonIndicesArray1,2),'r');

set(gca,'ytick',[])

linkaxes(ha,'xy')
xlim([6040 6120])
t.Padding = 'none';
t.TileSpacing = 'none';

clear d A B C D E F G H sortedA sortedB sortedC sortedD sortedE sortedF sortedG sortedH


%% transparent rectangle

% 创建一个图形窗口
% figure;

% 定义长方形的位置和大小
rectangle_position = [6022.5, -1];  % 长方形左下角的坐标 [x, y]
rectangle_size = [11.5, 2];      % 长方形的宽度和高度 [width, height]

h = rectangle('Position', [rectangle_position, rectangle_size], ...
    'Curvature', 0, ...
    'FaceColor', [0, 0, 1, 0.2], ...
    'EdgeColor', [1, 1, 1, 0.2]);


%% divertor IR 2D

font_size = 14;
% index = 125;

clear C
C = colormap('hsv');
if strcmp(configuration, 'standard')
    index_r = find(trace_r == 6.0485);
    index_z = find(trace_z == -0.169);
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), length(endPoints1(1,:,1)) - index_r + 1));
    divertor_list = [3,2,5;5,1,3];
    clim([6050 6100]);
elseif strcmp(configuration, 'high iota')
    C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), length(endPoints1(1,:,1))));
    divertor_list = [5,4,3;3,2,5];
    clim([6010 6080]);
end

% 假设你的数组名为 data，n 表示总行数
n = size(C, 1);

% 设置间隔大小
interval = 10;

for i = 1:interval:n
    % 确保当前间隔不会超过数组总行数
    interval_end = min(i + interval - 1, n);

    % 重复第一行的值
    C(i:interval_end, :) = repmat(C(i, :), interval_end - i + 1, 1);
end

[divertor_1,divertor_theta,diff_rho,diff_z] = W7X_divertorXYZto2D(divertor_x,divertor_y,divertor_z);
% divertor_length = [-diff_rho(1:149700);diff_z(149701:end)+3];
divertor_length = [divertor_1(1:149810);diff_z(149811:end)];

figure
t = tiledlayout(3,2);

% scatter(divertor_theta/pi*180,divertor_length,2,AEA30,'filled');hold on
% colormap(jet);clim([25,250])
% [length,theta,diff_rho,diff_z] = W7X_divertorXYZto2D(x,y,z);
% scatter(theta/pi*180,-diff_rho,20,'k','filled')
i = -1;
for n = divertor_list(1,:)
    i = i + 2;
    nexttile(i)

    x = endPoints2(1,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    y = endPoints2(2,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    z = endPoints2(3,index_r:end,index_z) .* (moduleNo2(index_r:end,index_z) == n)';
    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;

    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);
    [L,theta,diff_rho,diff_z] = W7X_divertorXYZto2D(x,y,z);

    if n == 3
        scatter(divertor_theta/pi*180,-divertor_length,3,AEA30,'filled');hold on
        scatter(theta/pi*180,-L,20,C,'filled')
    elseif n == 2
        scatter(divertor_theta/pi*180,-divertor_length,3,AEF20,'filled');hold on
        scatter(theta/pi*180,-diff_z,20,C,'filled')
    elseif n == 5
        scatter(divertor_theta/pi*180,-divertor_length,3,AEA51,'filled');hold on
        scatter(theta/pi*180,-L,20,C,'filled')
    end
    colormap(turbo);clim([25,250])
    %     scatter(theta/pi*180,-diff_rho,20,C(index-index_diff+1:length(C),:),'filled')

    % h.MarkerEdgeColor = [0 1 0];
    % h.LineWidth = 0.001;
    % h.SizeData = 50;
    title(['divertor ',num2str(n)],'FontSize',font_size + 2, 'Position', [5, -9.5])
    %     axis equal
    %     axis off
    set(gca,'yticklabel',[],'ytick',[])
    set(gca,'xticklabel',[])
end

i = 0;
for n = divertor_list(2,:)
    i = i + 2;
    nexttile(i)

    x = endPoints1(1,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';
    y = endPoints1(2,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';
    z = endPoints1(3,index_r:end,index_z) .* (moduleNo1(index_r:end,index_z) == n)';

    x(x == 0) = NaN;
    y(y == 0) = NaN;
    z(z == 0) = NaN;

    [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration);
    [L,theta,diff_rho,diff_z] = W7X_divertorXYZto2D(x,y,z);

    if n == 3
        scatter(divertor_theta/pi*180,-divertor_length,3,AEA30,'filled');hold on
        scatter(theta/pi*180,-L,20,C,'filled')
    elseif n == 1
        scatter(divertor_theta/pi*180,-divertor_length,3,AEF11,'filled');hold on
        scatter(theta/pi*180,-diff_z,20,C,'filled')
    elseif n == 5
        scatter(divertor_theta/pi*180,-divertor_length,3,AEA51,'filled');hold on
        scatter(theta/pi*180,-L,20,C,'filled')
    end
    colormap(turbo);clim([25,250])

    % h.MarkerEdgeColor = [1 0 0];
    % h.LineWidth = 0.001;
    % h.SizeData = 50;

    title(['divertor ',num2str(n)],'FontSize',font_size + 2 ,'Position', [5, -9.5]);
    set(gca,'yticklabel',[],'ytick',[])
    %     axis equal
    %     axis off
    % if sum(z>0) >0
    %     zlim([0 1])
    % else
    %     zlim([-1 0])
    % end
end

t.TileSpacing = 'none';
t.Padding = 'none';

%% divertor IR 2D colorbar

rgbData = flipud(C);
% 假设你的颜色数据存储在一个名为 rgbData 的 n*3 数组中
% 每一行表示一个 RGB 颜色

n = size(rgbData, 1);

% 创建表示颜色的矩阵
colorMatrix = reshape(rgbData, [n, 1, 3]);

% 创建一个用于显示颜色的图像
figure

colorImage = image(1:n, 1, colorMatrix);
% axis off; % 关闭坐标轴

% 设置图像的坐标范围
xlim([1, n]);

% 设置图像标题
title('MPM Radial position');

% 设置图像的外观
set(gca, 'XTick', []);
set(gca, 'FontSize', 12);

set(gca,'yticklabel',[],'ytick',[])
yyaxis right
% ylim([6048.5 6120])
% ylim([6010 6100])
ylim([trace_r(1)*1000 trace_r(end)*1000])

%%












