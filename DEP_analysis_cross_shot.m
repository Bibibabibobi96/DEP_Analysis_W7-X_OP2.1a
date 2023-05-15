close all
clear
tic

analysis_number = input('How many plunges? ');

cali_shot = input(['calibration shot number?',newline,...
    '(0 = none, 1 = self calibration, 2 = 221207047) ']);

for i = 1:analysis_number
    shot_list(i) = input(['shot number (',num2str(i),') ? ']);
    plunge(i) = input('corresponding plunge? ');
end

ndowns = 100;

figure(301) % current evolution plot
t1 = tiledlayout(analysis_number,3);

figure(302) % Te, ne plot
t2 = tiledlayout(6,analysis_number);

figure(303) % current of channels plot
t3 = tiledlayout(6,3);

for n = 1:analysis_number
    
    clear IA IB IA_raw IB_raw

%     if ~exist('shot') || shot ~= shot_list(n)
        load(['C:\Users\Liao\Documents\50g\W7-X_OP2.1a_exp\DEP_data\',...
            num2str(shot_list(n)),'\',num2str(shot_list(n)),'.mat'])

        DEP_filt

        DEP_plunge_evolution

        if cali_shot == 1
            DEP_calibration
            for i = 1:11
                IA(i,:) = ratio(1,i) * IA(i,:);
                IB(i,:) = ratio(2,i) * IB(i,:);
            end
        elseif cali_shot == 0
        elseif cali_shot == 2
            cali_shot = 221207047;%standard calibration
            load([num2str(cali_shot),'\',num2str(cali_shot),'_ratio.mat'])
            for i = 1:11
                IA(i,:) = ratio(1,i) * IA(i,:);
                IB(i,:) = ratio(2,i) * IB(i,:);
            end
        else
            load([num2str(cali_shot),'\',num2str(cali_shot),'_ratio.mat'])
            for i = 1:11
                IA(i,:) = ratio(1,i) * IA(i,:);
                IB(i,:) = ratio(2,i) * IB(i,:);
            end
        end

%     end

    figure(301)
    DEP_plunge_evolution_plot_cross_shot


    figure(302)
    DEP_para_plot_cross_shot


    figure(303)
    DEP_current_by_r_cross_shot

end

figure(301)
t1.TileSpacing = 'none';
t1.Padding = 'compact';
linkaxes(ax1,'x')
sgtitle(['DEP collected current',newline],'FontSize',font_size+6)
colormap(colorm(20));

figure(302)
linkaxes(ax2,'x')
for i = 1:6
    linkaxes( ax2((i-1)*n+1:i*n), 'y')
end

t2.TileSpacing = 'none';
t2.Padding = 'compact';


figure(303)
legend_text = [];
for i = 1:analysis_number
    legend_text =  [legend_text;[num2str(shot_list(i)-221200000),', ',num2str(plunge(i))]];
end

% for i = 1:3
%     ax3(6*i);
%     ax3(1)
    for j = 1:n
        h(j) = plot(NaN,NaN,'color',C(j,:),'LineStyle','-','Marker','none');
    end

    legend(h, legend_text,'Location','best');
% end

linkaxes([ax3(1:10)],'xy')
linkaxes([ax3(11:15)],'xy')
linkaxes(ax3,'x')
linkaxes([ax3(1:10)],'xy')
linkaxes([ax3(11:15)],'xy')
t3.TileSpacing = 'none';
t3.Padding = 'compact';
