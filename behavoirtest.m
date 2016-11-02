function dif_rate=behavoirtest(index_me,rate)
num_test = size(index_me,1);
num_class = size(index_me,2);
dif_rate = zeros(num_class,1);

for i = 1:num_test
    for j = 1:num_class
        index = find(index_me(i,:)==j);
        dif_rate(j,1)=dif_rate(j,1)+rate(i,index);
    end
end
end