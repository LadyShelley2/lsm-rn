function test_main
    clc;clear;close all;
    
    baseUrl='D:\Github\matrix-fac\lsm-rn\test_data\test_steady\';
    repeatCount = 10; % 实验重复做的次数
    startNum =1;
    endNum = 8;
    trainingCount = 6;
    testingCount = 1;

    trainingGs = [];
    testingG = [];
    
    for i=startNum:endNum-1
        G=load([baseUrl num2str(i) '.txt']);
        Y = zeros(size(G));
        Y(find(G>0))=1;
        trainingGs(i,:,:)=G;
        trainingYs(i,:,:)=Y;
    end
    
    testingG = load([baseUrl num2str(endNum) '.txt']);
    testingGs(1,:,:)= testingG ;
    testingY=zeros(size(testingG));
    testingYs(1,:,:)= testingY ;
    W=load([baseUrl 'W.txt']);
    
    [err_prediction_mape,err_average_mape,err_prediction_mae,err_average_mae,...
    err_prediction_rmse,err_average_rmse,err_prediction_nmae,err_average_nmae]=process(trainingGs,trainingYs,testingGs,testingYs,W)
    
end