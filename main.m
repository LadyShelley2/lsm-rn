clc;clear;close all;

startFileNum = 201610010835;
endFileNum = 201610010855;
interval = 5;

for i=201610010835:interval:201610010855
    snapshots((i-startFileNum)/interval + 1,:,:)=load([num2str(i) 'out.txt']);
end

%% params

size= size(snapshots);
T=size(1);
n=size(2);
k=20;
iter =50;
threshold = 10;
lambda = 2;
gamma = 2;

%% prepare W, D, L ,Ys, Us, B, A

W=zeros(n,n);
for i=2:n
    W(i-1,i)=1;
end

D=zeros(n,n);
for i=1:n
    D(i,i)=sum(W(:,i));
end

L=D-W;

for i=1:T
    Ys(i,:,:)=zeros(n,n);
    Ys(i,find(snapshots(i,:,:)>0))=1;
end

Gs=snapshots;
B = rand(k,k);
A = rand(k,k);
for i=1:T
    Us(i,:,:) = rand(n,k);
end
%% training
preGoalValue = 1e10;
values=[];
for i=1:iter
    goalvalue = goalValue(Ys,Gs,Us,B,L,A,lambda,gamma)
    values = [values goalvalue];
%     if(goalvalue>preGoalValue) break;
%     end
%     preGoalValue=goalvalue;
    [Us,B,A]=globalLearning(Ys,Gs,Us,B,W,D,A,lambda,gamma);
end

%% evaluation

err=0;
for i=1:T
    prediction = squeeze(Us(i,:,:))*B*squeeze(Us(i,:,:))';
    tmp = abs(squeeze(Gs(i,:,:))-prediction)./squeeze(Gs(i,:,:));
    tmp(find(squeeze(Gs(i,:,:))==0))=0;
    
    if(i~=1&&i~=T)
        speed_prediction = 0;
        speed_base = 0;
        
        % 找到图
        for j=2:n
            speed_prediction = [speed_prediction prediction(j,j-1)];
            speed_base = [speed_base Gs(i,j,j-1)];
        end

        plot(speed_prediction)
        title(['预测' num2str(i)]);
        figure;

        plot(speed_base);
        title(['实际值' num2str(i)]);
        figure;
        
        err = err + sum(sum(tmp));
    end
end
err/((T-2)*sum(sum(D)))

%% visualization

% speed_prediction = 0;
% speed_base = 0;
% for i=2:n
%     speed_prediction = [speed_prediction prediction(i,i-1)];
%     speed_base = [speed_base Gs(4,i,i-1)];
% end
% plot(speed_prediction);
% figure;
% plot(speed_base,'r')
% figure;
% plot(values);

