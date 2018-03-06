function sum=goalValue(Ys,Gs,Us,B,L,A,lambda,gamma)
[T,n,n]=size(Ys);
sum=0;
for t=1:T
    squeezeYst = squeeze(Ys(t,:,:));
    squeezeGst = squeeze(Gs(t,:,:));
    squeezeUst = squeeze(Us(t,:,:));
    sum = sum + norm(squeezeYst.*(squeezeGst-squeezeUst*B*squeezeUst'),2);
    sum = sum + lambda*trace(squeezeUst'*L*squeezeUst);
end

for t=2:T
    sum = sum+gamma*norm(squeeze(Us(t,:,:))-squeeze(Us(t-1,:,:))*A,2);
end

end