% for n = 0:analysis_number -1
j = n - 1;
i = plunge(n)-1;

ax2(1 + j) = nexttile(1 + j);
plot(downsample(position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( Te(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( Te(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
title([num2str(floor(shot_list(n)/1000)),'.',num2str(mod(shot_list(n),100)) ...
    ,newline,'plunge ',num2str(plunge(n))])
legend('in','out')
if j == 0
    ylabel('T_e')
else
    set(gca,'yticklabel',[])
end

ax2(analysis_number+1+j) = nexttile(analysis_number+1+j);
plot(downsample(position(plunge_index(3* i +1):plunge_index(3* i +2)),ndowns),...
    downsample( ne(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( ne(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if j == 0
    ylabel('n_e')
else
    set(gca,'yticklabel',[])
end

ax2(2*analysis_number+1+j) = nexttile(2*analysis_number+1+j);
plot(downsample( position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( Vf(plunge_index(3* i +1):plunge_index(3* i +2)) ,ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( Vf(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if j == 0
    ylabel('V_f')
else
    set(gca,'yticklabel',[])
end

ax2(3*analysis_number+1+j) = nexttile(3*analysis_number+1+j);
plot(downsample( position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( Isat(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( Isat(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if j == 0 
    ylabel('I_{sat}')
else
    set(gca,'yticklabel',[])
end

ax2(4*analysis_number+1+j) = nexttile(4*analysis_number+1+j);
% plot(position(plunge_index(3* i +1):plunge_index(3* i +2)),IA(plunge_index(3* i +1):plunge_index(3* i +2)));hold on
% plot(position(plunge_index(3* i +2):plunge_index(3* i +3)),IA(plunge_index(3* i +2):plunge_index(3* i +3)));
plot(downsample( position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( pe(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( pe(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if j == 0 
%     ylabel('I_{A}')
    ylabel('T_{e} * n_{e}')
else
    set(gca,'yticklabel',[])
end

ax2(5*analysis_number+1+j) = nexttile(5*analysis_number+1+j);
plot(downsample( position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( Er{2* i +1}, ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( Er{2* i +2}, ndowns));
ylim([-500 200])
set(gca,'fontsize', font_size)
xlabel('R (mm)')
% legend('in','out')
if j == 0 
    ylabel('E_{r}')
else
    set(gca,'yticklabel',[])
end

ax2(6*analysis_number+1+j) = nexttile(6*analysis_number+1+j);
plot(downsample( position(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns),...
    downsample( vplus(plunge_index(3* i +1):plunge_index(3* i +2)), ndowns));hold on
plot(downsample( position(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns),...
    downsample( vplus(plunge_index(3* i +2):plunge_index(3* i +3)), ndowns));
set(gca,'xticklabel',[],'fontsize', font_size)
% legend('in','out')
if j == 0 
%     ylabel('I_{A}')
    ylabel('V_{+}')
else
    set(gca,'yticklabel',[])
end

linkaxes(ax2,'x')

if sum(shot_list < 221206033) == length(shot_list)
    xlim([min(position) 6080])
else
    xlim([min(position) 6130])
end

