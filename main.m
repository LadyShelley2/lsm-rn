clc;clear;close all;
%%
% �������ȿ���һ������ݣ�������Ƕ��죬�����ļ�������Ҫ���޸�
%% 
startFileNum = 201610010610;
endFileNum = 201610010835;
interval = 5;
trainingCount = 25;
testingCount = 1;

trainingGs = [];
testingGs = [];
% splitFlag = 5; % �ָ�ѵ�����ݺͲ�������
% trainingSampleCounts = splitFlag;

for i=startFileNum:trainingCount-trainingCount-1
    
end
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
process(trainingGs,trainingYs,testingGs,testingYs);

%% Flow��������ʽ���и���ѵ�����Ͳ��Լ�

for i=currFileNum:interval:endFileNum-1*interval % �˴���ȥ1��Ϊ������һ�����԰���
    if(rem(i,100)>55)
        continue; % �ļ���Ϊ������
    end
    trainingGs = trainingGs(2:end,:,:);
    trainingYs = trainingYs(2:end,:,:);
    [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(i);
    [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(i);
    process(trainingGs,trainingYs,testingGs,testingYs)
end





