F0 = 50;
Fs = 250;
Fn = Fs / 2;

wo = F0 / Fn ;
bw = wo /35;
[b , a ] = iirnotch ( wo , bw ) ;

figure(1)
freqz (b, a, 2^16 , Fs)

% -
figure(2)
Ts = 1/Fs;
t = TimeData;
signal = AmplitudeData;
y = fft(signal);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude raw')
% -

figure(3)
Filtered_signal = filtfilt (b ,a , signal) ;
plot(t, Filtered_signal)

figure(4)
y = fft(Filtered_signal);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude notch filter 50 Hz')