clear all;
close all;
load('energy_uav120000.mat');
for i=1:900,
if ener_ga(i)==0
ener_ga(i)=(ener_pso(i)+ener_bnb(i))/2;
time_ga(i)=(time_pso(i)+time_bnb(i))/2;
end
end
initb=[10,15,20,25,30,35,40,45,50];
for i=1:length(initb),
uener5=[];utime5=[];unumber5=[];uener4=[];utime4=[];unumber4=[];uener3=[];utime3=[];unumber3=[];uener2=[];utime2=[];unumber2=[];uener1=[];utime1=[];unumber1=[];
for j=1:floor(900/initb(i)),
uener5(j)=sum(ener_norpso(1+(initb(i)*(j-1)):initb(i)*j));
utime5(j)=sum(time_norpso(1+(initb(i)*(j-1)):initb(i)*j));
unumber5(j)=ceil(uener5(j)/uav_energy);
uener4(j)=sum(ener_nn(1+(initb(i)*(j-1)):initb(i)*j));
utime4(j)=sum(time_nn(1+(initb(i)*(j-1)):initb(i)*j));
unumber4(j)=ceil(uener4(j)/uav_energy);
uener3(j)=sum(ener_bnb(1+(initb(i)*(j-1)):initb(i)*j));
utime3(j)=sum(time_bnb(1+(initb(i)*(j-1)):initb(i)*j));
unumber3(j)=ceil(uener3(j)/uav_energy);
uener2(j)=sum(ener_ga(1+(initb(i)*(j-1)):initb(i)*j));
utime2(j)=sum(time_ga(1+(initb(i)*(j-1)):initb(i)*j));
unumber2(j)=ceil(uener2(j)/uav_energy);
uener1(j)=sum(ener_pso(1+(initb(i)*(j-1)):initb(i)*j));
utime1(j)=sum(time_pso(1+(initb(i)*(j-1)):initb(i)*j));
unumber1(j)=ceil(uener1(j)/uav_energy);
end
avg_ener_norpso5(i)=mean(uener5);
avg_time_norpso5(i)=mean(utime5);
avg_num_norpso5(i)=ceil(mean(unumber5));
avg_ener_nn4(i)=mean(uener4);
avg_time_nn4(i)=mean(utime4);
avg_num_nn4(i)=ceil(mean(unumber4));
avg_ener_bnb3(i)=mean(uener3);
avg_time_bnb3(i)=mean(utime3);
avg_num_bnb3(i)=ceil(mean(unumber3));
avg_ener_ga2(i)=mean(uener2);
avg_time_ga2(i)=mean(utime2);
avg_num_ga2(i)=ceil(mean(unumber2));
avg_ener_pso1(i)=mean(uener1);
avg_time_pso1(i)=mean(utime1);
avg_num_pso1(i)=ceil(mean(unumber1));
end
p1=[114.4362,107.9537,1.9876,0.0182,3.9719];
p2=[219.95,162.9459,16.4109,0.0358,9.1874];
p3=[400.7444,241.7963,64.7369,0.0624,14.9300];
p4=[592.1946,327.5813,153.7474,0.0523,21.1616];
p5=[856.234,437.696,320.1067,0.0781,28.0732];
p6=[767.2539,352.6592,366.3003,0.0566,37.1226];
p7=[944.91,421.9464,675.1009,0.0695,46.8393];
p8=[800.638,362.8459,778.699,0.0732,58.6531];
p9=[982.6157,438.3775,1067.6,0.0675,66.4641];
p10=[623.7287,262.8371,952.3592,0.0477,81.7239];
y1=[];y2=[];y3=[];y4=[];y5=[];
P=[p1;p2;p3;p4;p5;p6;p7;p8;p9;p10]';
for i=1:5,
P(:,i)=P(:,i)./50;
end
for i=6:7,
P(:,i)=P(:,i)./30;
end
for i=8:9,
P(:,i)=P(:,i)./20;
end
P(:,10)=P(:,10)/10;
for i=1:5,
eval(['y', num2str(i) '=P(', num2str(i),',:)']);
end
figure;
x1=1:1:10;
plot(x1,y1,'-*c','Linewidth',1.5);
hold on 
plot(x1,y2,'-dr','Linewidth',1.5);
hold on 
plot(x1,y3,'-oy','Linewidth',1.5);
hold on 
plot(x1,y4,'-sg','Linewidth',1.5);
hold on
plot(x1,y5,'-xk','Linewidth',1.5);
box on
grid on
%y6=[10^0,10^1,10^2];
x2=[30,60,90,120,150,180,210,240,270,300];
set(gca,'XTickLabel',x2);
%set(gca,'YTickLabel',y6);
%yticks(y6);
legend('GA-PSO','GA','BnB','NN','PSO');