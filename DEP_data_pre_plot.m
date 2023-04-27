
% if shot == 221207036
% for i = 1:plunge_n
%     [~,ii] = min(position(plunge_index(3*i-2):plunge_index(3*i)));
%     plunge_index(3*i-1) = plunge_index(3*i-2) + ii;
% 
%     for j = 1:11
%         
%     end
% end

% clear i j ii a
% end

position(isnan(position)) = 7000;
% time = time + 0.0025;

%% 
plunge_n = double(plunge_n);
Wn = 2*(2e3)/fs;
[b,a]=butter(3,Wn);
Wn2 = 2*(500)/fs;
[b2,a2]=butter(1,Wn2);
% [b, a] = butter(10, 60/5000, 'high');

Vp = 2.8 * Te_raw + Vf;
Vp = filtfilt(b,a,Vp);
Vp = smoothdata(Vp,"gaussian",200);
clear Er
for i = 1:plunge_n
    Er{2*i-1} = -gradient( Vp(plunge_index(3*i-2):plunge_index(3*i-1)),position(plunge_index(3*i-2):plunge_index(3*i-1)) );
    Er{2*i} = -gradient( Vp(plunge_index(3*i-1):plunge_index(3*i)),position(plunge_index(3*i-1):plunge_index(3*i)) );
%     Er{2*i-1} = filtfilt(b,a,Er{2*i-1});
%     Er{2*i} = filtfilt(b,a,Er{2*i});
end

figure

plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),Er{2*i-1})
ylim([-1000 1000])

% IA_raw = IA;
% IB_raw = IB;

clear IA_offset IB_offset
for i = 1:11
    IA_offset(i) = mean(IA_raw(i,1:10000));
    IB_offset(i) = mean(IB_raw(i,1:10000));
%     IA_offset(i) = 0;
%     IB_offset(i) = 0;
%     IA_offset(i) = mean(IA{2*i}(1:10000));
%     IB_offset(i) = mean(IB{2*i}(1:10000));

end

figure
plot(IA_offset)
hold on
plot(IB_offset)

for i = 1:11
    IA(i,:) = filtfilt(b,a,IA_raw(i,:))-IA_offset(i);
    IB(i,:) = filtfilt(b,a,IB_raw(i,:))-IB_offset(i);
end


Isat = filtfilt(b,a,Isat);
ne = filtfilt(b2,a2,ne_raw);
Te = filtfilt(b2,a2,Te_raw);


%% 

figure(22)

t = tiledlayout(6,plunge_n);

% tight_subplot.gap = [.01 .03];
% tight_subplot.marg_h = [.1 .01];
% tight_subplot.marg_w = [.01 .01];

% tight_subplot(6, plunge_n, tight_subplot.gap, tight_subplot.marg_h, tight_subplot.marg_w);
% [ha, pos] = tight_subplot(3,2,[.01 .03],[.1 .01],[.01 .01])

font_size = 12;

for n = 0:plunge_n-1
ax(1+6*n) = nexttile(1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),Te(plunge_index(3*n+1):plunge_index(3*n+2)));hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),Te(plunge_index(3*n+2):plunge_index(3*n+3)));
set(gca,'xticklabel',[],'fontsize', font_size)
title(['plunge ',num2str(n+1)])
legend('in','out')
if n == 0
    ylabel('T_e')
% else
%     set(gca,'yticklabel',[])
end

ax(2+6*n) = nexttile(plunge_n+1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),ne(plunge_index(3*n+1):plunge_index(3*n+2)));hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),ne(plunge_index(3*n+2):plunge_index(3*n+3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if n == 0
    ylabel('n_e')
% else
%     set(gca,'yticklabel',[])
end

ax(3+6*n) = nexttile(2*plunge_n+1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),Vf(plunge_index(3*n+1):plunge_index(3*n+2)));hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),Vf(plunge_index(3*n+2):plunge_index(3*n+3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if n == 0
    ylabel('V_f')
% else
%     set(gca,'yticklabel',[])
end

ax(4+6*n) = nexttile(3*plunge_n+1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),Isat(plunge_index(3*n+1):plunge_index(3*n+2)));hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),Isat(plunge_index(3*n+2):plunge_index(3*n+3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if n == 0 
    ylabel('I_{sat}')
% else
%     set(gca,'yticklabel',[])
end

ax(5+6*n) = nexttile(4*plunge_n+1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),IA(plunge_index(3*n+1):plunge_index(3*n+2)));hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),IA(plunge_index(3*n+2):plunge_index(3*n+3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if n == 0 
    ylabel('I_{A}')
% else
%     set(gca,'yticklabel',[])
end

ax(6+6*n) = nexttile(5*plunge_n+1+n);
plot(position(plunge_index(3*n+1):plunge_index(3*n+2)),Er{2*n+1});hold on
plot(position(plunge_index(3*n+2):plunge_index(3*n+3)),Er{2*n+2});
ylim([-500 200])
set(gca,'fontsize', font_size)
% legend('in','out')
if n == 0 
    ylabel('E_{r}')
% else
%     set(gca,'yticklabel',[])
end

end

t.TileSpacing = 'compact';
t.Padding = 'compact';

linkaxes([ax],'x')
if shot > 221206037
    xlim([min(position) 6130])
else
    xlim([min(position) 6080])
end
sgtitle(num2str(shot))


%%

figure

t = tiledlayout(2,1);
ax(1) = nexttile;
plot(time,position,'Color','g','LineWidth',2);hold on
for i = 1:plunge_n
    plot(time(plunge_index(3*i-2):plunge_index(3*i-1)),...
        position(plunge_index(3*i-2):plunge_index(3*i-1)),'Color','r','LineWidth',2);
    plot(time(plunge_index(3*i-1):plunge_index(3*i)),...
        position(plunge_index(3*i-1):plunge_index(3*i)),'Color','b','LineWidth',2);
end

% xlim([0 20])
ax(2) = nexttile;
plot(time),view(90,90)
% ylim([0 20])


% linkaxes([ax],'x')





