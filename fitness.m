%function indiFit=fitness(x,y,newcityCoor,newcityDist)
function indiFit=fitness(x,newcityCoor,newcityDist)
%% �ú������ڼ��������Ӧ��ֵ
%x           input     ����
%cityCoor    input     ��������
%cityDist    input     ���о���
%indiFit     output    ������Ӧ��ֵ 
m=size(x,1);
n=size(newcityCoor,1);
indiFit=zeros(m,1);
for i=1:m
    for j=1:n-1
        indiFit(i)=indiFit(i)+newcityDist(x(i,j),x(i,j+1));
    end
      %  indiFit(i)=indiFit(i)+y(x(i,1),1)+y(x(i,n),2);
         indiFit(i)=indiFit(i)+newcityDist(x(i,1),x(i,n));   
end 
