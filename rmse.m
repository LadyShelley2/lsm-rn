function res = rmse(prediction,base)
    count =  sum(sum(base>0));
    res =(base-prediction).^2;
    res(find(base==0))=0;
    res = sqrt(sum(sum(res))/count);
end