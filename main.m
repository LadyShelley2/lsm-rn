clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
repeatCount = 10; % ʵ���ظ����Ĵ���
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
        continue; % �ļ���Ϊ���������պ���Ҳ��Ҫ�޸�
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

% �˴�ֻ����һ��ʱ��Ƭ��Ϊ���԰���
[testingGs(1,:,:),testingYs(1,:,:)]=preProcess(currFileNum,path); %��ǰcurrFileNum �պ���ѵ�����ݵ���һ����
testingLabels = [testingLabels,currFileNum];

% ��ø���ָ��
errs=nmf_alg(trainingGs,trainingYs,testingGs,testingYs,W);

%% Flow��������ʽ���и���ѵ�����Ͳ��Լ�

% while currFileNum<endFileNum % ����һ�����԰�����������Զಽ������Ҫ����    
%     % ��ѵ������������ǰ�ƶ�һλ�������µ�һ�������β��
%     trainingGs = trainingGs(2:end,:,:);
%     trainingYs = trainingYs(2:end,:,:);
%     
%     [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(currFileNum);
%     [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(nextFileNum(currFileNum,interval)); %��ǰ�������ݵ�����
%     testingLabels = [testingLabels,currFileNum];
%     currFileNum=nextFileNum(currFileNum,interval);
%     
%     %% �ռ�����ָ��    
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

%% ���ӻ�
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
% legend('lsm-rn������','ƽ��ֵ������')
% title('mape');