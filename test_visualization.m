% ��ͼ�۲����·������ʱ��仯�����仯����
clc;clear;close all;
data = load('D:\Github\matrix-fac\lsm-rn\visulization\output.txt');
for i=600:610
    plot(smooth(data(i,:))');
    hold on;
end
% 88-96֮��������������
% figure;
% plot(data(300:302,:)');
xlabel('ʱ��Ƭ���');
ylabel('����ֵ')
% plot(data(400:410,:)','-gs',...
%     'MarkerSize',10,...    
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5]);
% A=[1,2;2,3];
% plot(A);
