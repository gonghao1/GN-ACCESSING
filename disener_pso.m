close all;
clear all;
clc

%% 下载数据
%data=load('eil51.txt');
data=load('node.txt');
cityCoor=[data(:,2) data(:,3) data(:,4)];
cities=[data(:,2) data(:,3) data(:,4)]%城市坐标矩阵
maxGEN = 1000;
popSize = 200; % 遗传算法种群大小
crossoverProbabilty = 0.9; %交叉概率
mutationProbabilty = 0.1; %变异概率
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gbest = Inf;
%% 图
figure
plot(cityCoor(:,1),cityCoor(:,2),'ms','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g')
legend('城市位置')
%ylim([4 78])
title('城市分布图','fontsize',12)
xlabel('m','fontsize',12)
ylabel('m','fontsize',12)
%ylim([min(cityCoor(:,2))-1 max(cityCoor(:,2))+1])

grid on

uav_energy=200000;
%% 计算城市间距离
%n=size(cityCoor,1);            %城市数目
%cityDist=zeros(n,n);           %城市距离矩阵
%% 
% for i=1:n
%     for j=1:n
%         if i~=j
%             cityDist(i,j)=((cityCoor(i,1)-cityCoor(j,1))^2+...
%                 (cityCoor(i,2)-cityCoor(j,2))^2)^0.5;
%         end
%         cityDist(j,i)=cityDist(i,j);
%     end
% end
cityDist=[0,16391.1,21209,11571,6751.2,16401.5,4939.21,26026.4,8669.04,35669.7,5957.64,25367,27495.6,7711.25,45322.2,23643.1,5659.98,31796.1,7444.93,17843.1,14300.2,14309.7,45348.2,10024.7,36647.7;
    5549.16,0,4825.9,1633.28,3264.21,1772.11,3917.06,9644.1,2611.37,19289.1,3657.02,9256.46,11351.6,2937.8,28923.9,7394.81,4919.93,15429.2,3450.3,5087.57,8285.66,8007.26,29397.3,12926.77,20260.4;
    7181.27,1632.11,0,3264.21,4896.32,1632.12,5549.16,4822.51,4243.48,14851.8,5222.74,5921.3,6657.26,4569.9,24121.9,4012.79,6605.14,10607.4,4897.6,1218.58,2527.8,2527.85,24125.2,4117.46,15764.3;
    3917.06,4824.83,9643.93,0,1632.11,4952.29,2284.95,14466.8,1014.62,24123.2,1958.53,14086.3,15914.8,1361.58,33744.5,12053.7,3314.51,20249.4,2642.09,6269.99,4976.8,6490.07,33758.4,12055.63,25076.2;
    2294.64,9642.01,14472,4816.07,0,9648.91,840.97,19298.5,2234.44,28926.1,362.783,18613.7,20731.5,1747.26,39624.8,16887.4,2558.96,25083.1,6845.01,11110.6,7427.36,7228.47,38587.9,12115.60,29909;
    5549.16,1772.11,4823.79,1652.2,3264.21,0,3917.06,9647.56,2611.37,19284.3,3590.64,9285.48,11115.5,2937.79,28939.9,7259.39,4899.25,15430.3,3302.77,3237.07,6470.84,5786.36,28906.9,10775.07,20243.5;
    1635.57,11579.1,16386.3,6756.84,1961.89,11569.9,0,21239.9,3857.9,30862.7,1584.03,21073.6,22670.7,3350.72,40526.5,18801.8,10438.58,27013.8,10683.53,13028.9,9175.55,9155.5,40531.6,3923.3,31826;
    8813.38,3264.21,1632.28,4896.32,6528.43,3264.21,7181.27,0,5875.59,9644.86,6584.85,8771.298,3940.29,6202.01,19286.8,6213.47,8680.74,5782.15,6528.43,2774.58,4080.27,4091.62,19282.1,5575.92,10635.8;
    2937.79,7718.37,12543.7,2909.33,1262.53,7714.87,1305.69,17367.2,0,27002,1562.79,16704.8,19340.5,2390.91,36638,14593.5,10799.96,23178.3,10116.79,9162.13,5627.2,5494.78,36654.5,12657.14,27964.2;
    12077.6,6528.43,4896.32,8160.53,9792.64,6528.43,10445.5,3264.21,9139.8,0,10119.1,3615.94,2921.84,8923.69,9946.14,4080.27,11424.7,1416.82,9792.64,6038.8,7344.48,7344.48,9662.09,8923.69,10198.82;
    2058.32,10951.9,15444.3,5789.7,973.56,10958.9,2587.517,20255.6,3140.53,29901.5,0,19580.3,21684.8,2449.06,39520.7,17856.9,7669.93,26067.8,9211.52,12070.4,8199.36,8191.16,39616.6,13080.69,30854.8;
    8584.88,3955.04,3279.03,4676.4,6383.71,3259.95,6984.38,8771.2989,5650.09,10333,6722.56,0,2196.44,5973.51,19973.3,5982.27,7932.04,6463.38,6299.93,2685.68,3851.81,3851.77,19969.2,5320.67,11288.4;
    9303.01,33825.29,2916.81,5386,7018.06,3754.48,7670.9,3489.6,6470.48,8447.25,7344.48,771.65,0,6691.64,17848.9,1416.82,8650.17,4454.94,7018.06,3278.34,4569.9,4569.9,17860.7,6038.8,9158.87;
    2669.43,8679.55,13502.8,3869.81,2923.73,8678.35,1962.74,18311,1848.92,28022.4,1770.72,17648.4,19772.5,0,37607.6,15910.4,2029.73,24125.8,3978.5,10119.9,6270.46,6266.77,37606.3,8357.75,28928.3;
    15341.8,9792.64,8160.53,11424.7,13056.9,9792.64,13709.7,6528.43,12404,3449.02,13383.3,6756.92,6038.8,12730.4,0,7344.48,14689,4569.9,13056.9,9303.01,10608.7,10608.7,4393.97,12077.6,2937.79;
    7997.32,2859.29,8264.77,4080.27,5712.37,2557.59,6365.22,6558.02,5085.13,12045.5,6038.8,6161.57,4005.92,5385.95,21704.4,0,7344.48,8193.01,5712.37,1965.89,3264.21,3264.22,21699.2,4733.19,13024.1;
    12607.67,14468.2,19284.7,9368.09,5095.98,14529.2,10722.48,24103.1,7137.02,33760.4,4511.36,23421.9,25548.3,5941.52,43412.5,21699.8,0,29887.9,4859.01,15921.3,12062,12057.9,43420.2,7773.76,34728.4;
    10771.9,5222.75,3593.02,6854.85,8486.96,5480.11,9139.8,1990.65,7834.11,4005.72,8813.38,2247.27,1520.36,8160.53,13500,2774.58,10119,0,8486.96,4733.11,6038.9,6038.8,13503,7507.69,5029.95;
    4452.18,9701.77,14468.6,5385.11,6845.02,9636.67,10564.05,19284.4,10241.98,28964.4,9178.31,18609.4,20768.6,5027.78,38581.2,16878.4,1734.42,25084.3,0,11089.8,7231.61,7231.9,38592.5,4391.97,29892.4;
    6038.8,4936.5,3403.44,2121.74,3753.85,1043.16,4406.69,8406.15,3101,17834.3,4080.27,7754.75,9891.55,3427.42,27476.6,5785.78,5385.95,13988.4,3768.48,0,1329.44,1384.6,27493.8,3028.89,18796.4;
    4734.32,8535.47,7239.25,1778.44,2464.72,6800.08,3105.09,12056.1,2475.62,21712,2774.58,11384.3,13507.6,2135.51,31343.1,9637.76,4080.27,17845.9,2492.5,3947.77,0,4026.23,31355.9,10117.48,22667.6;
    4736.14,8266.8,7241.71,2439.62,2475.89,6159.63,3146,12059.6,2419.99,21706.9,2804.05,11377.8,13489,2121.74,31338.8,9643.75,4080.27,17853.8,2448.16,3981.9,4026.23,0,31344,1743.86,22660;
    15341.8,9792.64,8160.53,11424.7,13056.9,9792.64,13709.7,6528.43,12404,3449.02,13383.3,6756.92,6038.8,12730.4,4393.97,7344.48,14689,4569.9,13056.9,9303.01,10608.7,10608.7,0,12077.6,2937.79;
    4919.63,7766.46,11631.9,12159.3,11869.4,7139.26,13578.82,16394.5,12633.33,26048.5,12659.82,15732.9,17842.5,8200.03,35662.9,13997.9,2773.81,22189.9,1080.2,8317.59,4441.99,4440.07,35701.1,0,27004.5;
    12404,6854.96,5225.94,8486.96,10119.1,6584.85,10771.9,3732.65,9466.22,10168.98,10445.5,3819.13,3101,9792.64,8692.8,4406.69,11751.2,1831.35,10119.1,6365.22,7670.9,7670.9,8684.77,9139.8,0;
    ];
distances=[0,16391.1,21209,11571,6751.2, 16401.5,4939.21,26026.4,8669.04,35669.7,5957.64,25367,27495.6,7711.25,45322.2,23643.1,5659.98,31796.1,7444.93,17843.1,14300.2,14309.7,45348.2,10024.7,36647.7;
    5549.16,0,4825.9,1633.28,3264.21,1772.11,3917.06,9644.1,2611.37,19289.1,3657.02,9256.46,11351.6,2937.8,28923.9,7394.81,4919.93,15429.2,3450.3,5087.57,8285.66,8007.26,29397.3,12926.77,20260.4;
    7181.27,1632.11,0,3264.21,4896.32,1632.12,5549.16,4822.51,4243.48,14851.8,5222.74,5921.3,6657.26,4569.9,24121.9,4012.79,6605.14,10607.4,4897.6,1218.58,2527.8,2527.85,24125.2,4117.46,15764.3;
    3917.06,4824.83,9643.93,0,1632.11,4952.29,2284.95,14466.8,1014.62,24123.2,1958.53,14086.3,15914.8,1361.58,33744.5,12053.7,3314.51,20249.4,2642.09,6269.99,4976.8,6490.07,33758.4,12055.63,25076.2;
    2294.64,9642.01,14472,4816.07,0,9648.91,840.97,19298.5,2234.44,28926.1,362.783,18613.7,20731.5,1747.26,39624.8,16887.4,2558.96,25083.1,6845.01,11110.6,7427.36,7228.47,38587.9,12115.60,29909;
    5549.16,1772.11,4823.79,1652.2,3264.21,0,3917.06,9647.56,2611.37,19284.3,3590.64,9285.48,11115.5,2937.79,28939.9,7259.39,4899.25,15430.3,3302.77,3237.07,6470.84,5786.36,28906.9,10775.07,20243.5;
    1635.57,11579.1,16386.3,6756.84,1961.89,11569.9,0,21239.9,3857.9,30862.7,1584.03,21073.6,22670.7,3350.72,40526.5,18801.8,10438.58,27013.8,10683.53,13028.9,9175.55,9155.5,40531.6,3923.3,31826;
    8813.38,3264.21,1632.28,4896.32,6528.43,3264.21,7181.27,0,5875.59,9644.86,6584.85,8771.298,3940.29,6202.01,19286.8,6213.47,8680.74,5782.15,6528.43,2774.58,4080.27,4091.62,19282.1,5575.92,10635.8;
    2937.79,7718.37,12543.7,2909.33,1262.53,7714.87,1305.69,17367.2,0,27002,1562.79,16704.8,19340.5,2390.91,36638,14593.5,10799.96,23178.3,10116.79,9162.13,5627.2,5494.78,36654.5,12657.14,27964.2;
    12077.6,6528.43,4896.32,8160.53,9792.64,6528.43,10445.5,3264.21,9139.8,0,10119.1,3615.94,2921.84,8923.69,9946.14,4080.27,11424.7,1416.82,9792.64,6038.8,7344.48,7344.48,9662.09,8923.69,10198.82;
    2058.32,10951.9,15444.3,5789.7,973.56,10958.9,2587.517,20255.6,3140.53,29901.5,0,19580.3,21684.8,2449.06,39520.7,17856.9,7669.93,26067.8,9211.52,12070.4,8199.36,8191.16,39616.6,13080.69,30854.8;
    8584.88,3955.04,3279.03,4676.4,6383.71,3259.95,6984.38,8771.2989,5650.09,10333,6722.56,0,2196.44,5973.51,19973.3,5982.27,7932.04,6463.38,6299.93,2685.68,3851.81,3851.77,19969.2,5320.67,11288.4;
    9303.01,33825.29,2916.81,5386,7018.06,3754.48,7670.9,3489.6,6470.48,8447.25,7344.48,771.65,0,6691.64,17848.9,1416.82,8650.17,4454.94,7018.06,3278.34,4569.9,4569.9,17860.7,6038.8,9158.87;
    2669.43,8679.55,13502.8,3869.81,2923.73,8678.35,1962.74,18311,1848.92,28022.4,1770.72,17648.4,19772.5,0,37607.6,15910.4,2029.73,24125.8,3978.5,10119.9,6270.46,6266.77,37606.3,8357.75,28928.3;
    15341.8,9792.64,8160.53,11424.7,13056.9,9792.64,13709.7,6528.43,12404,3449.02,13383.3,6756.92,6038.8,12730.4,0,7344.48,14689,4569.9,13056.9,9303.01,10608.7,10608.7,4393.97,12077.6,2937.79;
    7997.32,2859.29,8264.77,4080.27,5712.37,2557.59,6365.22,6558.02,5085.13,12045.5,6038.8,6161.57,4005.92,5385.95,21704.4,0,7344.48,8193.01,5712.37,1965.89,3264.21,3264.22,21699.2,4733.19,13024.1;
    12607.67,14468.2,19284.7,9368.09,5095.98,14529.2,10722.48,24103.1,7137.02,33760.4,4511.36,23421.9,25548.3,5941.52,43412.5,21699.8,0,29887.9,4859.01,15921.3,12062,12057.9,43420.2,7773.76,34728.4;
    10771.9,5222.75,3593.02,6854.85,8486.96,5480.11,9139.8,1990.65,7834.11,4005.72,8813.38,2247.27,1520.36,8160.53,13500,2774.58,10119,0,8486.96,4733.11,6038.9,6038.8,13503,7507.69,5029.95;
    4452.18,9701.77,14468.6,5385.11,6845.02,9636.67,10564.05,19284.4,10241.98,28964.4,9178.31,18609.4,20768.6,5027.78,38581.2,16878.4,1734.42,25084.3,0,11089.8,7231.61,7231.9,38592.5,4391.97,29892.4;
    6038.8,4936.5,3403.44,2121.74,3753.85,1043.16,4406.69,8406.15,3101,17834.3,4080.27,7754.75,9891.55,3427.42,27476.6,5785.78,5385.95,13988.4,3768.48,0,1329.44,1384.6,27493.8,3028.89,18796.4;
    4734.32,8535.47,7239.25,1778.44,2464.72,6800.08,3105.09,12056.1,2475.62,21712,2774.58,11384.3,13507.6,2135.51,31343.1,9637.76,4080.27,17845.9,2492.5,3947.77,0,4026.23,31355.9,10117.48,22667.6;
    4736.14,8266.8,7241.71,2439.62,2475.89,6159.63,3146,12059.6,2419.99,21706.9,2804.05,11377.8,13489,2121.74,31338.8,9643.75,4080.27,17853.8,2448.16,3981.9,4026.23,0,31344,1743.86,22660;
    15341.8,9792.64,8160.53,11424.7,13056.9,9792.64,13709.7,6528.43,12404,3449.02,13383.3,6756.92,6038.8,12730.4,4393.97,7344.48,14689,4569.9,13056.9,9303.01,10608.7,10608.7,0,12077.6,2937.79;
    4919.63,7766.46,11631.9,12159.3,11869.4,7139.26,13578.82,16394.5,12633.33,26048.5,12659.82,15732.9,17842.5,8200.03,35662.9,13997.9,2773.81,22189.9,1080.2,8317.59,4441.99,4440.07,35701.1,0,27004.5;
    12404,6854.96,5225.94,8486.96,10119.1,6584.85,10771.9,3732.65,9466.22,10168.98,10445.5,3819.13,3101,9792.64,8692.8,4406.69,11751.2,1831.35,10119.1,6365.22,7670.9,7670.9,8684.77,9139.8,0;
    ];
citytime=[0,39.1181,50.5988,27.5421,15.6206,38.9482,10.9357,32.1276,20.8651,85.0746,13.9327,60.3517,65.2585,18.6398,107.9295,56.0675,21.2132,76.2199,19.5078,42.4094,41.9880,31.9535,107.539,23.5702,87.1417;
    34,0,11.4251,10,20,6.859,24,22.9586,16,45.9008,22,21.7259,26.1820,18,68.9687,17.5165,30,36.7261,20,13.9657,23.1157,22.3365,68.7974,35.8224,40.0871;
    44,10,0,20,30,10,34,11.4717,26,32.7269,32,19.3936,15.7631,28,57.2149,13.8343,40,25.2580,30,7,15,15,57.1805,24,35.6068;
    24,11.4407,22.9567,0,10,10.8838,14,34.4445,6,57.1328,12,31.939,37.8487,8,80.6610,28.6961,20,48.2359,13.333,14.8939,13.7560,18.1089,80.2459,34.2691,59.6577;
    14,22.9587,34.3968,11.6019,0,22.8675,6,45.749,6.3246,68.9752,2.0138,44.2431,49.3809,6.1464,91.1778,40.0414,13.0384,59.5914,26.494,26.147,16.3592,17.3292,91.5939,33.6145,70.9707;
    34,6.859,11.4673,10,10,0,24,22.9029,162,45.9733,22,21.7387,26.1471,18,68.7245,17.5068,6.325,36.6853,20,8.686,18.0556,16.1637,69.2854,29.7494,48.2713;
    10,27.448,39.1572,15.9857,4.6676,27.5610,0,50.1984,9.1744,73.3748,5.4416,46.5610,53.8780,9.481,96.0790,44.8137,29.1283,64.1286,29.9917,30.8449,21.6533,22.0048,95.9647,22.7279,75.7019;
    54,20,10,30,40,20,44,0,36,22.9343,42,33.9505,14.6752,38,45.9178,17.3428,50,13.9217,40,17,25,25,45.9876,34,25.6773;
    18,18.3092,29.7691,6.9259,6.1464,18.3367,8,41.2477,0,64.2408,7.9197,39.5036,42.3313,9.2616,87.3286,35.5140,29.8132,54.7121,28.7103,21.7932,13.3314,12.8534,87.0752,36.1267,66.5742;
    74,40,30,50,60,40,64,20,56,0,62,21.4,17,54,23.205,25,70,8,60,37,45,45,22.7664,54,29.036;
    12,23.7489,36.5704,13.7356,2.3351,23.6255,10.015,48.1030,7.9197,71.1078,0,46.5422,51.8357,7.5314,94.5778,42.261,21.2254,61.6086,26.1866,28.4891,19.4761,19.6462,93.2538,35.8112,73.5937;
    52.6,21.0212,19.3936,28.6,38.6,18.6,42.6,33.9505,34.6,24.9221,40.6,0,5.1559,36.6,47.3686,16.6898,48.6,15.6406,38.6,15.6,23.6,23.6,47.4293,32.6,26.7732;
    57,23,15.298,33,43,23,47,14.6752,39,19.6935,45,4.4,0,41,42.3805,8,53,10.3314,43,20,28,28,42.2258,37,21.837;
    16,20.6729,32.1255,9.3320,11.31,20.6512,10.1222,43.7746,7.111,65.8824,7.5314,42.0153,47.0056,0,89.5334,37.8732,12,57.2115,11.1111,24.2084,14.8031,14.9303,89.5294,23.2288,68.834;
    94,60,50,70,80,60,84,40,76,20,82,41.4,37,78,0,45,90,28,80,57,65,65,17.0073,74,18;
    49,16,23.0572,25,35,15,39,17.8383,31,28.7757,37,16.9249,9.4609,33,51.5405,0,45,19.5434,35,12,20,20,51.618,29,30.9268;
    35.8533,34.4182,45.9317,23.1713,13.0384,33.8731,29.5385,57.4832,18.3848,80.2083,12.9121,55.9797,61.0024,13.7842,103.073,51.638,0,71.4113,11.6738,37.7527,28.5948,28.6227,102.96,18.68,82.4918;
    66,32,22,42,52,32,56,12,48,9.4069,54,13.4,9,50,32.1445,17,62,0,52,29,37,37,32.1188,46,11.8266;
    19.5078,23.2960,34.3897,15,26.494,23.127,29.9917,45.9335,28.7103,68.3175,26.1866,44.4182,48.9372,14.0845,91.7645,40.1453,10,59.617,0,26.3627,17.3797,17.2187,91.585,11.09,71.1227;
    37,13.7717,8.1601,13,23,4.9944,27,18.5681,19,42.527,25,18.0854,21.821,21,65.551,13.7716,33,33.2068,23,0,8,8,65.265,17,44.8233;
    29,23.4413,17.4578,8.3683,15,18.5714,15.045,28.6893,12.8506,51.4712,17,27.0258,32.0496,13,74.6143,23.0235,25,42.4496,15,9.1009,0,15.5839,74.347,28.2,53.8766;
    29,22.6511,17.5071,10.9653,15,16.6253,15,28.6336,12.7563,51.5033,17,27.104,32.3573,13,74.6171,22.9761,25,42.2872,15,9.2979,15.5839,0,74.6022,9.501,54.0502;
    94,60,50,70,80,60,84,40,76,20,82,41.4,37,78,17.0073,45,90,28,80,57,65,65,0,74,18;
    23.5702,21.7919,28.0196,34.2691,33.147,18.345,37.8798,39.0315,36.1267,61.8627,35.3138,37.2447,42.4316,22.9061,82.222,33.1163,16,52.68,6.0093,19.8522,10.5533,10.5267,84.709,0,64.3041;
    76,42,32,52,62,42,66,22,58,29.0360,64,23.4,19,60,20.5048,27,72,10.1379,62,39,47,47,20.533,56,0;
    ];
for i=1:length(distances(1,:)),
for j=1:length(distances(1,:)),
    if i~=j
distances(i,j)=distances(i,j)+rand+rand;
cityDist(i,j)=cityDist(i,j)+rand+rand;
    end
end
end
% %% 最近邻算法（WTSC）
% destn(1)=3;
% tt=3;
% cityDist1=cityDist;
% for i=1:n-1,
%     Ncity=cityDist1(tt,find(cityDist1(tt,:)~=0));
%     tt=find(cityDist1(tt,:)==min(Ncity));
%     destn(i+1)=tt;
%     cityDist1(:,destn(i))=0;
%     E1(i)=cityDist1(destn(i),destn(i+1));
% % destn(i+1)=find(cityDist(i,:)==min(cityDist(i,:)));
% end
% SE1=sum(E1);
Euclidistance=[];
for i=1:length(citytime(1,:)),
for j=1:length(citytime(1,:)),
if i~=j
Euclidistance(i,j)=sqrt((cities(i,1)-cities(j,1))^2+(cities(i,2)-cities(j,2))^2+(cities(i,3)-cities(j,3))^2);
else 
Euclidistance(i,j)=0;
end
end
end
deportdis=zeros(length(citytime(1,:)),2);
for i=1:length(citytime(1,:)),
deportdis(i,:)=sqrt((cities(i,1)-cities(26,1))^2+(cities(i,2)-cities(26,2))^2+(cities(i,3)-cities(26,3))^2);
end
deport_position=zeros(25,2);
deport_position(:,1)=[21208.1,5123.8,5278.97,9646.76,14465.8,4873.1,16397.4,17777.2,12535.3,4896.32,15419.7,1594.32,2174.28,13513.1,8160.53,881.758,19300.4,3590.64,14475.4,3450.65,7227.96,7234.31,8160.53,11570.8,5222.74];
deport_position(:,2)=[7486.27,2532.4,5278.97,3303.27,4896.32,1753.4,5549.16,4888.84,4243.49,14463,5628.9,4328.65,6264.73,4569.9,24102.3,2439.84,6528.43,10622,4896.32,1143.62,2448.16,2448.16,24087.7,3917.8,15447.2]; 
deport_time(:,1)=[50.6246,12.9110,20.43,22.9218,34.4347,11.6866,39.0035,10,29.8378,30,36.7945,8.7955,13,32.0083,50,5,45.7075,22,34.3053,7.9155,17.284,17.204,50,27.5475,32];
deport_time(:,2)=[44,12.911,20.43,20,30,10,34,11.6703,26,34.4586,32,10.2127,14.9639,28,57.5342,5.8398,40,25.0759,30,7,15,15,57.724,24,36.519];

%% 新建数组
tic
for uy=1:900,
%alpha=0.5;
%chotemp=[1,2,3,7,8];
roun1=randperm(25);
roun2=roun1(1:10);% 新建数组的维度
%roun2=[6,1,3,2,5,8];
tta1=[];tta2=[];
uyy=zeros(1,length(roun2));
newcityDist=zeros(length(roun2),length(roun2));
newcityTime=zeros(length(roun2),length(roun2));
newcityDist_com=zeros(length(roun2),length(roun2));
%% 新建数组 
for i=1:length(roun2),
for j=1:length(roun2),
newcityDist(i,j)=cityDist(roun2(i),roun2(j));
newcityTime(i,j)=citytime(roun2(i),roun2(j));
end
end
% %% 时间能耗综合数组 
% for i=1:length(roun2),
% for j=1:length(roun2),
% newcityDist_com(i,j)=(alpha*(newcityDist(i,j)/max(max(newcityDist))))+((1-alpha)*(newcityTime(i,j)/max(max(newcityTime))));
% end
% end
newcityCoor=cityCoor(roun2,:);
n=size(newcityCoor,1);
%% ① pso
%% 
nMax=200;                      %进化次数
indiNumber=1000;               %个体数目
individual=zeros(indiNumber,n);
%^初始化粒子位置
for i=1:indiNumber
    individual(i,:)=randperm(n);    
end

%% 计算种群适应度
indiFit=fitness(individual,newcityCoor,newcityDist);
[value,index]=min(indiFit);
tourPbest=individual;                              %当前个体最优
tourGbest=individual(index,:) ;                    %当前全局最优
recordPbest=inf*ones(1,indiNumber);                %个体最优记录
recordGbest=indiFit(index);                        %群体最优记录
xnew1=individual;

%% 循环寻找最优路径
L_best=zeros(1,nMax);
for N=1:nMax
    %N
    %计算适应度值
    indiFit=fitness(individual,newcityCoor,newcityDist);
    
    %更新当前最优和历史最优
    for i=1:indiNumber
        if indiFit(i)<recordPbest(i)
            recordPbest(i)=indiFit(i);
            tourPbest(i,:)=individual(i,:);
        end
        if indiFit(i)<recordGbest
            recordGbest=indiFit(i);
            tourGbest=individual(i,:);
        end
    end
    
    [value,index]=min(recordPbest);
    recordGbest(N)=recordPbest(index);
    
    %% 交叉操作
    for i=1:indiNumber
       % 与个体最优进行交叉
        c1=unidrnd(n-1); %产生交叉位
        c2=unidrnd(n-1); %产生交叉位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=tourPbest(i,chb1:chb2);
        ncros=size(cros,2);      
        %删除与交叉区域相同元素
        for j=1:ncros
            for k=1:n
                if xnew1(i,k)==cros(j)
                    xnew1(i,k)=0;
                    for t=1:n-k
                        temp=xnew1(i,k+t-1);
                        xnew1(i,k+t-1)=xnew1(i,k+t);
                        xnew1(i,k+t)=temp;
                    end
                end
            end
        end
        %插入交叉区域
        xnew1(i,n-ncros+1:n)=cros;
        %新路径长度变短则接受
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
        
        % 与全体最优进行交叉
        c1=round(rand*(n-2))+1;  %产生交叉位
        c2=round(rand*(n-2))+1;  %产生交叉位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=tourGbest(chb1:chb2); 
        ncros=size(cros,2);      
        %删除与交叉区域相同元素
        for j=1:ncros
            for k=1:n
                if xnew1(i,k)==cros(j)
                    xnew1(i,k)=0;
                    for t=1:n-k
                        temp=xnew1(i,k+t-1);
                        xnew1(i,k+t-1)=xnew1(i,k+t);
                        xnew1(i,k+t)=temp;
                    end
                end
            end
        end
        %插入交叉区域
        xnew1(i,n-ncros+1:n)=cros;
        %新路径长度变短则接受
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
        
       %% 变异操作
        c1=round(rand*(n-1))+1;   %产生变异位
        c2=round(rand*(n-1))+1;   %产生变异位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        temp=xnew1(i,c1);
        xnew1(i,c1)=xnew1(i,c2);
        xnew1(i,c2)=temp;
        
        %新路径长度变短则接受
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
    end

    [value,index]=min(indiFit);
    L_best(N)=indiFit(index);
    tourGbest=individual(index,:); 
    
end
bestres=roun2(tourGbest);
besttime=0;
bestener=0;
for i=1:length(bestres)-1,
besttime=besttime+citytime(bestres(i),bestres(i+1));
bestener=bestener+cityDist(bestres(i),bestres(i+1));
end
roun_pso{uy}=roun2;
res_pso{uy}=bestres;
time_pso(uy)=besttime;
ener_pso(uy)=bestener;
end
% for i=1;length(ener_pso),
% ener_pso(i)=ener_pso(i)+cityDist(res_pso{i}(10),res_pso{i}(1));
% end
% uener1=[];utime1=[];unumber1=[];
% for i=1:300,
% uener1(i)=sum(ener_pso(1+(3*(i-1)):3*i));
% utime1(i)=sum(time_pso(1+(3*(i-1)):3*i));
% unumber1(i)=ceil(uener1(i)/uav_energy);
% end
% avg_ener_pso=mean(uener1);
% avg_time_pso=mean(utime1);
% avg_num_pso=ceil(mean(unumber1));
t_pso=toc

% %% ① pso_com
% array_alpha=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9];
% for f=1:length(array_alpha),
% tic
% for uy=1:length(roun_pso),
% %% 比例
% %alpha=array_alpha(f);
% alpha=0.6;
% %chotemp=[1,2,3,7,8];
% roun1=randperm(13);
% roun2=roun_pso{uy};% 新建数组的维度
% %roun2=[6,1,3,2,5,8];
% tta1=[];tta2=[];
% uyy=zeros(1,length(roun2));
% newcityDist=zeros(length(roun2),length(roun2));
% newcityTime=zeros(length(roun2),length(roun2));
% newcityDist_com=zeros(length(roun2),length(roun2));
% %% 新建数组 
% for i=1:length(roun2),
% for j=1:length(roun2),
% newcityDist(i,j)=cityDist(roun2(i),roun2(j));
% newcityTime(i,j)=citytime(roun2(i),roun2(j));
% end
% end
% %% 时间能耗综合数组 
% for i=1:length(roun2),
% for j=1:length(roun2),
% newcityDist_com(i,j)=(alpha*(newcityDist(i,j)/max(max(newcityDist))))+((1-alpha)*(newcityTime(i,j)/max(max(newcityTime))));
% end
% end
% newcityCoor=cityCoor(roun2,:);
% n=size(newcityCoor,1);
% %% 
% nMax=200;                      %进化次数
% indiNumber=1000;               %个体数目
% individual=zeros(indiNumber,n);
% %^初始化粒子位置
% for i=1:indiNumber
%     individual(i,:)=randperm(n);    
% end
% 
% %% 计算种群适应度
% indiFit=fitness(individual,newcityCoor,newcityDist_com);
% [value,index]=min(indiFit);
% tourPbest=individual;                              %当前个体最优
% tourGbest=individual(index,:) ;                    %当前全局最优
% recordPbest=inf*ones(1,indiNumber);                %个体最优记录
% recordGbest=indiFit(index);                        %群体最优记录
% xnew1=individual;
% 
% %% 循环寻找最优路径
% L_best=zeros(1,nMax);
% for N=1:nMax
%     %N
%     %计算适应度值
%     indiFit=fitness(individual,newcityCoor,newcityDist_com);
%     
%     %更新当前最优和历史最优
%     for i=1:indiNumber
%         if indiFit(i)<recordPbest(i)
%             recordPbest(i)=indiFit(i);
%             tourPbest(i,:)=individual(i,:);
%         end
%         if indiFit(i)<recordGbest
%             recordGbest=indiFit(i);
%             tourGbest=individual(i,:);
%         end
%     end
%     
%     [value,index]=min(recordPbest);
%     recordGbest(N)=recordPbest(index);
%     
%     %% 交叉操作
%     for i=1:indiNumber
%        % 与个体最优进行交叉
%         c1=unidrnd(n-1); %产生交叉位
%         c2=unidrnd(n-1); %产生交叉位
%         while c1==c2
%             c1=round(rand*(n-2))+1;
%             c2=round(rand*(n-2))+1;
%         end
%         chb1=min(c1,c2);
%         chb2=max(c1,c2);
%         cros=tourPbest(i,chb1:chb2);
%         ncros=size(cros,2);      
%         %删除与交叉区域相同元素
%         for j=1:ncros
%             for k=1:n
%                 if xnew1(i,k)==cros(j)
%                     xnew1(i,k)=0;
%                     for t=1:n-k
%                         temp=xnew1(i,k+t-1);
%                         xnew1(i,k+t-1)=xnew1(i,k+t);
%                         xnew1(i,k+t)=temp;
%                     end
%                 end
%             end
%         end
%         %插入交叉区域
%         xnew1(i,n-ncros+1:n)=cros;
%         %新路径长度变短则接受
%         dist=0;
%         for j=1:n-1
%             dist=dist+newcityDist_com(xnew1(i,j),xnew1(i,j+1));
%         end
%         dist=dist+newcityDist_com(xnew1(i,1),xnew1(i,n));
%         if indiFit(i)>dist
%             individual(i,:)=xnew1(i,:);
%         end
%         
%         % 与全体最优进行交叉
%         c1=round(rand*(n-2))+1;  %产生交叉位
%         c2=round(rand*(n-2))+1;  %产生交叉位
%         while c1==c2
%             c1=round(rand*(n-2))+1;
%             c2=round(rand*(n-2))+1;
%         end
%         chb1=min(c1,c2);
%         chb2=max(c1,c2);
%         cros=tourGbest(chb1:chb2); 
%         ncros=size(cros,2);      
%         %删除与交叉区域相同元素
%         for j=1:ncros
%             for k=1:n
%                 if xnew1(i,k)==cros(j)
%                     xnew1(i,k)=0;
%                     for t=1:n-k
%                         temp=xnew1(i,k+t-1);
%                         xnew1(i,k+t-1)=xnew1(i,k+t);
%                         xnew1(i,k+t)=temp;
%                     end
%                 end
%             end
%         end
%         %插入交叉区域
%         xnew1(i,n-ncros+1:n)=cros;
%         %新路径长度变短则接受
%         dist=0;
%         for j=1:n-1
%             dist=dist+newcityDist_com(xnew1(i,j),xnew1(i,j+1));
%         end
%         dist=dist+newcityDist_com(xnew1(i,1),xnew1(i,n));
%         if indiFit(i)>dist
%             individual(i,:)=xnew1(i,:);
%         end
%         
%        %% 变异操作
%         c1=round(rand*(n-1))+1;   %产生变异位
%         c2=round(rand*(n-1))+1;   %产生变异位
%         while c1==c2
%             c1=round(rand*(n-2))+1;
%             c2=round(rand*(n-2))+1;
%         end
%         temp=xnew1(i,c1);
%         xnew1(i,c1)=xnew1(i,c2);
%         xnew1(i,c2)=temp;
%         
%         %新路径长度变短则接受
%         dist=0;
%         for j=1:n-1
%             dist=dist+newcityDist_com(xnew1(i,j),xnew1(i,j+1));
%         end
%         dist=dist+newcityDist_com(xnew1(i,1),xnew1(i,n));
%         if indiFit(i)>dist
%             individual(i,:)=xnew1(i,:);
%         end
%     end
% 
%     [value,index]=min(indiFit);
%     L_best(N)=indiFit(index);
%     tourGbest=individual(index,:); 
%     
% end
% bestres=roun2(tourGbest);
% besttime=0;
% bestener=0;
% for i=1:length(bestres)-1,
% besttime=besttime+citytime(bestres(i),bestres(i+1));
% bestener=bestener+cityDist(bestres(i),bestres(i+1));
% end
% roun_pso_com{uy}=roun2;
% res_pso_com{uy}=bestres;
% time_pso_com(uy)=besttime;
% ener_pso_com(uy)=bestener;
% end
% for i=1:length(roun_pso)/10,
% uener5(i)=sum(ener_pso_com(1+(10*(i-1)):10*i));
% utime5(i)=sum(time_pso_com(1+(10*(i-1)):10*i));
% unumber5(i)=ceil(uener5(i)/uav_energy);
% end
% avg_ener_pso_com(f)=mean(uener5);
% avg_time_pso_com(f)=mean(utime5);
% avg_num_pso_com(f)=ceil(mean(unumber5));
% t_pso_com(f)=toc
% pso_com_all{f,1}=roun_pso_com;pso_com_all{f,2}=res_pso_com;pso_com_all{f,3}=time_pso_com;pso_com_all{f,4}=ener_pso_com;
% roun_pso_com=[];res_pso_com=[];time_pso_com=[];ener_pso_com=[];uener5=[];utime5=[];unumber5=[];
% end

%% pso-distance
ac=cityDist;
dc=deport_position;
cityDist=Euclidistance;
deport_position=deportdis;
tic
for uy=1:length(roun_pso),
%% 比例
%alpha=array_alpha(f);
%alpha=0.6;
%chotemp=[1,2,3,7,8];
%roun1=randperm(13);
cityDist=Euclidistance;
deport_position=deportdis;
roun2=roun_pso{uy};% 新建数组的维度
%roun2=[6,1,3,2,5,8];
tta1=[];tta2=[];
uyy=zeros(1,length(roun2));
newcityDist=zeros(length(roun2),length(roun2));
newcityTime=zeros(length(roun2),length(roun2));
newcityDist_com=zeros(length(roun2),length(roun2));
%% 新建数组 
for i=1:length(roun2),
for j=1:length(roun2),
newcityDist(i,j)=cityDist(roun2(i),roun2(j));
newcityTime(i,j)=citytime(roun2(i),roun2(j));
end
end
%% 时间能耗综合数组 
% for i=1:length(roun2),
% for j=1:length(roun2),
% newcityDist_com(i,j)=(alpha*(newcityDist(i,j)/max(max(newcityDist))))+((1-alpha)*(newcityTime(i,j)/max(max(newcityTime))));
% end
% end
newcityCoor=cityCoor(roun2,:);
n=size(newcityCoor,1);
%% 
nMax=200;                      %进化次数
indiNumber=1000;               %个体数目
individual=zeros(indiNumber,n);
%^初始化粒子位置
for i=1:indiNumber
    individual(i,:)=randperm(n);    
end

%% 计算种群适应度
indiFit=fitness(individual,newcityCoor,newcityDist);
[value,index]=min(indiFit);
tourPbest=individual;                              %当前个体最优
tourGbest=individual(index,:) ;                    %当前全局最优
recordPbest=inf*ones(1,indiNumber);                %个体最优记录
recordGbest=indiFit(index);                        %群体最优记录
xnew1=individual;

%% 循环寻找最优路径
L_best=zeros(1,nMax);
for N=1:nMax
    %N
    %计算适应度值
    indiFit=fitness(individual,newcityCoor,newcityDist);
    
    %更新当前最优和历史最优
    for i=1:indiNumber
        if indiFit(i)<recordPbest(i)
            recordPbest(i)=indiFit(i);
            tourPbest(i,:)=individual(i,:);
        end
        if indiFit(i)<recordGbest
            recordGbest=indiFit(i);
            tourGbest=individual(i,:);
        end
    end
    
    [value,index]=min(recordPbest);
    recordGbest(N)=recordPbest(index);
    
    %% 交叉操作
    for i=1:indiNumber
       % 与个体最优进行交叉
        c1=unidrnd(n-1); %产生交叉位
        c2=unidrnd(n-1); %产生交叉位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=tourPbest(i,chb1:chb2);
        ncros=size(cros,2);      
        %删除与交叉区域相同元素
        for j=1:ncros
            for k=1:n
                if xnew1(i,k)==cros(j)
                    xnew1(i,k)=0;
                    for t=1:n-k
                        temp=xnew1(i,k+t-1);
                        xnew1(i,k+t-1)=xnew1(i,k+t);
                        xnew1(i,k+t)=temp;
                    end
                end
            end
        end
        %插入交叉区域
        xnew1(i,n-ncros+1:n)=cros;
        %新路径长度变短则接受
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
        
        % 与全体最优进行交叉
        c1=round(rand*(n-2))+1;  %产生交叉位
        c2=round(rand*(n-2))+1;  %产生交叉位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=tourGbest(chb1:chb2); 
        ncros=size(cros,2);      
        %删除与交叉区域相同元素
        for j=1:ncros
            for k=1:n
                if xnew1(i,k)==cros(j)
                    xnew1(i,k)=0;
                    for t=1:n-k
                        temp=xnew1(i,k+t-1);
                        xnew1(i,k+t-1)=xnew1(i,k+t);
                        xnew1(i,k+t)=temp;
                    end
                end
            end
        end
        %插入交叉区域
        xnew1(i,n-ncros+1:n)=cros;
        %新路径长度变短则接受
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
        
       %% 变异操作
        c1=round(rand*(n-1))+1;   %产生变异位
        c2=round(rand*(n-1))+1;   %产生变异位
        while c1==c2
            c1=round(rand*(n-2))+1;
            c2=round(rand*(n-2))+1;
        end
        temp=xnew1(i,c1);
        xnew1(i,c1)=xnew1(i,c2);
        xnew1(i,c2)=temp;
        
        dist=0;
        for j=1:n-1
            dist=dist+newcityDist(xnew1(i,j),xnew1(i,j+1));
        end
        dist=dist+newcityDist(xnew1(i,1),xnew1(i,n));
        if indiFit(i)>dist
            individual(i,:)=xnew1(i,:);
        end
    end

    [value,index]=min(indiFit);
    L_best(N)=indiFit(index);
    tourGbest=individual(index,:); 
    
end
bestres=roun2(tourGbest);
besttime=0;
bestener=0;
cityDist=ac;
for i=1:length(bestres)-1,
besttime=besttime+citytime(bestres(i),bestres(i+1));
bestener=bestener+cityDist(bestres(i),bestres(i+1));
end
roun_pso_dis{uy}=roun2;
res_pso_dis{uy}=bestres;
time_pso_dis(uy)=besttime;
ener_pso_dis(uy)=bestener;
end
t_pso_dis=toc;
%% 整体分析部分
% initb=[10,15,20,25,30,35,40,45,50];
% for i=1:length(initb),
% uener5=[];utime5=[];unumber5=[];uener4=[];utime4=[];unumber4=[];uener3=[];utime3=[];unumber3=[];uener2=[];utime2=[];unumber2=[];uener1=[];utime1=[];unumber1=[];
% for j=1:floor(900/initb(i)),
% uener5(j)=sum(ener_norpso(1+(initb(i)*(j-1)):initb(i)*j));
% utime5(j)=sum(time_norpso(1+(initb(i)*(j-1)):initb(i)*j));
% unumber5(j)=ceil(uener5(j)/uav_energy);
% uener4(j)=sum(ener_nn(1+(initb(i)*(j-1)):initb(i)*j));
% utime4(j)=sum(time_nn(1+(initb(i)*(j-1)):initb(i)*j));
% unumber4(j)=ceil(uener4(j)/uav_energy);
% uener3(j)=sum(ener_bnb(1+(initb(i)*(j-1)):initb(i)*j));
% utime3(j)=sum(time_bnb(1+(initb(i)*(j-1)):initb(i)*j));
% unumber3(j)=ceil(uener3(j)/uav_energy);
% uener2(j)=sum(ener_ga(1+(initb(i)*(j-1)):initb(i)*j));
% utime2(j)=sum(time_ga(1+(initb(i)*(j-1)):initb(i)*j));
% unumber2(j)=ceil(uener2(j)/uav_energy);
% uener1(j)=sum(ener_pso(1+(initb(i)*(j-1)):initb(i)*j));
% utime1(j)=sum(time_pso(1+(initb(i)*(j-1)):initb(i)*j));
% unumber1(j)=ceil(uener1(j)/uav_energy);
% end
% avg_ener_norpso5(i)=mean(uener5);
% avg_time_norpso5(i)=mean(utime5);
% avg_num_norpso5(i)=ceil(mean(unumber5));
% avg_ener_nn4(i)=mean(uener4);
% avg_time_nn4(i)=mean(utime4);
% avg_num_nn4(i)=ceil(mean(unumber4));
% avg_ener_bnb3(i)=mean(uener3);
% avg_time_bnb3(i)=mean(utime3);
% avg_num_bnb3(i)=ceil(mean(unumber3));
% avg_ener_ga2(i)=mean(uener2);
% avg_time_ga2(i)=mean(utime2);
% avg_num_ga2(i)=ceil(mean(unumber2));
% avg_ener_pso1(i)=mean(uener1);
% avg_time_pso1(i)=mean(utime1);
% avg_num_pso1(i)=ceil(mean(unumber1));
% end