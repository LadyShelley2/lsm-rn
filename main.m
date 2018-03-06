clc;clear;close all;
%%
% 本程序先考虑一天的数据，如果考虑多天，读入文件部分需要再修改
%% 
startFileNum = 201709100910;
endFileNum = 201709101045;
interval = 5;
trainingCount = 5;
testingCount = 1;

trainingGs = [];
testingGs = [];
% splitFlag = 5; % 分割训练数据和测试数据
% trainingSampleCounts = splitFlag;

% 用于收集各项指标的数组
errs_prediction_mape=[];
errs_average_mape=[];
errs_prediction_mae=[];
errs_average_mae=[];
errs_prediction_rmse=[];
errs_average_rmse=[];
errs_prediction_nmae=[];
errs_average_nmae=[];

%% init data

for i=1:trainingCount
    currFileNum = startFileNum+i*interval;
    if(rem(currFileNum,100)>55)
        continue; % 文件名为非连续；日和月也需要修改
    end
    [trainingGs(i,:,:),trainingYs(i,:,:)] = preProcess(currFileNum);
end
% 此处只将下一个时间片作为测试案例
[testingGs(1,:,:),testingYs(1,:,:)]=preProcess(currFileNum);
[err_prediction_mape,err_average_mape]=process(trainingGs,trainingYs,testingGs,testingYs);
errs_prediction_mape=[errs_prediction_mape,err_prediction_mape];
errs_average_mape=[errs_average_mape,err_average_mape];

%% Flow：流的形式进行更新训练集和测试集

for i=currFileNum:interval:endFileNum-1*interval % 此处减去1是为了留出一个测试案例，如果测试多步，则需要更改
    if(rem(i,100)>55)
        continue; % 文件名为非连续
    end
    trainingGs = trainingGs(2:end,:,:);
    trainingYs = trainingYs(2:end,:,:);
    
    [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(i);
    [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(i);
    
    %% 收集各项指标
    
    [err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
    err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=process(trainingGs,trainingYs,testingGs,testingYs);
    
    errs_prediction_mape=[errs_prediction_mape,err_prediction_mape];
    errs_average_mape=[errs_average_mape,err_average_mape];
    
    errs_prediction_mae=[errs_prediction_mae,err_prediction_mae];
    errs_average_mae=[errs_average_mae,err_average_mae];
    
    errs_prediction_rmse=[errs_prediction_rmse,err_prediction_rmse];
    errs_average_rmse=[errs_average_rmse,err_average_rmse];
    
    errs_prediction_nmae=[errs_prediction_nmae,err_prediction_nmae];
    errs_average_nmae=[errs_average_nmae,err_average_nmae];
end

%% 可视化
figure;
plot(errs_prediction_mape,'b');
hold on;
plot(errs_average_mape,'r');
legend('lsm-rn错误率','平均值错误率')



