
neuron_num = 800;
time_bin = 1000;
test_num = 60;

a = rateList{1,1}(((rateList{1,1}(:,900)) > 0.1),900);
index = (rateList{1,1}(:,900)) > 0.1
valid_num = sum(a>0);

size(rateList{1,1}(1,:)-1)
list = zeros(test_num,sum(a>0),size(rateList{1,1}(1,:),2));

frequency = store_testing{1,1}(:,1:2);

%delete the last zero
for i = 1:test_num
    rateList{i,1} = rateList{i,1}(:,1:1000);
    list(i,:,:) = reshape(rateList{i,1}(index,:),size(list(i,:,:)));
end

b0 = zeros(neuron_num,800,2);

for i=1:800
    for j = 1:valid_num
        newlist = permute(list,[2,3,1]);
        newlist2    = newlist(j,i,:);        
        bbb = regress (newlist2(:),[ones(test_num,1),frequency(1:test_num,1)]);
        b0(j,i,:) = bbb(:);  
    end
    if(mod(i,20)==0)
        fprintf('%d/n',i);
    end
end


b = zeros(neuron_num,201,3);
for i=800:time_bin
    for j = 1:valid_num
        newlist = permute(list,[2,3,1]);
        newlist2 = newlist(j,i,:);        
        bbb = regress (newlist2(:),[ones(test_num,1),frequency(1:test_num,:)]);
        b(j,i,:) = bbb(:);  
    end
end

save regression_outcome b0 b
