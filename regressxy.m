% for find the right confidential region.
observetunning;

% for find the right confidential region.

% size of rateList 225*1
% size of rateList{1,1} 1200*940
% size of testingResult: 15*15

test_num = size(testingResult,1);
f1 = testingResult(:,1);
f2 = testingResult(:,2);
x = [ones(test_num,1) f1];


sample_time = 1:20:940;
sample_num  = size(sample_time,2);
num_neuron = 1200;

%  clear rateattime
%  for i = 1:num_neuron
%      for j = 1:num_test
%          rateattime{i,1}(j,:) = rateList{j,1}(i,sample_time);
%      end
%  end

%rateattime : 1200*1
%rateattime{1,1} : 225*40

clear b;
% 
% 
for i = 100:400
    fprintf('%d\n',i);
    for t=40:sample_num
        mdlf1 = fitlm(f1,rateattime{i,1}(:,t));
        mdlf2 = fitlm(f2,rateattime{i,1}(:,t));
        mdlf12 = fitlm(f1-f2,rateattime{i,1}(:,t));
        mf1(i,t-39) = mdlf1.Coefficients.pValue(2);
        mf2(i,t-39) = mdlf2.Coefficients.pValue(2);
        mf12(i,t-39) = mdlf12.Coefficients.pValue(2);
        me1(i,t-39) = mdlf1.Coefficients.Estimate(2);
        me2(i,t-39) = mdlf2.Coefficients.Estimate(2);
        me12(i,t-39) = mdlf12.Coefficients.Estimate(2);
    end
end