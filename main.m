clc;clear;close all;
%%
% 本程序先考虑一天的数据，如果考虑多天，读入文件部分需要再修改
%% 
repeatCount = 10; % 实验重复做的次数
startFileNum = 201709100620;
endFileNum = 201709100850;
interval = 5;
trainingCount = 24;
testingCount = 1;
path = 'D:\data\test_20170910_sample\';

trainingGs = [];
testingGs = [];
%% init data
testingLabels = [];
currFileNum = startFileNum;
for i=1:trainingCount
    if(rem(currFileNum,100)>55)
        continue; % 文件名为非连续；日和月也需要修改
    end
    [trainingGs(i,:,:),trainingYs(i,:,:)] = preProcess(currFileNum,path);
    currFileNum = nextFileNum(currFileNum,interval);
end

n = size(trainingGs,2);
W=zeros(n,n);
for i=2:n
    W(i-1,i)=1;
    W(i,i-1)=1;
end

% 此处只将下一个时间片作为测试案例
[testingGs(1,:,:),testingYs(1,:,:)]=preProcess(currFileNum,path); %当前currFileNum 刚好是训练数据的下一个。
testingLabels = [testingLabels,currFileNum];

% 获得各项指标
errs=nmf_alg(trainingGs,trainingYs,testingGs,testingYs,W);

%% Flow：流的形式进行更新训练集和测试集

% while currFileNum<endFileNum % 留出一个测试案例，如果测试多步，则需要更改    
%     % 将训练数据整体向前移动一位，并将新的一行添加至尾部
%     trainingGs = trainingGs(2:end,:,:);
%     trainingYs = trainingYs(2:end,:,:);
%     
%     [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(currFileNum);
%     [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(nextFileNum(currFileNum,interval)); %当前测试数据的坐标
%     testingLabels = [testingLabels,currFileNum];
%     currFileNum=nextFileNum(currFileNum,interval);
%     
%     %% 收集各项指标    
%     [err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
%     err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=process(trainingGs,trainingYs,testingGs,testingYs,W);
%     
%     errs_prediction_mape=[errs_prediction_mape,err_prediction_mape];
%     errs_average_mape=[errs_average_mape,err_average_mape];
%     
%     errs_prediction_mae=[errs_prediction_mae,err_prediction_mae];
%     errs_average_mae=[errs_average_mae,err_average_mae];
%     
%     errs_prediction_rmse=[errs_prediction_rmse,err_prediction_rmse];
%     errs_average_rmse=[errs_average_rmse,err_average_rmse];
%     
%     errs_prediction_nmae=[errs_prediction_nmae,err_prediction_nmae];
%     errs_average_nmae=[errs_average_nmae,err_average_nmae];
% end

%% 可视化
% figure;
% plot(errs_prediction_mape,'b');
% n=size(testingLabels,2);
% % labels = cell(1,n);
% % for i=1:n
% %     str=num2str(testingLabels(i));
% %     str(9:12)
% %     labels{1,i}=str(9:12);
% % end
% % ax=gca;
% % ax.XTickLabel=labels;
% 
% hold on;
% plot(errs_average_mape,'r');
% legend('lsm-rn错误率','平均值错误率')
% title('mape');