% U:����Ԥ��δ��ʱ��Ƭ��ʱ��Ƭ����Ӧ�����ռ��ʾU��һ��ȡ���һ��ʱ��Ƭ��

function G = predicting(U,B,A,step)
     G = U*A^step*B*(U*A^step)';
end