% 用滤波后的数据进行实验：对output中的数据进行滤波处理然后保存到output_smooth.txt,再用java处理成与标准输入类似的快照文件
clc;clear;close all;
data = load('D:\Github\matrix-fac\lsm-rn\visulization\output.txt');
[m,n]=size(data);

for i=1:m
smoothMatrix(i,:)=smooth(data(i,:));
end


dlmwrite('D:\Github\matrix-fac\lsm-rn\visulization\output_smooth.txt',smoothMatrix,'delimiter','\t');