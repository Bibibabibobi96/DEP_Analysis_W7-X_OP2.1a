close all
clear
tic
shot = input('shot number?');

cali_shot = input('calibration shot number? (0 = none, 1 = self calibration)');

load([num2str(shot),'\',num2str(shot),'.mat'])
% time = time+0.0025;

DEP_data_pre_plot

DEP_plunge_evolution

if cali_shot == 1

    DEP_calibration

    for i = 1:11    
        IA(i,:) = ratio(1,i) * IA(i,:);
        IB(i,:) = ratio(2,i) * IB(i,:);
    end


elseif cali_shot == 0

else
    load([num2str(cali_shot),'\',num2str(cali_shot),'_ratio.mat'])

    for i = 1:11
        IA(i,:) = ratio(1,i) * IA(i,:);
        IB(i,:) = ratio(2,i) * IB(i,:);
    end

end

DEP_current_by_r

if cali_shot ~= 0
    DEP_plunge_evolution
end

% DEP_fft




