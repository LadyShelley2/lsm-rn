% U:用于预测未来时间片的时间片所对应的隐空间表示U，一般取最后一个时间片。

function G = predicting(U,B,A,step)
     G = U*A^step*B*(U*A^step)';
end