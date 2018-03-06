function res=mape(prediction,base)
    count =  sum(sum(base>0));
    res = abs((prediction-base)./base);
    res(find(base==0))=0;
    res = sum(sum(res))/count;
end