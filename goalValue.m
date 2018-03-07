function sum=goalValue(Ys,Gs,Us,B,L,A,lambda,gamma)
[T,n,n]=size(Ys);
sum1=0;
sum2 =0;
sum3 =0;

for t=1:T
    squeezeYst = squeeze(Ys(t,:,:));
    squeezeGst = squeeze(Gs(t,:,:));
    squeezeUst = squeeze(Us(t,:,:));
    sum1 = sum1 + norm(squeezeYst.*(squeezeGst-squeezeUst*B*squeezeUst'),2)^2;
end

for t=1:T
    squeezeYst = squeeze(Ys(t,:,:));
    squeezeGst = squeeze(Gs(t,:,:));
    squeezeUst = squeeze(Us(t,:,:));
    sum2 = sum2 + lambda*trace(squeezeUst'*L*squeezeUst);
end

for t=2:T
    sum3 = sum3+gamma*norm(squeeze(Us(t,:,:))-squeeze(Us(t-1,:,:))*A,2)^2;
end

sum=sum1+sum2+sum3;

% for t=1:T
%     squeezeYst = squeeze(Ys(t,:,:));
%     squeezeGst = squeeze(Gs(t,:,:));
%     squeezeUst = squeeze(Us(t,:,:));
%     sum = sum + norm(squeezeYst.*(squeezeGst-squeezeUst*B*squeezeUst'),2)^2;
%     sum = sum + lambda*trace(squeezeUst'*L*squeezeUst);
% end
% 
% for t=2:T
%     sum = sum+gamma*norm(squeeze(Us(t,:,:))-squeeze(Us(t-1,:,:))*A,2)^2;
% end

end