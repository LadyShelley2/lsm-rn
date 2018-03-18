function [NewUs,NewB,NewA]=globalLearning2(Ys,Gs,Us,B,W,D,A,lambda,gamma)
    [T,n,n]=size(Ys);
    k=size(B,1);
    
    %% update Us
    for i=1:T
        U = squeeze(Us(i,:,:));
        Y=squeeze(Ys(i,:,:));
        G=squeeze(Gs(i,:,:));
        
        if i==1
            numer = (Y.*G)*U*B'+(Y'.*G')*U*B+lambda*W*U+gamma*(squeeze(Us(i+1,:,:))*A');
            denom = (Y.*(U*B*U'))*(U*B'+U*B)+lambda*D*U+gamma*(U*A*A');
            NewUs(i,:,:)=U.*((numer./denom).^(1.0/4));
            NewUs(i,find(denom==0))=0;
        elseif i==T
            numer = (Y.*G)*U*B'+(Y'.*G')*U*B+lambda*W*U+gamma*(squeeze(Us(i-1,:,:))*A);
            denom = (Y.*(U*B*U'))*(U*B'+U*B)+lambda*D*U+gamma*(U);
            NewUs(i,:,:)=U.*((numer./denom).^(1.0/4));
            NewUs(i,find(denom==0))=0;
        else
            numer = (Y.*G)*U*B'+(Y'.*G')*U*B+lambda*W*U+gamma*(squeeze(Us(i-1,:,:))*A+squeeze(Us(i+1,:,:))*A');
            denom = (Y.*(U*B*U'))*(U*B'+U*B)+lambda*D*U+gamma*(U+U*A*A');
            NewUs(i,:,:)=U.*((numer./denom).^(1.0/4));
            NewUs(i,find(denom==0))=0;
        end
    end
    %% Update B
    numer = zeros(k,k);
    denom = zeros(k,k);
    
    for i=1:T
        U = squeeze(Us(i,:,:));
        Y = squeeze(Ys(i,:,:));
        G = squeeze(Gs(i,:,:));
        
        numer = numer + U'*(Y.*G)*U;
        denom = denom + U'*(Y.*(U*B*U'))*U;
    end
    NewB=B.*(numer./denom);
    
    %% Update A
    
    numer = zeros(k,k);
    denom = zeros(k,k);
    
    for i=2:T        
        numer = numer+squeeze(Us(i-1,:,:))'*squeeze(Us(i,:,:));
        denom = denom+squeeze(Us(i-1,:,:))'*squeeze(Us(i-1,:,:))*A;
    end
    
    NewA = A.*(numer./denom) ;
end