% 加载数据
data1 = IA(1,plunge_index(2)-10000:plunge_index(2));
data2 = IA(2,plunge_index(2)-10000:plunge_index(2));

% 计算互相关函数
corr = xcorr(data1, data2);

% 计算延迟
[~, delay] = max(abs(corr));
delay = delay - length(data1);

disp(['时间延迟为：', num2str(delay)]);


%%


% 加载数据
data = IA(2,plunge_index(2)-10000:plunge_index(2));

% Set the window size and overlap percentage
window_size = 256;
overlap_percent = 50;

% Compute the window function
window = hamming(window_size);

% Compute the FFT for each window
num_windows = floor(length(data)/(window_size*(1-overlap_percent/100)));
spectrum = zeros(window_size/2+1, num_windows);
for i = 1:num_windows
    % Get the current window
    start_index = round((i-1)*(1-overlap_percent/100)*window_size)+1;
    end_index = start_index+window_size-1;
    current_window = data(start_index:end_index) .* window;
    
    % Compute the FFT for the current window
    Y = fft(current_window);
    P2 = abs(Y/window_size);
    P1 = P2(1:window_size/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    % Store the spectrum for the current window
    spectrum(:,i) = P1;
end

% Plot the spectrum
f = linspace(0, 0.5, window_size/2+1)*Fs;
t = linspace(0, length(data)/Fs, num_windows);
imagesc(t, f, 20*log10(spectrum));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
colorbar;
