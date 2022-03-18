%Pitch Changing System Algorithm
[audioData,s] = audioread("D:\zakir\Documents\Sound recordings\Recording.m4a");
%soundsc(audioData,s);
figure(1)
plot(audioData);title("Sound Input Waveform");

figure(2)
subplot(1,2,1);
f10 = pitch(audioData,s);
plot(f10);title("Pitch Waveform before Shifting");
audio_change = smooth(shiftPitch(audioData,-5));
f11 = pitch(audio_change,s);
subplot(1,2,2);
plot(f11);title("Pitch waveform after Shifting");

figure(3)
plot(audio_change);title("New Waveform after changing Pitch and smoothening");
%soundsc(audio_change,s);
