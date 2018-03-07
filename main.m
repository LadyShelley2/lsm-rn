clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
startFileNum = 201709100910;
endFileNum = 201709101045;
interval = 5;
trainingCount = 12;
testingCount = 1;

trainingGs = [];
testingGs = [];

% �����ռ�����ָ�������
errs_prediction_mape=[];
errs_average_mape=[];

errs_prediction_mae=[];
errs_average_mae=[];

errs_prediction_rmse=[];
errs_average_rmse=[];

errs_prediction_nmae=[];
errs_average_nmae=[];

%% init data
currFileNum = startFileNum;
for i=1:trainingCount
    if(rem(currFileNum,100)>55)
        continue; % �ļ���Ϊ���������պ���Ҳ��Ҫ�޸�
    end
    [trainingGs(i,:,:),trainingYs(i,:,:)] = preProcess(currFileNum);
    currFileNum = nextFileNum(currFileNum,interval);
end

% �˴�ֻ����һ��ʱ��Ƭ��Ϊ���԰���
[testingGs(1,:,:),testingYs(1,:,:)]=preProcess(currFileNum); %��ǰcurrFileNum �պ���ѵ�����ݵ���һ����

% ��ø���ָ��
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

%% Flow��������ʽ���и���ѵ�����Ͳ��Լ�

while currFileNum<endFileNum % ����һ�����԰�����������Զಽ������Ҫ����
    
    % ��ѵ������������ǰ�ƶ�һλ�������µ�һ�������β��
    trainingGs = trainingGs(2:end,:,:);
    trainingYs = trainingYs(2:end,:,:);
    
    [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(currFileNum);
    [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(nextFileNum(currFileNum,interval)); %��ǰ�������ݵ�����
    currFileNum=nextFileNum(currFileNum,interval);
    
    %% �ռ�����ָ��
    
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

%% ���ӻ�
figure;
plot(errs_prediction_mape,'b');
hold on;
plot(errs_average_mape,'r');
legend('lsm-rn������','ƽ��ֵ������')
title('mape');



