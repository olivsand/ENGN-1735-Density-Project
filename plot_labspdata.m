close all
set(gcf, 'renderer', 'zbuffer');
opengl software

%This script plots raw Arduino data in units of voltage versus time. Due to
%difficulties in achieving results from a discrete Fourier
%transform (commented out below), we have also estimated resonant frequencies by observing when
%the relative amplitude of the sensor data peaks. 

%An attempt to 
%figure
%ftest = plotdata('25hz_air.txt',25);
%y=ftest/length(ftest);
%amp=2*abs(y);
%plot(amp);

%commented out, sweep throughout frequencies to estimate resonance 

% figure
%  hold on
%  plotdata('15hz_air.txt',15)
%  plotdata('20hz_air.txt',20)
%  plotdata('25hz_air.txt',25)
%  plotdata('30hz_air.txt',30)
%  legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')
%  figure
%  hold on
%  plotdata('35hz_air.txt',35)
%  plotdata('40hz_air.txt',40)
%  plotdata('45hz_air.txt',45)
%  legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')
%  figure
%  hold on
%  plotdata('50hz_air.txt',50)
%  plotdata('55hz_air.txt',55)
%  plotdata('60hz_air.txt',60)
%  legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')
%  figure
%  hold on
%  plotdata('70hz_air.txt',70)
%  plotdata('75hz_air.txt',75)
%  plotdata('80hz_air.txt',80)
%  legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')
%  figure
%  hold on
%  plotdata('85hz_air.txt',85)
%  plotdata('90hz_air.txt',90)
%  plotdata('95hz_air.txt',95)
%  legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')
%  figure
%  hold on
%  plotdata('100hz_air.txt',100)
%  plotdata('105hz_air.txt',105)
%  plotdata('110hz_air.txt',110)
% legend
% xlabel('time, s');
% ylabel('frequency from sensor, mV')

%Air: by data and visual observation, 25 and 60 Hz were close to resonant
%frequencies.
plotdata('25hz_air.txt',25,2)
hold on
%plotdata('60hz_air.txt',60,2)
plotdata('15hz_air.txt',15,0.5)
plotdata('50hz_air.txt',50,0.5)
plotdata('100hz_air.txt',100,0.5)
legend
xlabel('time, s');
ylabel('amplitude from sensor, mV')
title('Sensor output to qualitatively demonstrate lower resonance, Air')

%demonstrating 60Hz resonance
figure
plotdata('60hz_air.txt',60,2)
hold on
plotdata('15hz_air.txt',15,0.5)
plotdata('50hz_air.txt',50,0.5)
plotdata('100hz_air.txt',100,0.5)
legend
xlabel('time, s');
ylabel('amplitude from sensor, mV')
title('Sensor output to qualitatively demonstrate higher resonance, Air')



%Water: Plotting frequencies to observe qualitative resonance. This was
%roughly 15-20 Hz.
figure
hold on
plotdata('15hz_water.txt',15,2)
plotdata('20hz_water.txt',20,0.5)
plotdata('25hz_water.txt',25,0.5)
plotdata('30hz_water.txt',30,0.5)
legend
xlabel('time, s');
ylabel('amplitude from sensor, mV')
title('Sensor output to qualitatively demonstrate resonance, resonant frequencies in bold, Water')

%with a resonant frequency at 15 Hz for water and 25 Hz for air
%qualitatively observed, now we can use the linear properties of the
%density meter to create a best-fit line that outputs a density for a
%measured resonant frequency.

%data = [air,water]
rfreqs = [21,15]; %Hz
densities = [1.225,1000]; %kg/m^3
figure
hold on
%fitting a line to the 2 points to find the slope
fitline = polyfit(rfreqs,densities,1);
plot(rfreqs(1),densities(1),'ro','LineWidth',2);
plot(rfreqs(2),densities(2),'bo','LineWidth',2);
plot(rfreqs,densities,'--','LineWidth',2)
legend('Air Measurement','Water Measurement',['\rho = ',num2str(fitline(1)),'f + ',num2str(fitline(2))])
xlabel('f = Resonant Frequency, Hz');
ylabel('\rho = Density, kg/m^3')
xlim([10 30]); ylim([-100 1100])
title('Results of Density Calibration from Air and Water, PI Data')




%A data-plotting function for Arduino serial output. Returns a fourier
%transform for frequency-domain analysis, if desired.
function fourier = plotdata(datafile,freq,width)
data = readtable(datafile);
times = data(:,1);
times = times{:,:};
amplitude = data(:,3);
amplitude = amplitude{:,:};
plot(amplitude,'DisplayName',[num2str(freq),' Hz'],'LineWidth',width)

%limits of indices in time and amplitude arrays
lowlim = 50;
highlim = 175;
xlim([lowlim highlim])
timediff = times(highlim)-times(lowlim);
%this is the time difference in seconds
timediff = seconds(timediff);
%scaling plot to be in seconds
xt = get(gca, 'XTick'); % Current X-Tick Values
set(gca, 'XTick',xt, 'XTickLabel',(xt - lowlim)*timediff/(highlim-lowlim));

fdata = amplitude(lowlim:highlim,:);
fourier = fft(fdata);
end



