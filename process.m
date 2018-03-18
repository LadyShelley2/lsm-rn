
% trainingGs: 输入训练数据快照
% trainingYs：输入训练数据快照对应指示矩阵
% testingGs: 输入测试数据快照
% testingYs: 测试数据对应指示矩阵
function errs=process(trainingGs,trainingYs,testingGs,testingYs,W,varargin)


[k,iter,lambda,gamma] = parse_opt(varargin, 'k', 20, 'iter', 50, ...
                                              'lambda',1,'gamma',1);


%% user params
[trainingCount,n,n]=size(trainingGs);
[testingCount,n,n]=size(testingGs);

%% prepare W, D, L ,Us, B, A

D=zeros(n,n);
for i=1:n
    D(i,i)=sum(W(:,i));
end
L=D-W;

B = rand(k,k);
A = rand(k,k);
for i=1:trainingCount
    trainingUs(i,:,:) = rand(n,k);
    trainingUs(find(trainingUs==0))=0.1;
end
%% training
[trainingUs,B,A]=training(trainingYs,trainingGs,trainingUs,B,L,W,D,A,lambda,gamma,iter);
predictionG = predicting(squeeze(trainingUs(trainingCount,:,:)),B,A,1);

% 测试权重叠加前几步预测结果
% predictionG1 = predicting(squeeze(trainingUs(trainingCount-1,:,:)),B,A,2);
% predictionG2 = predicting(squeeze(trainingUs(trainingCount-2,:,:)),B,A,3);

errs=evaluation(predictionG,squeeze(testingGs(1,:,:)),squeeze(mean(trainingGs)));
end


