% jiangdaolidehua...
num_neuron = size(fire{1},1);
rate_point  = size(fire,2);
k_list = zeros(num_neuron,rate_point);

rs = zeros(rate_point,1);
fired = zeros(num_neuron,rate_point);


for i = 1:41
    fprintf('%d\n',i);
    f = fire{i}';
    [all_k,all_r] = reg4analydata(f,testingResult);
    kf1 = all_k(:,1)';
    rf1 = all_r(:,1)';
    kf1(rf1<0.5) = -15;
    kf1(abs(kf1)<0.001) = -12;
    kf1(kf1>0) = 3;
    kf1(kf1<0) = -3;
    kf1(rf1<0.5) = -15;
    kf1(abs(kf1)<0.001) = -12;
    k_list(:,i) = kf1; 
    rs(i,1) = sum(rf1>0.8);
    fired(:,i) = rf1;
end



kf2 = zeros(num_neuron,1);


for i = 42:rate_point
    fprintf('%d\n',i);
    f = fire{i}';
    [all_k,all_r] = reg4analydata(f,testingResult);
    [max_r,max_rindex] = max(all_r(:,1:3)');
    [max_k,max_kindex] = max(abs(all_k(:,1:3)'));
    rs(i,1) = sum(max_r>0.8);
    kf2(max_r' < 0.5) = -15;
    kf2(abs(max_k)' < 0.001) = -12;   
    for mycolor=1:3
        for neuron = 1:(num_neuron)
            if(all_k(neuron,max_rindex(neuron))>= 0 & max_rindex(neuron) == mycolor)
                kf2 (neuron, 1) = mycolor*3;
 %            fprintf('%d',all_k(neuron,max_rindex(neuron)));
            else
                if(max_rindex(neuron) == mycolor & all_k(neuron,max_rindex(neuron))< 0)
                    kf2 (neuron,1 ) = -mycolor*3;
                end
            end
        end
    end
    kf2(max_r < 0.5) = -15;
    kf2(abs(max_k) < 0.001) = -12;   
    
    k_list(:,i) = kf2;
    fired(:,i) = max_r;
end

plot(rs);
