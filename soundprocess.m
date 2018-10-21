fs = 44100;
t = 0 : 1/fs : 1; 
f = 530;
A = {};
tone= [];
j =1;
for i=1:12
   A{i}=0.02*sin(2*pi*f*(2^(i-1)).^(1/12)*t);
end
tone = [A{1} A{1} A{3} A{1} A{6} A{5} A{1} A{1} A{3} A{1} A{8} A{6} A{1} A{1} A{11} A{9} A{6} A{4} A{3} A{9} A{9} A{9} A{4} A{6} A{4} ];
[g,Fs] = audioread('orig_input.wav');
melody =g + (tone(1:length(g)))'; 
soundsc(melody,44100);
N =length(melody); %number of FFT point
transform = fft(g,N)/N;
magTransform = abs(transform);
faxis = linspace(-N/2,N/2,N);
figure(1);
plot(faxis,fftshift(magTransform));
title('The Spectrum');
xlabel('Frequency (Hz)')
figure(2);
win = 128; % window length in samples
% number of samples between overlapping windows:
hop = win/2;          
nfft = win; % width of each frequency bin 
spectrogram(melody,win,hop,nfft,fs,'yaxis')
% change the tick labels of the graph from scientific notation to floating point: 
yt = get(gca,'YTick');  
title('Spectrogram');

