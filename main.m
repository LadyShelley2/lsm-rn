clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
repeatCount = 10; % ʵ���ظ����Ĵ���
startFileNum = 201709100620;
endFileNum = 201709100850;
interval = 5;
ntrain = 24;
ntest = 1;
path = 'D:\data\test_20170910_sample\';

% ��ʼ������
[trainingGs,trainingYs,testingGs,testingYs,W]=init_data(startFileNum,ntrain);


% ���Ч����õ�����µ������seed
index=nmf_seed(trainingGs,trainingYs,testingGs,testingYs,W);

lambdas=[0.5,2,4,8];
figure;
errs_arr=[];
for i=1:length(lambdas)
    tic;
    errs_arr(i,:)=process(trainingGs,trainingYs,testingGs,testingYs,W,'lambda',lambdas(i),'seed',index);
    toc;
end

errs_arr
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