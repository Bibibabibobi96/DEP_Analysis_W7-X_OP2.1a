close all
clear
tic

analysis_number = input('How many plunges? ');

cali_shot = input(['calibration shot number?',newline,...
    '(0 = none, 1 = self calibration, 2 = 221207045) ']);

for i = 1:analysis_number
    shot_list(i) = input(['shot number (',num2str(i),') ? ']);
    plunge(i) = input('corresponding plunge? ');
end

figure(301) % current evolution plot
t1 = tiledlayout(analysis_number,3);

figure(302) % Te, ne plot
t2 = tiledlayout(6,analysis_number);

figure(303) % current of channels plot
t3 = tiledlayout(6,3);

for n = 1:analysis_number

    if ~exist('shot') || shot ~= shot_list(n)
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
            cali_shot = 221207045;%standard calibration
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

    end

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
sgtitle(['DEP collected current',newline],'FontSize',font_size+6)
colormap(colorm(20));

figure(302)

for i = 1:6
    linkaxes( ax2((i-1)*n+1:i*n), 'y')
end
linkaxes(ax2,'x')

t2.TileSpacing = 'none';
t2.Padding = 'compact';


figure(303)
legend_text = [];
for i = 1:analysis_number
    legend_text =  [legend_text;[num2str(shot-221200000),', ',num2str(plunge(i))]];
end

for i = 1:3
    ax3(6*i);

    for j = 1:n
        h(j) = plot(NaN,NaN,'color',C(j,:));
    end

    legend(h, legend_text,'Location','northeast');
end

linkaxes([ax3(1:12)],'xy')
linkaxes([ax3(13:18)],'xy')
if shot < 221206033
    ax3(1);
    ylim([-0.02 0.11])
    ax3(13);
    ylim([-0.06 0.06])
elseif shot < 221206050
    ax3(1);
    ylim([-0.02 0.55])
    ax3(13)
    ylim([-0.06 0.06])
else
    ax3(1);
    ylim([-0.05 0.33])
    ax(13);
    ylim([-0.11 0.15])
end
t3.TileSpacing = 'none';
t3.Padding = 'compact';
