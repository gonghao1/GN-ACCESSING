%function indiFit=fitness(x,y,newcityCoor,newcityDist)
function indiFit=fitness(x,newcityCoor,newcityDist)
%% 该函数用于计算个体适应度值
%x           input     个体
%cityCoor    input     城市坐标
%cityDist    input     城市距离
%indiFit     output    个体适应度值 
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
