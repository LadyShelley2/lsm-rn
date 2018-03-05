clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
startFileNum = 201610010010;
endFileNum = 201610010835;
interval = 5;
trainingCount = 25;
testingCount = 1;

trainingGs = [];
testingGs = [];
% splitFlag = 5; % �ָ�ѵ�����ݺͲ�������
% trainingSampleCounts = splitFlag;

errs_prediction_mase=[];
errs_average_mase=[];

%% init data

for i=1:trainingCount
    currFileNum = startFileNum+i*interval;
    if(rem(currFileNum,100)>55)
        continue; % �ļ���Ϊ���������պ���Ҳ��Ҫ�޸�
    end
    [trainingGs(i,:,:),trainingYs(i,:,:)] = preProcess(currFileNum);
end
% �˴�ֻ����һ��ʱ��Ƭ��Ϊ���԰���
[testingGs(1,:,:),testingYs(1,:,:)]=preProcess(currFileNum);
[err_prediction_mase,err_average_mase]=process(trainingGs,trainingYs,testingGs,testingYs);
errs_prediction_mase=[errs_prediction_mase,err_prediction_mase];
errs_average_mase=[errs_average_mase,err_average_mase];
%% Flow��������ʽ���и���ѵ�����Ͳ��Լ�

for i=currFileNum:interval:endFileNum-1*interval % �˴���ȥ1��Ϊ������һ�����԰���
    if(rem(i,100)>55)
        continue; % �ļ���Ϊ������
    end
    trainingGs = trainingGs(2:end,:,:);
    trainingYs = trainingYs(2:end,:,:);
    [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(i);
    [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(i);
    [err_prediction_mase,err_average_mase]=process(trainingGs,trainingYs,testingGs,testingYs);
    errs_prediction_mase=[errs_prediction_mase,err_prediction_mase];
    errs_average_mase=[errs_average_mase,err_average_mase];
end

%% ���ӻ�
figure;
plot(errs_prediction_mase,'b');
hold on;
plot(errs_average_mase,'r');
legend('lsm-rn������','ƽ��ֵ������')


