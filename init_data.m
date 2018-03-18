function [trainingGs,trainingYs,testingGs,testingYs,W]=init_data(startFileNum,ntrain,varargin)
[ntest,interval,path] = parse_opt(varargin, 'ntest',1, ...
                                              'interval', 5,'path','D:\data\test_20170910_sample\');
                                          
trainingGs = [];
testingGs = [];
%% init data
currFileNum = startFileNum;
for i=1:ntrain
    [trainingGs(i,:,:),trainingYs(i,:,:)] = preProcess(currFileNum,path);
    currFileNum = nextFileNum(currFileNum,interval);
end

% 生成W
n = size(trainingGs,2);
W=zeros(n,n);
for i=2:n
    W(i-1,i)=1;
    W(i,i-1)=1;
end

% 此处只将下一个时间片作为测试案例
for i=1:ntest    
    [testingGs(i,:,:),testingYs(i,:,:)]=preProcess(currFileNum,path); %当前currFileNum 刚好是训练数据的下一个。
    currFileNum = nextFileNum(currFileNum,interval);
end
end