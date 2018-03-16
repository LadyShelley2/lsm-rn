% 画图观察各个路段随着时间变化流量变化趋势
clc;clear;close all;
data = load('D:\Github\matrix-fac\lsm-rn\visulization\output.txt');
for i=600:610
    plot(smooth(data(i,:))');
    hold on;
end
% 88-96之间上升趋势明显
% figure;
% plot(data(300:302,:)');
xlabel('时间片编号');
ylabel('流量值')
% plot(data(400:410,:)','-gs',...
%     'MarkerSize',10,...    
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5]);
% A=[1,2;2,3];
% plot(A);
