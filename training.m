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
    
%     predictionG = predicting(squeeze(trainingUs(trainingCount,:,:)),B,A,1);
%     errs=[errs evaluation2(predictionG,testingG)];
end
% plot(errs);
% title('误差变化图');
% figure;
% plot(values(3:end),'-b*');
% title('目标值收敛图');
end