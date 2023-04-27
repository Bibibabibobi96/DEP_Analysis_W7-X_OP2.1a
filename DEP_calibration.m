
clear cali

% cali.min_r_A = 6060;
% cali.max_r_A = 6090;
% cali.min_r_B = 6060;
% cali.max_r_B = 6100;

if shot < 221206037
    cali.min_r_A = 6000;
    cali.max_r_A = 6080;
    cali.min_r_B = 6000;
    cali.max_r_B = 6050;
else
    cali.min_r_A = 6050;
    cali.max_r_A = 6120;
    cali.min_r_B = 6050;
    cali.max_r_B = 6110;
end
font_size = 12;

n = 4;

for i = 1:22 * plunge_n
    i = double(i);
    if mod(i,22) == 0
        ii = 11;
    elseif mod(i,2) ~= 1
        ii = ceil(mod(i,22)/2);
    end
    
    if mod(i,2) == 1
        [~,cali.index_A(1,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ceil(mod(i,22)/2) - cali.max_r_A));
        [~,cali.index_A(2,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ceil(mod(i,22)/2) - cali.min_r_A));
%         cali.index_A(3,i) = plunge_index(3*ceil(i/22)-2) + cali.index_A(1,i);
        [~,cali.index_A(3,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ceil(mod(i,22)/2) - cali.min_r_A));
%         cali.index_A(4,i) = plunge_index(3*ceil(i/22)-2) + cali.index_A(2,i);
        [~,cali.index_A(4,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ceil(mod(i,22)/2) - cali.max_r_A));
        
        [~,cali.index_B(1,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ceil(mod(i,22)/2) - cali.max_r_B));
        [~,cali.index_B(2,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ceil(mod(i,22)/2) - cali.min_r_B));
%         cali.index_B(3,i) = plunge_index(3*ceil(i/22)-2) + cali.index_B(1,i);
%         cali.index_B(4,i) = plunge_index(3*ceil(i/22)-2) + cali.index_B(2,i);
        [~,cali.index_B(3,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ceil(mod(i,22)/2) - cali.min_r_B));
        [~,cali.index_B(4,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ceil(mod(i,22)/2) - cali.max_r_B));

    else
        [~,cali.index_A(1,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ii - cali.max_r_A));
        [~,cali.index_A(2,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ii - cali.min_r_A));
%         cali.index_A(3,i) = plunge_index(3*ceil(i/22)-1) + cali.index_A(1,i);
%         cali.index_A(4,i) = plunge_index(3*ceil(i/22)-1) + cali.index_A(2,i);
        [~,cali.index_A(3,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ii - cali.min_r_A));
        [~,cali.index_A(4,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ii - cali.max_r_A));
        
        [~,cali.index_B(1,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ii - cali.max_r_B));
        [~,cali.index_B(2,i)] = min(abs(position(plunge_index(3*n-2):plunge_index(3*n-1)) + 5 + 5*ii - cali.min_r_B));
%         cali.index_B(3,i) = plunge_index(3*ceil(i/22)-1) + cali.index_B(1,i);
%         cali.index_B(4,i) = plunge_index(3*ceil(i/22)-1) + cali.index_B(2,i);
        [~,cali.index_B(3,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ii - cali.min_r_B));
        [~,cali.index_B(4,i)] = min(abs(position(plunge_index(3*n-1):plunge_index(3*n)) + 5 + 5*ii - cali.max_r_B));
        
    end
    
end
% 
% fields = {'IA_ref_current_in','IA_ref_position_in','IA_ref_current_out','IA_ref_position_out'};
% cali = rmfield(cali,fields);

for i = 2:2:22
%     cali.IA_in{i/2} = IA{22*(n-1)+i-1}(cali.index_A(1,22*(n-1)+i-1):cali.index_A(2,22*(n-1)+i-1)-1);
    cali.IA_in{i/2} = IA(i/2,plunge_index(3*n-2) + cali.index_A(1,22*(n-1)+i-1) : plunge_index(3*n-2) + cali.index_A(2,22*(n-1)+i-1));
%     cali.IA_out{i/2} = IA{22*(n-1)+i}(cali.index_A(1,22*(n-1)+i):cali.index_A(2,22*(n-1)+i)-1);
    cali.IA_out{i/2} = IA(i/2,plunge_index(3*n-1) + cali.index_A(3,22*(n-1)+i) : plunge_index(3*n-1) + cali.index_A(4,22*(n-1)+i));
    
%     cali.IB_in{i/2} = IB{22*(n-1)+i-1}(cali.index_B(1,22*(n-1)+i-1):cali.index_B(2,22*(n-1)+i-1)-1);
    cali.IB_in{i/2} = IB(i/2,plunge_index(3*n-2) + cali.index_B(1,22*(n-1)+i-1) : plunge_index(3*n-2) + cali.index_B(2,22*(n-1)+i-1));
%     cali.IB_out{i/2} = IB{22*(n-1)+i}(cali.index_B(1,22*(n-1)+i):cali.index_B(2,22*(n-1)+i)-1);
    cali.IB_out{i/2} = IB(i/2,plunge_index(3*n-1) + cali.index_B(3,22*(n-1)+i) : plunge_index(3*n-1) + cali.index_B(4,22*(n-1)+i));

    cali.position_A_in{i/2} = position(plunge_index(3*n-2) + cali.index_A(1,22*(n-1)+i-1):...
        plunge_index(3*n-2) + cali.index_A(2,22*(n-1)+i-1) ) + 5 * (i/2 + 1);
    cali.position_A_out{i/2} = position(plunge_index(3*n-1) + cali.index_A(3,22*(n-1)+i):...
        plunge_index(3*n-1) + cali.index_A(4,22*(n-1)+i) ) + 5 * (i/2 + 1);
    
    cali.position_B_in{i/2} = position(plunge_index(3*n-2) + cali.index_B(1,22*(n-1)+i-1):...
        plunge_index(3*n-2) + cali.index_B(2,22*(n-1)+i-1) ) + 5 * (i/2 + 1);
    cali.position_B_out{i/2} = position(plunge_index(3*n-1) + cali.index_B(3,22*(n-1)+i):...
        plunge_index(3*n-1) + cali.index_B(4,22*(n-1)+i) ) + 5 * (i/2 + 1);
end

%%
cali.ref_IA_in = [];
cali.ref_IB_in = [];
cali.ref_IA_out = [];
cali.ref_IB_out = [];
cali.ref_position_A_in = [];
cali.ref_position_A_out = [];
cali.ref_position_B_in = [];
cali.ref_position_B_out = [];
    
for i = 1:11
    cali.ref_IA_in = [cali.ref_IA_in,cali.IA_in{i}];
    cali.ref_IB_in = [cali.ref_IB_in,cali.IB_in{i}];
    cali.ref_IA_out = [cali.ref_IA_out,cali.IA_out{i}];
    cali.ref_IB_out = [cali.ref_IB_out,cali.IB_out{i}];
    cali.ref_position_A_in = [cali.ref_position_A_in,cali.position_A_in{i}];
    cali.ref_position_A_out = [cali.ref_position_A_out,cali.position_A_out{i}];
    cali.ref_position_B_in = [cali.ref_position_B_in,cali.position_B_in{i}];
    cali.ref_position_B_out = [cali.ref_position_B_out,cali.position_B_out{i}];
end

[cali.ref_position_A_in,cali.sort_A_in] = sort(cali.ref_position_A_in);
[cali.ref_position_A_out,cali.sort_A_out] = sort(cali.ref_position_A_out);
[cali.ref_position_B_in,cali.sort_B_in] = sort(cali.ref_position_B_in);
[cali.ref_position_B_out,cali.sort_B_out] = sort(cali.ref_position_B_out);

cali.ref_IA_in = smooth(cali.ref_IA_in(cali.sort_A_in),10000);
cali.ref_IB_in = smooth(cali.ref_IB_in(cali.sort_B_in),10000);
cali.ref_IA_out = smooth(cali.ref_IA_out(cali.sort_A_out),10000);
cali.ref_IB_out = smooth(cali.ref_IB_out(cali.sort_B_out),10000);

clear a b c d

for i = 1:11
    a(:,i) = sum(abs(repmat(linspace(0.01,2,200)', 1, length(cali.IA_in{i})) .* repmat(cali.IA_in{i}, 200, 1) - ...
        repmat(interp1( cali.ref_position_A_in , cali.ref_IA_in' , cali.position_A_in{i} ), 200, 1)).^2, 2);
    b(:,i) = sum(abs(repmat(linspace(0.01,2,200)', 1, length(cali.IA_out{i})) .* repmat(cali.IA_out{i}, 200, 1) - ...
        repmat(interp1( cali.ref_position_A_out , cali.ref_IA_out' , cali.position_A_out{i} ), 200, 1)).^2, 2);
    c(:,i) = sum(abs(repmat(linspace(0.01,2,200)', 1, length(cali.IB_in{i})) .* repmat(cali.IB_in{i}, 200, 1) - ...
        repmat(interp1( cali.ref_position_B_in , cali.ref_IB_in' , cali.position_B_in{i} ), 200, 1)).^2, 2);
    d(:,i) = sum(abs(repmat(linspace(0.01,2,200)', 1, length(cali.IB_out{i})) .* repmat(cali.IB_out{i}, 200, 1)  - ...
        repmat(interp1( cali.ref_position_B_out , cali.ref_IB_out' , cali.position_B_out{i} ), 200, 1)).^2, 2);
end


for i = 1:11
    
    [~,index] = min(a(:,i));
    cali.ratio_A(1,i) = 0.01*index;
    [~,index] = min(b(:,i));
    cali.ratio_A(2,i) = 0.01*index;
    [~,index] = min(c(:,i));
    cali.ratio_B(1,i) = 0.01*index;
    [~,index] = min(d(:,i));
    cali.ratio_B(2,i) = 0.01*index;
    
end

cali.ratio(1,:) = (cali.ratio_A(1,:) + cali.ratio_A(2,:))/2;
cali.ratio(2,:) = (cali.ratio_B(1,:) + cali.ratio_B(2,:))/2;
    
ratio = cali.ratio;
ratio_n = n;
% save(['C:\Users\liaol\Desktop\Data_aquisition\DEP _data\',num2str(shot),'\',num2str(shot),'_ratio.mat'], 'ratio','ratio_n');

%%

figure

t = tiledlayout(2,2);

nexttile
for i = 1:11
plot(cali.position_A_in{i},smooth(cali.IA_in{i},1000));hold on
end
plot(cali.ref_position_A_in,cali.ref_IA_in,'black','Linewidth',2)
line([cali.min_r_A, cali.max_r_A], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IA_{in}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_A_out{i},smooth(cali.IA_out{i},1000));hold on
end
plot(cali.ref_position_A_out,cali.ref_IA_out,'black','Linewidth',2)
line([cali.min_r_A, cali.max_r_A], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IA_{out}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_B_in{i},smooth(cali.IB_in{i},1000));hold on
end
plot(cali.ref_position_B_in,cali.ref_IB_in,'black','Linewidth',2)
line([cali.min_r_B, cali.max_r_B], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IB_{in}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_B_out{i},smooth(cali.IB_out{i},1000));hold on
end
plot(cali.ref_position_B_out,cali.ref_IB_out,'black','Linewidth',2)
line([cali.min_r_B, cali.max_r_B], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IB_{out}'],'FontSize',font_size)

sgtitle(['current before'],'FontSize',font_size+6)

figure

t = tiledlayout(2,2);

nexttile
for i = 1:11
plot(cali.position_A_in{i},cali.ratio(1,i) * smooth(cali.IA_in{i},1000));hold on
end
plot(cali.ref_position_A_in,cali.ref_IA_in,'black','Linewidth',2)
line([cali.min_r_A, cali.max_r_A], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IA_{in}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_A_out{i},cali.ratio(1,i) * smooth(cali.IA_out{i},1000));hold on
end
plot(cali.ref_position_A_out,cali.ref_IA_out,'black','Linewidth',2)
line([cali.min_r_A, cali.max_r_A], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IA_{out}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_B_in{i},cali.ratio(2,i) * smooth(cali.IB_in{i},1000));hold on
end
plot(cali.ref_position_B_in,cali.ref_IB_in,'black','Linewidth',2)
line([cali.min_r_B, cali.max_r_B], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IB_{in}'],'FontSize',font_size)

nexttile
for i = 1:11
plot(cali.position_B_out{i},cali.ratio(2,i) * smooth(cali.IB_out{i},1000));hold on
end
plot(cali.ref_position_B_out,cali.ref_IB_out,'black','Linewidth',2)
line([cali.min_r_B, cali.max_r_B], [0, 0], 'LineStyle', '--', 'Color', 'k','Linewidth',1)
title(['IB_{out}'],'FontSize',font_size)

sgtitle(['current after'],'FontSize',font_size+6)

figure
t = tiledlayout(2,2);

nexttile
plot(a)
title(['A_{in}'],'FontSize',font_size)

nexttile
plot(b)
title(['A_{out}'],'FontSize',font_size)

nexttile
plot(c)
title(['B_{in}'],'FontSize',font_size)

nexttile
plot(d)
title(['B_{out}'],'FontSize',font_size)


sgtitle(['ratio'],'FontSize',font_size+6)


figure

plot(cali.ratio_A(1,:),'b','Linewidth',1);hold on
plot(cali.ratio_A(2,:),'b','Linewidth',1,'Linestyle','--');
plot(ratio(1,:),'b','Linewidth',2);

plot(cali.ratio_B(1,:),'r','Linewidth',1);
plot(cali.ratio_B(2,:),'r','Linewidth',1,'Linestyle','--');
plot(ratio(2,:),'r','Linewidth',2);

legend('A_{in}','A_{out}','A','B_{in}','B_{out}','B')
xlabel('channels','FontSize',font_size)
title([num2str(shot),', plunge ', num2str(n),', ratio'],'FontSize',font_size+6)
ylim([0 2])



