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


sample_time = 1:10:940;
sample_num  = size(sample_time,2);
num_neuron = 1200;

%  clear rateattime
%  for i = 1:num_neuron
%      for j = 1:num_test
%          rateattime{i,1}(j,:) = rateList{j,1}(i,sample_time);
%      end
%  end

% rateattime : 1200*1
% rateattime{1,1} : 225*40
clear ss;
 clear b;
% 
% 
for i = 1:num_neuron
%    fprintf('%d\n',i);
    for t=1:80
        [b{i,1}(t,1:2),bint,r,rint,s] = regress(rateattime{i,1}(:,t),x);
             b{i,1}(t,3) = s(3);
             if(bint(2,1)*bint(2,2)<0)
                 b{i,1}(t,3) = 1; % since include the zero point.
                
             end
             b{i,1}(t,4:5)=bint(2,:);
 %       bp(i,t) = mdl.Coefficients.pValue(2);
 %       bk(i,t) = mdl.Coefficients.Estimate(2);
    end
end

for i = 1:80
    ss(i,j)=1;
    for j = 1:num_neuron

        if(b{j,1}(i,2)>0)
            ss(i,j)=20;
        end
        if(b{j,1}(i,2)<0)
            ss(i,j)=0;
        end
        if(b{j,1}(i,3)>0.05)
            ss(i,j)=-20;
        end        
       
    end
end