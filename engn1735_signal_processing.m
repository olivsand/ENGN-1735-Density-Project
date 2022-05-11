%% ENGN1735: Density Meter Project Signal Processing Workflow
%% 1: Time Domain plot with .csv Data
%Time (hh:mm:ss.000) vs. signal .csv file
t = readtable('water_sweep_data.csv','ReadVariableNames',true);
t.Properties.VariableNames{1} = 'Time';
t.Properties.VariableNames{2} = 'Signal';
x = t.Signal;
time = t.Time;
plot(t.Time, t.Signal);
title('Raw Time (s) vs. Signal (4.9mV/unit) Data for Air Test')
xlabel('Time (ms)')
ylabel('Signal Value (4.9mV/unit')

[f, F_x_f]=fourier(time,x,'sinus'); %Fourier transform for continuous signal data, to obtain frequency peaks
figure
stem(f,abs(F_x_f),'Linewidth',1); %stem plot to further showcase peak frequencies obtained from FFT
title('FFT Plot of Data For fn Identification, Air Test')
xlabel('Frequency (Hz)')
ylabel('Signal Amplitude')