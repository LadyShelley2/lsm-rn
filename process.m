
% trainingGs: 输入训练数据快照
% trainingYs：输入训练数据快照对应指示矩阵
% testingGs: 输入测试数据快照
% testingYs: 测试数据对应指示矩阵
function [err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
    err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=process(trainingGs,trainingYs,testingGs,testingYs)

%% const params
k=5;
iter =50;
threshold = 1;
lambda = 10;
gamma = 1;
threshold = 0.01;

%% user params
[trainingCount,n,n]=size(trainingGs);
[testingCount,n,n]=size(testingGs);

%% prepare W, D, L ,Us, B, A
W=zeros(n,n);
for i=2:n
    W(i-1,i)=1;
    W(i,i-1)=1;
end
D=zeros(n,n);
for i=1:n
    D(i,i)=sum(W(:,i));
end
L=D-W;

B = rand(k,k);
A = rand(k,k);
for i=1:trainingCount
    trainingUs(i,:,:) = rand(n,k);
    trainingUs(find(trainingUs==0))=0.1;
end
%% training
[trainingUs,B,A]=training(trainingYs,trainingGs,trainingUs,B,L,W,D,A,lambda,gamma,iter);
predictionG = predicting(squeeze(trainingUs(trainingCount,:,:)),B,A,1);
% 测试权重叠加前几步预测结果
predictionG1 = predicting(squeeze(trainingUs(trainingCount-1,:,:)),B,A,2);
predictionG2 = predicting(squeeze(trainingUs(trainingCount-2,:,:)),B,A,3);

[err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
    err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=evaluation((predictionG1+predictionG)/2,squeeze(testingGs(1,:,:)),squeeze(mean(trainingGs)));
end


