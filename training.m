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
    
    % 绘制误差变化图计算部分
%     predictionG = predicting(squeeze(trainingUs(trainingCount,:,:)),B,A,1);
%     errs=[errs evaluation2(predictionG,testingG)];
    % 绘制误差变化图计算部分
end
% 绘制误差变化图绘图部分
% plot(errs);
% title('误差变化图');
% figure;
% 绘制误差变化图绘图部分

% plot(values(3:end),'-b*');
% title('目标值收敛图');
end