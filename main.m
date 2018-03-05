clc;clear;close all;
%%
% 本程序先考虑一天的数据，如果考虑多天，读入文件部分需要再修改
%% 
startFileNum = 201610010610;
endFileNum = 201610010835;
interval = 5;
trainingCount = 25;
testingCount = 1;

trainingGs = [];
testingGs = [];
% splitFlag = 5; % 分割训练数据和测试数据
% trainingSampleCounts = splitFlag;

for i=startFileNum:trainingCount-trainingCount-1
    
end
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
process(trainingGs,trainingYs,testingGs,testingYs);

%% Flow：流的形式进行更新训练集和测试集

for i=currFileNum:interval:endFileNum-1*interval % 此处减去1是为了留出一个测试案例
    if(rem(i,100)>55)
        continue; % 文件名为非连续
    end
    trainingGs = trainingGs(2:end,:,:);
    trainingYs = trainingYs(2:end,:,:);
    [trainingGs(trainingCount,:,:),trainingYs(trainingCount,:,:)] = preProcess(i);
    [testingGs(1,:,:),testingYs(1,:,:)]=preProcess(i);
    process(trainingGs,trainingYs,testingGs,testingYs)
end





