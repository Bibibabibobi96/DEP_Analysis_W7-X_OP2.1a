font_size = 12;

FLT.r = linspace(6000, 6100, 250);
FLT.z = linspace(-0.34, 0, 851);

for i = 1:851
   FLT.part_id_B(i,:) =   clenBwd{i}.part_id;
   FLT.p_end_z_B(i,:) = clenBwd{i}.p_end(3,:);
   FLT.length_B(i,:) =   clenBwd{i}.length;
   FLT.part_id_F(i,:) =   clenFwd{i}.part_id;
   FLT.p_end_z_F(i,:) = clenFwd{i}.p_end(3,:);
   FLT.length_F(i,:) =   clenFwd{i}.length;
end

%%

figure

t = tiledlayout(4,2);

nexttile(1,[2 1]);

pcolor(FLT.r,FLT.z,FLT.p_end_z_B);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
title('Backward','FontSize',font_size+4)

nexttile(5);
plot(FLT.r,FLT.p_end_z_B(425,:))    
ylabel('Z_{end}','FontSize',font_size)

nexttile(2,[2 1]);

pcolor(FLT.r,FLT.z,FLT.p_end_z_F);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
title('Fackward','FontSize',font_size+4)

nexttile(6);
plot(FLT.r,FLT.p_end_z_F(425,:))

nexttile(7);
plot(FLT.r,FLT.length_B(425,:));hold on
ylabel('Lc','FontSize',font_size)

nexttile(8);
plot(FLT.r,FLT.length_F(425,:));hold on

%  sgtitle([''],'FontSize',font_size+6)

%%

r_flt = reshape(r_flt,50,2000);
z_flt = reshape(z_flt,50,2000);
% r_flt(r_flt > 6100 | r_flt < 6000) = NaN;
% z_flt(z_flt > 0 | z_flt < -0.34) = NaN;

figure
t = tiledlayout(3,3);

nexttile(1,[2 1]);
pcolor(FLT.r,FLT.z,FLT.length_B);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')

xlim([6000 6100])
ylim([-0.34 0])
title('Backward','FontSize',font_size+4)
ylabel('Z(m)','FontSize',font_size+4)

nexttile(2,[2 1]);
pcolor(FLT.r,FLT.z,FLT.length_F);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')

xlim([6000 6100])
ylim([-0.34 0])
title('Forward','FontSize',font_size+4)

nexttile(3,[2 1]);
pcolor(FLT.r,FLT.z,FLT.length_B - FLT.length_F);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')

xlim([6000 6100])
ylim([-0.34 0])
title('Backward - Forward','FontSize',font_size+4)
ylabel('Z(m)','FontSize',font_size+4)

nexttile(7);
plot(FLT.r,FLT.length_B(425,:));hold on
ylabel('Lc','FontSize',font_size)
xlabel('R(m)','FontSize',font_size)

nexttile(8);
plot(FLT.r,FLT.length_F(425,:));hold on
xlabel('R(m)','FontSize',font_size)

nexttile(9);
plot(FLT.r,FLT.length_B(425,:) - FLT.length_F(425,:));hold on
xlabel('R(m)','FontSize',font_size)

t.TileSpacing = 'compact';
t.Padding = 'none';

%%
% 1D Lc
font_size = 12;

FLT.r = linspace(6000, 6100, 250);

figure
t = tiledlayout(1,3);

for i = 0:2500:5000
% for i = 0:2000:4000
    load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\OP1.2 Standard (CAD) + ',num2str(i),'A on axis (CW dir.)Lc111'])
%     load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\FLT_result\connection_length\1D\OP1.2 High-Iota (CAD) - ',num2str(i),'A on axis (CW dir.)Lc111'])

    ax(1) = nexttile(1);
    % plot(FLT.r,FLT.length_B(425,:),'LineWidth',2);hold on
    semilogy(FLT.r,clenBwd{1}.length,'LineWidth',2);hold on
    ylabel('Lc (m)','FontSize',font_size+4)
    xlabel('R(m)','FontSize',font_size+4)
    title('Backward','FontSize',font_size+4)

    ax(2) = nexttile(2);
    % plot(FLT.r,FLT.length_F(425,:),'LineWidth',2);hold on
    semilogy(FLT.r,clenFwd{1}.length,'LineWidth',2);hold on
    xlabel('R(m)','FontSize',font_size+4)
    title('Forward','FontSize',font_size+4)

    ax(3) = nexttile(3);
    % plot(FLT.r,FLT.length_B(425,:) + FLT.length_F(425,:),'LineWidth',2);hold on
    semilogy(FLT.r,clenBwd{1}.length + clenFwd{1}.length,'LineWidth',2);hold on
    xlabel('R(m)','FontSize',font_size+4)
    title('Total','FontSize',font_size+4)

end 

t.TileSpacing = 'none';
t.Padding = 'none';
linkaxes(ax,'xy')
sgtitle(['connetion length'],'FontSize',font_size+10)

for i = 1:3
    ax(i);
    legend('standard + 0A','standard + 1000A','standard + 2000A',...
        'standard + 3000A','standard + 4000A','standard + 5000A',...
        'Location','southwest','fontsize',14)
%     legend('high iota - 0A','high iota - 2000A','high iota - 4000A','Location','southwest','fontsize',14)
end

%% 2D Lc & poincare with beta
clear ax
font_size = 12;
FLT.r = linspace(6000, 6100, 250);
FLT.z = linspace(-0.34, 0, 851);
r_flt = reshape(r_flt,50,2000);
z_flt = reshape(z_flt,50,2000);
r_flt(r_flt > 6.1 | r_flt < 6.0) = NaN;
r_flt(z_flt > 0 | z_flt < -0.34) = NaN;

figure
t = tiledlayout(3,3);

ax(1) = nexttile(1,[2 1]);
pcolor(FLT.r,FLT.z,clenBwd.length);hold on
% pcolor(FLT.r,FLT.z,clenBwd);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')
title('Backward','FontSize',font_size+4)
ylabel('Z(m)','FontSize',font_size+4)

ax(2) = nexttile(2,[2 1]);
pcolor(FLT.r,FLT.z,clenFwd.length);hold on
% pcolor(FLT.r,FLT.z,clenFwd);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')
set(gca,'yticklabel',[])
title('Forward','FontSize',font_size+4)

ax(3) = nexttile(3,[2 1]);
pcolor(FLT.r,FLT.z,clenBwd.length + clenFwd.length);hold on
% pcolor(FLT.r,FLT.z,clenBwd + clenFwd);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
scatter(1000*r_flt,z_flt,1,'filled','k')
set(gca,'yticklabel',[])
title('Total','FontSize',font_size+4)

ax(4) = nexttile(7);
semilogy(FLT.r,clenBwd.length(425,:),'LineWidth',2);hold on
% semilogy(FLT.r,clenBwd(425,:),'LineWidth',2);hold on
ylabel('Lc (m)','FontSize',font_size+4)
xlabel('R(mm)','FontSize',font_size+4)


ax(5) = nexttile(8);
semilogy(FLT.r,clenFwd.length(425,:),'LineWidth',2);hold on
% semilogy(FLT.r,clenFwd(425,:),'LineWidth',2);hold on
xlabel('R(mm)','FontSize',font_size+4)


ax(6) = nexttile(9);
semilogy(FLT.r,clenFwd.length(425,:) + clenBwd.length(425,:),'LineWidth',2);hold on
% semilogy(FLT.r,clenFwd(425,:) + clenBwd(425,:),'LineWidth',2);hold on
xlabel('R(mm)','FontSize',font_size+4)


t.TileSpacing = 'none';
t.Padding = 'none';


%% end part with beta
clear ax
font_size = 12;
FLT.r = linspace(6000, 6100, 250);
FLT.z = linspace(-0.34, 0, 851);

figure
t = tiledlayout(3,2);

ax(1) = nexttile;
pcolor(FLT.r,FLT.z,clenBwd.part_id);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',font_size+4);title(gca,'part id')

ax(2) = nexttile;
pcolor(FLT.r,FLT.z,clenFwd.part_id);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
title('part id')

ax(3) = nexttile;
pcolor(FLT.r,FLT.z,reshape(clenBwd.p_end(3,:,:),851,250));hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',font_size+4);title('end Z');

ax(4) = nexttile;
pcolor(FLT.r,FLT.z,reshape(clenFwd.p_end(3,:,:),851,250));hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
title('end Z')

ax(5) = nexttile;
semilogy(FLT.r,clenBwd.length(425,:),'LineWidth',2);hold on
ylabel('L_c (m)','FontSize',font_size+4)
xlabel('R(mm)','FontSize',font_size+4)

ax(6) = nexttile;
semilogy(FLT.r,clenFwd.length(425,:),'LineWidth',2);hold on
xlabel('R(mm)','FontSize',font_size+4)

t.TileSpacing = 'tight';
t.Padding = 'none';

sgtitle('3kA standard with 1% \beta','FontSize',font_size+10)
% sgtitle('standard with 1% \beta','FontSize',font_size+10)



%%

% changeIndices = find(diff(clenFwd.part_id(425,:)) ~= 0) + 1;
array = clenFwd.part_id(425,:);
index = find(~isnan(array), 1);

array = components{165,3};
array(array < 0) = NaN;
divertor.U1 = [components{165,1};components{165,2};array];

array = components{166,3};
array(array > 0) = NaN;
divertor.L2 = [components{166,1};components{166,2};array];

array = components{167,3};
array(array > 0) = NaN;
divertor.L3 = [components{167,1};components{167,2};array];

array = components{169,3};
array(array < 0) = NaN;
divertor.U5 = [components{169,1};components{169,2};array];

figure
t = tiledlayout(4,3);

nexttile(1)
array = clenBwd.part_id;
array(array > 5) = nan;
pcolor(linspace(6000, 6100, 250),linspace(-0.34, 0, 851),array);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',12+4);title(gca,'divertor id')
text(6010, -0.05, 'A','FontSize',14);
xticks([]);colorbar

nexttile(4)
array = clenFwd.part_id;
array(array > 5) = nan;
pcolor(linspace(6000, 6100, 250),linspace(-0.34, 0, 851),array);hold on
shading interp
plot([6000 6100],[-0.17 -0.17],'LineWidth',2,'color','black')
ylabel('Z(m)','FontSize',12+4);
xlabel('R(mm)','FontSize',12+4);
text(6010, -0.05, 'B','FontSize',14);

nexttile(2,[2,2]);
for i = 165:169
    scatter3(components{i,1},components{i,2},components{i,3},0.3,[.7 .7 .7]);hold on
end

% C = colorm(250);
% colormap(colorm(250));
colormap(hsv);
colorbar('Location','southoutside','AxisLocation','in')
clim([6024 6100]);
clear C
C = colormap;
C = interp1(1:size(C, 1), C, linspace(1, size(C, 1), 190));

% title('standard + 5kA (1% \beta)','FontSize',16)
% title('standard + 3kA (1% \beta)','FontSize',16)
title('standard (1% \beta)','FontSize',16)

view(-55,160)

x = reshape(clenBwd.p_end(1,425,:),1,250);
y = reshape(clenBwd.p_end(2,425,:),1,250);
z = reshape(clenBwd.p_end(3,425,:),1,250);
x(x == 0) = NaN;
y(y == 0) = NaN;
z(z == 0) = NaN;
scatter3(x,y,z,10,"green","filled")
% for i = 1:250
% scatter3(x(i),y(i),z(i),10,C(i,:),"filled");hold on
% end

x = reshape(clenFwd.p_end(1,425,:),1,250);
y = reshape(clenFwd.p_end(2,425,:),1,250);
z = reshape(clenFwd.p_end(3,425,:),1,250);
x(x == 0) = NaN;
y(y == 0) = NaN;
z(z == 0) = NaN;
scatter3(x,y,z,10,"red","filled")
% for i = 1:250
% scatter3(x(i),y(i),z(i),10,C(i,:),"filled")
% end
clear x y z
[x(1), y(1)] = pol2cart(deg2rad(200.8), 6);
[x(2), y(2)] = pol2cart(deg2rad(200.8), 6.1);

z = [-0.17,-0.17];
plot3(x,y,z,'k')

h(1) = plot(NaN,NaN,'color','red','LineStyle','-','Marker','none','LineWidth',2);
h(2) = plot(NaN,NaN,'color','green','LineStyle','-','Marker','none','LineWidth',2);
h(3) = plot(NaN,NaN,'color',[.7 .7 .7],'LineStyle','-','Marker','none','LineWidth',2);
h(4) = plot(NaN,NaN,'color','k','LineStyle','-','Marker','none','LineWidth',2);
legend_text = char({'Backward';'Forward';'divertor';'probe path'});
legend(h, legend_text,'Box','off','Location','best','color','none','Fontsize',11);
axis equal
axis off

for n = [2,3,5]
nexttile(6 + ceil(n/2));
i = 164 + n;
% if n == 1;title('Backward');end
% scatter3(components{i,1},components{i,2},components{i,3},0.3,[.7 .7 .7]);hold on
if n == 2
scatter3(divertor.L2(1,:),divertor.L2(2,:),divertor.L2(3,:),0.3,[.7 .7 .7]);hold on;
% scatter3(divertor.L2(1,:),divertor.L2(2,:),divertor.L2(3,:),0.3,'k');hold on;
%view(90,0)
TextLocation('A','Location','westoutside','Fontsize',18);
elseif n == 3
scatter3(divertor.L3(1,:),divertor.L3(2,:),divertor.L3(3,:),0.3,[.7 .7 .7]);hold on;
% scatter3(divertor.L3(1,:),divertor.L3(2,:),divertor.L3(3,:),0.3,'k');hold on;
%view(0,160)
elseif n == 5
scatter3(divertor.U5(1,:),divertor.U5(2,:),-divertor.U5(3,:),0.3,[.7 .7 .7]);hold on;
% scatter3(divertor.U5(1,:),divertor.U5(2,:),-divertor.U5(3,:),0.3,'k');hold on;
%view(-180,160)
end
x = reshape(clenBwd.p_end(1,425,index:end),1,251-index) .* (clenBwd.part_id(425,index:end) == n);
y = reshape(clenBwd.p_end(2,425,index:end),1,251-index) .* (clenBwd.part_id(425,index:end) == n);
z = reshape(clenBwd.p_end(3,425,index:end),1,251-index) .* (clenBwd.part_id(425,index:end) == n);
x(x == 0) = NaN;
y(y == 0) = NaN;
z(z == 0) = NaN;
% for i = 1:250; scatter3(x(i),y(i),z(i),10,C(i,:),"filled");end
h = scatter3(x,y,-abs(z),15,C(index-60:length(C),:),"filled");  
% h.MarkerEdgeColor = [0 1 0];
% h.LineWidth = 0.001;
% h.SizeData = 50;
title(['divertor ',num2str(n)])
axis equal
axis off
% if sum(z>0) >0
%     zlim([0 1])
% else
%     zlim([-1 0])
% end
end

for n = [1,3,5]
nexttile(9 + ceil(n/2));
i = 164 + n;
% if n == 1;title('Forward');end
% scatter3(components{i,1},components{i,2},components{i,3},0.3,[.7 .7 .7]);hold on
if n == 1
scatter3(divertor.U1(1,:),divertor.U1(2,:),-divertor.U1(3,:),0.3,[.7 .7 .7]);hold on;
%view(-15,180);
% view(172.4361,0)
TextLocation('B','Location','westoutside','Fontsize',18);
elseif n == 3
scatter3(divertor.L3(1,:),divertor.L3(2,:),divertor.L3(3,:),0.3,[.7 .7 .7]);hold on;
%view(0,160)
elseif n == 5
scatter3(divertor.U5(1,:),divertor.U5(2,:),-divertor.U5(3,:),0.3,[.7 .7 .7]);hold on;
%view(-180,160)

end
x = reshape(clenFwd.p_end(1,425,index:end),1,251-index) .* (clenFwd.part_id(425,index:end) == n);
y = reshape(clenFwd.p_end(2,425,index:end),1,251-index) .* (clenFwd.part_id(425,index:end) == n);
z = reshape(clenFwd.p_end(3,425,index:end),1,251-index) .* (clenFwd.part_id(425,index:end) == n);
% z = -abs(z);
x(x == 0) = NaN;
y(y == 0) = NaN;
z(z == 0) = NaN;
h = scatter3(x,y,-abs(z),15,C(index-60:length(C),:),"filled");
% h.MarkerEdgeColor = [1 0 0];
% h.LineWidth = 0.001;
% h.SizeData = 50;
% for i = 1:250; scatter3(x(i),y(i),z(i),10,C(i,:),"filled");end
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
% 
% nexttile(10).View = [90,0];
% nexttile(11).View = [0,160];
% nexttile(12).View = [-180,160];
% nexttile(13).View = [-15,180];
% nexttile(14).View = [0,160];
% nexttile(15).View = [-180,160];

