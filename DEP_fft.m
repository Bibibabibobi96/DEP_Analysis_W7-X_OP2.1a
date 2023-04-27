clear ax

figure
tf = tiledlayout(7,plunge_n);

for i = 1:7
for j = 1:plunge_n
% Generate a test signal
fft.Fs = fs;  % Sampling frequency
fft.t = 0:1/fft.Fs:1-1/fft.Fs;  % Time vector
% x = cos(2*pi*100*t) + sin(2*pi*200*t);
fft.x = IA_raw(i,plunge_index(3*j-2):plunge_index(3*j));

% Define the frequency domain of interest
fft.fmin = 0;  % Minimum frequency of interest
fft.fmax = 2e5; % Maximum frequency of interest

% Set the parameters for the windowed Fourier transform
fft.window = 256/8;  % Window size
fft.noverlap = 200/8;  % Number of overlapping samples
fft.nfft = 1024 ;  % Number of FFT points

% Calculate the windowed Fourier transform
[fft.S, fft.F, fft.T] = spectrogram(fft.x, fft.window, fft.noverlap, fft.nfft, fft.Fs);

% Find the indices corresponding to the frequency domain of interest
fft.idx_min = find(fft.F >= fft.fmin, 1);
fft.idx_max = find(fft.F <= fft.fmax, 1, 'last');

% Extract the spectrogram values for the desired frequency range
fft.S_f = fft.S(fft.idx_min:fft.idx_max, :);
fft.F_f = fft.F(fft.idx_min:fft.idx_max);
fft.T_f = fft.T;

% Plot the results
% figure;
% t = tiledlayout(4,1);

ax(i+(j-1)*7) = nexttile((i-1)*plunge_n+j);
imagesc(fft.T_f + time(1,plunge_index(3*j-2)), fft.F_f/1000, abs(fft.S_f));
axis xy;

if i == 1
    title('Windowed Fourier Transform','FontSize',font_size+4);
    xticks([]);
elseif i == 7
    xlabel('Time (s)','FontSize',font_size);
else
    xticks([]);
end

if j == 1
    ylabel('Frequency (kHz)','FontSize',font_size);
else
    yticks([]);
end



% colorbar;
colormap('turbo')

% ax(2) = nexttile(4);0
% plot(time(1,plunge_index(1):plunge_index(3)),position(1,plunge_index(1):plunge_index(3)))

end
end

tf.TileSpacing = 'none';
tf.Padding = 'compact';

for i = 0:plunge_n-1
    linkaxes([ax(1+7*i:7+7*i)],'xy');
end

clear ax tf



