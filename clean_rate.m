% This is a sparse firing task, When analysising it. We will clean up the
% ...unuseful things
clean_ratet = rateList{1,1};
num_test = size(rateList,1);
for i = 2:num_test
    clean_ratet = clean_ratet + rateList{i,1};
end

clean_rate_mean = (clean_ratet)/num_test;


clean_test_count = (clean_ratet/num_test>0.05);
clean_test_count_sum = sum(clean_test_count,2);
 figure;histogram(clean_test_count_sum);
%imagesc(clean_test_count);