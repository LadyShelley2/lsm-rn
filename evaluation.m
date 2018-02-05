%% evaluation
clc;clear;close all;

Gs = importdata('Gs.mat');
Us = importdata('Us.mat');
B = importdata('B.mat');
D = importdata('D.mat');


err=0;
size = size(Gs);
T=size(1);
n=size(2);
for i=1:T
    prediction = squeeze(Us(i,:,:))*B*squeeze(Us(i,:,:))';
    diff = abs(squeeze(Gs(i,:,:))-prediction);
%     prediction(find(squeeze(Gs(i,:,:))>0))
    tmp = diff./squeeze(Gs(i,:,:));
    tmp(find(squeeze(Gs(i,:,:))==0))=0;
    err = err + sum(sum(tmp))
end
err/(T*sum(sum(D)))

%% visualization

speed_prediction = 0;
speed_base = 0;
for i=2:n
    speed_prediction = [speed_prediction prediction(i,i-1)];
    speed_base = [speed_base Gs(4,i,i-1)];
end
plot(speed_prediction);
figure;
plot(speed_base,'r')