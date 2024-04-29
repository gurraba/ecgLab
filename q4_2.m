% 1
Wp = [1 100]/ Fn ; % Normalised Passband
Ws = [0.5 120]/ Fn ; % Normalised Stopband
Rp = 1; % Passband Ripple ( dB )
Rs = 50; % Stopband Ripple ( dB )

[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);

disp(n)
disp(Ws)
disp(Wp)
disp(Rp)
disp(Rs)

% 2
[z,p,k] = cheby2(n,Rs,Ws);

disp(z)
disp(p)
disp(k)

% 3
[sos,g] = zp2sos(z,p,k);

disp(sos)
disp(g)

% 4
figure(1)
freqz (sos, n, Fs)
title('Filter Chebyshev type II')

% 5
figure(2)
plot(t,AmplitudeData)
hold on;
ChebyFilteredAmplitudeData= filtfilt (sos,g,AmplitudeData) ;
plot(t, ChebyFilteredAmplitudeData)
hold off;
legend('Raw', 'Chebyshev type II');
xlabel('Time [s]')
ylabel('Amplitude [mV]')
title('ECG')

figure(3)
plot(f,abs(FourierAmplitudeData))
hold on;
FourierChebyFilteredAmplitudeData = fft(ChebyFilteredAmplitudeData);
plot(f,abs(FourierChebyFilteredAmplitudeData))
hold off;
legend('Raw', 'Chebyshev type II');
xlabel('Frequency [Hz]')
ylabel('Magnitude')
title('ECG spectrum')