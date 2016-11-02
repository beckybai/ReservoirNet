function [all_b] = reg4analydata(fireatlast,testingResult)
f1 = testingResult(:,1);
f2 = testingResult(:,2);
num_test = size(fireatlast,1);
num_neuron = size(fireatlast,2);

valued_num = 0;
valued_index = zeros(num_neuron,1);
valued_fireing = [];
valued_regress = [];
%b =  zeros(4,2);
%s = zeros(4,4);
ignore0 = 1;
ignore1 = 1;


all_b = [];
all_s = [];

large = 0; % caculate the things abnormal large
small = 0; % caculate the things abnormal small

regfact = zeros(num_neuron,4);

for i=1:size(fireatlast,2)
    if(mean(fireatlast(:,i)>1.95)) & ~ignore1
        large = large + 1;
        continue;
    end
    if(mean(fireatlast(:,i) < 0.05))& ~ignore0
        small = small + 1;    
        continue;
    else
        valued_num = valued_num + 1;
        valued_index(i) = 1;
        valued_fireing = [valued_fireing  fireatlast(:,i)];
        nowfiring = fireatlast(:,i);
        % FOUR KIND OF REGRESSION RAW DATA
        f = zeros(size(fireatlast,1),4);
        f(:,1) = f1;
        f(:,2) = f2;
        f(:,3) = f1-f2;
        f(:,4) = f1+f2;
        xf1 = [ones(size(fireatlast,1),1) f1];
        xf2 = [ones(size(fireatlast,1),1) f2];
        xf1_2 = [ones(size(fireatlast,1),1) f1-f2];
        xf12 = [ones(size(fireatlast,1),1) f1+f2];
       % regress(nowfiring,xf1);
        
        
 %       [bt, bintt, rt,rintt,st] = regress(nowfiring,[xf1,f2]);

        [b,bint1,r1,rint1,s] = regress(nowfiring,[xf1,f2]);
        
%        [b(2,:),bint2,r2,rint2,s(2,:)] = regress(nowfiring,xf2);

   %     regfact(valued_num,: ) = s(:,1);
        
        
        all_b = [all_b ;b(1:3,:)'];                                                               ,;
    end 
end

fprintf('The abnormal small number is %d',small);
fprintf('The abnormal large number is %d',large);

regfact = regfact(1:valued_num,:);

[~,mxreg] = max(regfact');
for i=1:4
    fprintf('The mean regression factor for %d is %f\n',i,mean(regfact(:,i)));  
end
for i=1:4
    fprintf('For index %d, we have %d \n',i,sum(mxreg==i));  
end

end
