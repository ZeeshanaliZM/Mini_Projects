%Hydrophones Program to detect sound and calculate distance of source
figure(1)
Fs = 44100; %Sampling Rate which must always be greater than the generated frequency to detect it
nBits = 24; %Default Number of Bits
NumChannels = 1; %Default Number of Channels                                        
ID = -1; %Automatically detects audio input device
audio_sample = audiorecorder(Fs,nBits,NumChannels,ID); %Object to record Sound
recordblocking(audio_sample,5); %Records sound for 5 seconds
play(audio_sample); %plays the recorded Sound
a = input("Enter any key to continue");
audio_data = getaudiodata(audio_sample); %Stores the audio Samples in an array
subplot(1,2,1); 
plot(audio_data);
title("Amplitude-Time Plot of the signal for 1000Hz frequency"); 
audiodata_fft = fft(audio_data); %Fast Fourier Transform of the audio sample array
N = length(audio_data);
f_axis = [0:N-1]*Fs/N;
subplot(1,2,2);
plot(f_axis,abs(audiodata_fft));title("Frequency Spectrum of the Signal for 1000 Hertz");
max_value = max(abs(audiodata_fft));
detected = 0;count = 1;f_max = 0;
%Finding the Frequency with the Maximum power/Amplitude
while(detected==0)
    if(abs(audiodata_fft(count))==max_value)
        f_max = round((count-1)*Fs/N);
        detected = 1;
    else
        count = count+1;
    end
end
disp("Frequency of Max Value");
disp(f_max);

%Fitering and Smoothening the Audio Signal Recieved from the Hydrophone
%Filtered using Butterworth Filter
figure(2)
f_low_c = 1000-20; %Lower Cutoff Frequency. We consider a signal of 1000Hz so Fmax = 1000Hz
f_high_c = 1000+20; %Higher Cutoff Frequency. We consider a signal of 1000Hz so Fmax = 1000Hz
[b_audio,a_audio] = butter(4,[f_low_c f_high_c]/(Fs/2));
audio_data_filter = 10*smoothdata(filter(b_audio,a_audio,audio_data),'gaussians'); %Smoothening and Filtering the data
subplot(1,2,1);
plot(audio_data_filter);title("Using ButterWorth Filter");
subplot(1,2,2);
plot(f_axis,abs(fft(audio_data_filter)));title("Frequency Spectrum of Filtered Signal");
sound(audio_data_filter,Fs); %Plays the filtered sound

%Calculation of Distance of Pinger from hydrophones
