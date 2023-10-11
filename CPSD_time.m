function [cpsd_values,time_values,F] = CPSD_time(x,y,window,noverlap,nfft,fs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% 定义两个示例信号
% fs = 1000; % 采样频率
t = 0:1/fs:5; % 时间向量
% x = cos(2*pi*50*t) + randn(size(t)); % 示例信号1
% y = 0.5*cos(2*pi*50*t) + randn(size(t)); % 示例信号2

% 设置参数
% window = hamming(256); % 窗口函数
% noverlap = 128; % 窗口重叠量
% nfft = 512; % FFT点数

% 初始化存储 CPSD 随时间的结果
num_segments = floor((length(x) - noverlap) / (length(window) - noverlap));
cpsd_values = zeros(nfft / 2 + 1, num_segments);
time_values = zeros(1, num_segments);

% 计算 CPSD 随时间的分布
for i = 1:num_segments
    start_idx = (i - 1) * (length(window) - noverlap) + 1;
    end_idx = start_idx + length(window) - 1;
    
    x_segment = x(start_idx:end_idx);
    y_segment = y(start_idx:end_idx);
    
    [Pxy, F] = cpsd(x_segment, y_segment, window, noverlap, nfft, fs);
    
    cpsd_values(:, i) = Pxy;
    time_values(i) = (start_idx + end_idx) / (2 * fs);
end

% 绘制 CPSD 随时间的分布
% figure;
% surf(time_values, F, 10*log10(abs(cpsd_values)), 'EdgeColor', 'none');
% axis tight;
% view(0, 90); % 使图像竖直
% xlabel('时间 (s)');
% ylabel('频率 (Hz)');
% title('CPSD 随时间的分布 (dB)');
% colorbar;
end