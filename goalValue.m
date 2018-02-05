function sum=goalValue(Ys,Gs,Us,B,L,A,lambda,gamma)
[T,n,n]=size(Ys);
sum=0;
for t=1:T
    sum = sum + norm(Ys(t).*(Gs(t)-Us(t)*B*Us(t)'),2);
    sum = sum + lambda*trace(Us(t)*L*Us(t)');
end

for t=2:T
    sum = sum+gamma*norm(Us(t)-Us(t-1)*A,2);
end

end