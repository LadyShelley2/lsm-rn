
% trainingGs: 输入训练数据快照
% trainingYs：输入训练数据快照对应指示矩阵
% testingGs: 输入测试数据快照
% testingYs: 测试数据对应指示矩阵
function process(trainingGs,trainingYs,testingGs,testingYs)
%% const params
k=30;
iter =50;
threshold = 1;
lambda = 4;
gamma = 1;
threshold = 0.01;

%% user params
[trainingCount,n,n]=size(trainingGs);
[testingCount,n,n]=size(testingGs);

%% prepare W, D, L ,Us, B, A
W=zeros(n,n);
for i=2:n
    W(i-1,i)=1;
end
D=zeros(n,n);
for i=1:n
    D(i,i)=sum(W(:,i));
end
L=D-W;

B = rand(k,k);
A = rand(k,k);
for i=1:trainingCount
    trainingUs(i,:,:) = rand(n,k);
end

%% training
[trainingUs,B,A]=training(trainingYs,trainingGs,trainingUs,B,L,W,D,A,lambda,gamma,iter);
predictionG = testing(squeeze(trainingUs(trainingCount,:,:)),B,A,1);
evaluation(predictionG,squeeze(testingGs(1,:,:)),squeeze(mean(trainingGs)));
end


