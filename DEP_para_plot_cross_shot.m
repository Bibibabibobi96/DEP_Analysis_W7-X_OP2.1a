% for n = 0:analysis_number -1
i = n - 1;


ax2(1 + i) = nexttile(1 + i);
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),...
    Te(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),...
    Te(plunge_index(3* i +2):plunge_index(3* i +3)));
set(gca,'xticklabel',[],'fontsize', font_size)
title(['shot #',num2str(shot),newline,'plunge ',num2str(plunge(n))])
legend('in','out')
if i == 0
    ylabel('T_e')
else
    set(gca,'yticklabel',[])
end

ax2(analysis_number+1+i) = nexttile(analysis_number+1+i);
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),...
    ne(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),...
    ne(plunge_index(3* i +2):plunge_index(3* i +3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if i == 0
    ylabel('n_e')
else
    set(gca,'yticklabel',[])
end

ax2(2*analysis_number+1+i) = nexttile(2*analysis_number+1+i);
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),...
    Vf(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),...
    Vf(plunge_index(3* i +2):plunge_index(3* i +3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if i == 0
    ylabel('V_f')
else
    set(gca,'yticklabel',[])
end

ax2(3*analysis_number+1+i) = nexttile(3*analysis_number+1+i);
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),...
    Isat(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),...
    Isat(plunge_index(3* i +2):plunge_index(3* i +3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if i == 0 
    ylabel('I_{sat}')
else
    set(gca,'yticklabel',[])
end

ax2(4*analysis_number+1+i) = nexttile(4*analysis_number+1+i);
% plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),IA(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
% plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),IA(plunge_index(3* i +2):plunge_index(3* i +3)));
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),...
    pe(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),...
    pe(plunge_index(3* i +2):plunge_index(3* i +3)));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if i == 0 
%     ylabel('I_{A}')
    ylabel('p_{e}')
else
    set(gca,'yticklabel',[])
end

ax2(5*analysis_number+1+i) = nexttile(5*analysis_number+1+i);
plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),Er{2* i +1});hold on
plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),Er{2* i +2});
ylim([-500 200])
set(gca,'fontsize', font_size)
xlabel('R (mm)')
% legend('in','out')
if i == 0 
    ylabel('E_{r}')
else
    set(gca,'yticklabel',[])
end

linkaxes(ax2,'x')

if shot > 221206037
    xlim([min(position) 6130])
else
    xlim([min(position) 6080])
end

