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

% 5
figure(2)
plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')

figure(3)
plot(t, signal)
figure(4)
Filtered_signal = filtfilt (sos,g,signal) ;
plot(t, Filtered_signal)

figure(5)
y = fft(Filtered_signal);
plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')
% adds baseline drift :(((
