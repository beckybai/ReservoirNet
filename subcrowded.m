
num_neuron = size(fire{1},1);
rate_point  = size(fire,2);

mean_fire =  zeros(num_neuron,1);

for i = 1:rate_point 
    f = fire{i}';
    meanf = mean(f);
    mean_fire = mean_fire + meanf';
end

mean_fire = mean_fire/rate_point;

index = boolean(zeros(num_neuron,1));

index(mean_fire>0.1) = true;
index(mean_fire>0.9) = false;

valid_neuron = sum(index);
for i  = 1:rate_point
    f = fire{i}';
    fire{i} = f(:,index)';
end