% ���˲�������ݽ���ʵ�飺��output�е����ݽ����˲�����Ȼ�󱣴浽output_smooth.txt,����java��������׼�������ƵĿ����ļ�
clc;clear;close all;
data = load('D:\Github\matrix-fac\lsm-rn\visulization\output.txt');
[m,n]=size(data);

for i=1:m
smoothMatrix(i,:)=smooth(data(i,:));
end


dlmwrite('D:\Github\matrix-fac\lsm-rn\visulization\output_smooth.txt',smoothMatrix,'delimiter','\t');