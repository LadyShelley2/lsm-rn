function test_NextFileNum()
clc;
clear;
close all;
format long g;

startFileNum = 201709100910;
endFileNum = 201709101045;
interval = 5;
trainingCount = 12;

%%
% currFileNum = startFileNum;
% while(currFileNum<endFileNum)
% %     if(rem(currFileNum,100)>55)
% %         continue; % �ļ���Ϊ���������պ���Ҳ��Ҫ�޸�
% %     end
%     
%     currFileNum
%     nextFileNum(currFileNum,interval)
%     currFileNum=nextFileNum(currFileNum,interval);
%     display('-----------')
% end

%% 

% currFileNum = startFileNum;
% for i=1:trainingCount
%     trainingFileNums(i) = currFileNum;
%     currFileNum = nextFileNum(currFileNum,interval);
% end
% 
% trainingFileNums
% testingFIleNum = currFileNum

end