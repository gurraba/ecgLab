F0 = 50;
Fs = 256;
Fn = Fs / 2;

wo = F0 / Fn ;
bw = wo /35;
[b , a ] = iirnotch ( wo , bw ) ;

figure(1)
freqz (b, a, 2^16 , Fs)
title('Notch filter 50 Hz')

Ts = 1/Fs;
t = TimeData;
FourierAmplitudeData = fft(AmplitudeData);
fs = 1/Ts;
f = (0:length(FourierAmplitudeData)-1)*fs/length(FourierAmplitudeData);

figure(2)
%plot(t, AmplitudeData)
plot(AmplitudeData)
hold on;
NotchFilteredAmplitudeData = filtfilt (b ,a , AmplitudeData) ;
%plot(t, NotchFilteredAmplitudeData, '--', 'LineWidth', 1)
plot(NotchFilteredAmplitudeData, '--', 'LineWidth', 1)
hold off;
legend('Raw', 'Notch 50 Hz');
xlabel('Sample nr')
ylabel('Amplitude [mV]')
title('ECG')

figure(3)
plot(f, abs(FourierAmplitudeData))
hold on;
FourierNotchFilteredAmplitudeData = fft(NotchFilteredAmplitudeData);
plot(f, abs(FourierNotchFilteredAmplitudeData))
hold off;
legend('Raw', 'Notch 50 Hz');
xlabel('Frequency [Hz]')
ylabel('Magnitude')
title('ECG spectrum')

figure(4)
plot(f, abs(FourierAmplitudeData), 'o-')
hold on;
FourierNotchFilteredAmplitudeData = fft(NotchFilteredAmplitudeData);
plot(f, abs(FourierNotchFilteredAmplitudeData), 'o-')
hold off;
legend('Raw', 'Notch 50 Hz');
xlabel('Frequency [Hz]')
ylabel('Magnitude')
title('ECG spectrum')
