for i=1:3
    m(i,:,:)=rand(2,2);
end
squeeze(m(1,:,:))*[1,2;2,3]
