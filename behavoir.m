f1 = 0.6;
test_para(1) = 30;
Input = zeros(test_para(1),2);
Input(:,1) = f1*ones(test_para(1),1);
rate  = zeros(size(0.1:0.1:1.2,1),1);
num = 1;

for f2=0.1:0.1:1.2
    Input(:,2) = f2*ones(test_para(1),1);
    [rateList, testingResult] = Testing_paper(Input, WMC, CP, newWeights, time_s, test_para);
    rate(num) = sum((testingResult(:,4)>0));
    num = num+1;
    fprintf('f2 = %d, right rate is %d',f2, rate(num-1));
end
