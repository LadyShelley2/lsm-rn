function fileNum=nextFileNum(currFileNum,interval)
    fileNum=currFileNum+interval;
    
    minute2hour=60;
    % ����ֺ�ʱ
    if(rem(fileNum,100)>=minute2hour)
        fileNum = ceil(fileNum/100)*100+rem(rem(fileNum,100),minute2hour);
    end
end