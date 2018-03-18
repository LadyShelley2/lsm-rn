clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
repeatCount = 10; % ʵ���ظ����Ĵ���
startFileNum = 201709100620;
endFileNum = 201709100850; %�������ķ�ʽ��ȡʱ�����õ�

% ��ʼ������
% [trainingGs,trainingYs,testingGs,testingYs,W]=init_data(startFileNum,ntrain);

ntrains=[12];
for i=1:length(ntrains)
    tic
    [trainingGs,trainingYs,testingGs,testingYs,W]=init_data(startFileNum,'ntrain',ntrains(i),'path','D:\data\test_20170910_smooth\');
    errs_ntrain(i,:)=process(trainingGs,trainingYs,testingGs,testingYs,W);
    toc;
end
errs_ntrain

% ���Ч����õ�����µ������seed
index=nmf_seed(trainingGs,trainingYs,testingGs,testingYs,W);

lambdas=[0.5,2,4,8];
errs_lambda=[];
for i=1:length(lambdas)
    tic;
    errs_lambda(i,:)=process(trainingGs,trainingYs,testingGs,testingYs,W,'lambda',lambdas(i),'seed',index);
    toc;
end

errs_lambda

gammas=[0.5,2,4,8];
errs_gamma=[];
for i=1:length(gammas)
    tic;
    errs_gamma(i,:)=process(trainingGs,trainingYs,testingGs,testingYs,W,'gamma',gammas(i),'seed',index);
    toc;
end

ks=[5,10,15,20];
errs_k=[];
for i=1:length(gammas)
    tic;
    errs_k(i,:)=process(trainingGs,trainingYs,testingGs,testingYs,W,'k',ks(i),'seed',index);
    toc;
end
errs_k



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