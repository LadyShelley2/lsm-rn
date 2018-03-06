function res=nmae(prediction,base)
     count = sum(sum(base>0));
     mae = abs(prediction-base);
     mae(find(base==0))=0;
     res = sum(sum(mae))/sum(sum(base));
end