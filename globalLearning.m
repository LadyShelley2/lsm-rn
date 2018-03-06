function [NewUs,NewB,NewA]=globalLearning(Ys,Gs,Us,B,W,D,A,lambda,gamma)

T=size(Ys,1);
k=size(B,1);

%% update Us
NewUs(1,:,:)=Us(1,:,:);
NewUs(T,:,:)=Us(T,:,:);
for t=2:T-1   
    numer = (squeeze(Ys(t,:,:)).*squeeze(Gs(t,:,:)))*(squeeze(Us(t,:,:))*B'+squeeze(Us(t,:,:))*B)+lambda*W*squeeze(Us(t,:,:))+gamma*(squeeze(Us(t-1,:,:))*A+squeeze(Us(t+1,:,:))*A');
    denom = (squeeze(Ys(t,:,:)).* (squeeze(Us(t,:,:))*B*squeeze(Us(t,:,:))'))*(squeeze(Us(t,:,:))*B'+squeeze(Us(t,:,:))*B)+lambda*D*squeeze(Us(t,:,:))+gamma*(squeeze(Us(t,:,:))+squeeze(Us(t,:,:))*A*A');
%     size( squeeze(Us(t,:,:)).*((numer./denom).^(1.0/4)))
    NewUs(t,:,:) = squeeze(Us(t,:,:)).*((numer./denom).^(1.0/2)); 
    NewUs(t,find(denom==0))=0;
end
% NewUs(1,:,:)=Us(2,:,:);
% NewUs(T,:,:)=Us(T-1,:,:);
%% update B

numer = zeros(k,k);
denom = zeros(k,k);
for t=1:T
    numer = numer+squeeze(Us(t,:,:))'*(squeeze(Ys(t,:,:)).*squeeze(Gs(t,:,:)))*squeeze(Us(t,:,:));
    denom = denom+squeeze(Us(t,:,:))'*(squeeze(Ys(t,:,:)).*(squeeze(Us(t,:,:))*B*squeeze(Us(t,:,:))'))*squeeze(Us(t,:,:));
end
NewB = B.*(numer./denom);
NewB(find(denom==0))=0;


%% updateA

numer = 0;
denom = 0;
for t=2:T
    numer = numer + squeeze(Us(t-1,:,:))'*squeeze(Us(t,:,:));
    denom = denom + squeeze(Us(t-1,:,:))'*squeeze(Us(t-1,:,:))*A;
end
NewA = A.*(numer./denom);
NewA(find(denom==0))=0;

end