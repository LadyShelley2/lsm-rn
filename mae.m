% sparse matrix
function res = mae(prediction,base)
    count = sum(sum(base>0));
    res = abs(prediction-base);
    res(find(base==0))=0;
    res=sum(sum(res))/count;
end