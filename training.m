function [trainingUs,B,A]=training(trainingYs,trainingGs,trainingUs,B,L,W,D,A,lambda,gamma,iter)
%% training
trainingCount = size(trainingUs,1);
preGoalValue = 1e10;
values=[];
errs=[];
for i=1:iter 
    goalvalue = goalValue(trainingYs,trainingGs,trainingUs,B,L,A,lambda,gamma);
    values = [values goalvalue];
    preGoalValue=goalvalue;
    [trainingUs,B,A]=globalLearning2(trainingYs,trainingGs,trainingUs,B,W,D,A,lambda,gamma);
    
    % �������仯ͼ���㲿��
%     predictionG = predicting(squeeze(trainingUs(trainingCount,:,:)),B,A,1);
%     errs=[errs evaluation2(predictionG,testingG)];
    % �������仯ͼ���㲿��
end
% �������仯ͼ��ͼ����
% plot(errs);
% title('���仯ͼ');
% figure;
% �������仯ͼ��ͼ����

% plot(values(3:end),'-b*');
% title('Ŀ��ֵ����ͼ');
end