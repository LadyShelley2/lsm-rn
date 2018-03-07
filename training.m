function [trainingUs,B,A]=training(trainingYs,trainingGs,trainingUs,B,L,W,D,A,lambda,gamma,iter)
%% training
preGoalValue = 1e10;
values=[];
for i=1:iter 
    goalvalue = goalValue(trainingYs,trainingGs,trainingUs,B,L,A,lambda,gamma);
    values = [values goalvalue];
%     if(abs(goalvalue-preGoalValue)<threshold) 
%         break;
%     end
    preGoalValue=goalvalue;
    [trainingUs,B,A]=globalLearning(trainingYs,trainingGs,trainingUs,B,W,D,A,lambda,gamma);
end
plot(values(2:end),'-b*');
end