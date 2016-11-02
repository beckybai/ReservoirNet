%??? ???????????????????
clear fire
num_neuron = size(rateList{1,1},1);
num_test = size(store_testing{1,1},1);
testingResult = store_testing{1,1};
%num_test = size(testingResult,1);

fireatlast = zeros(num_neuron,num_test);




for i = 1:num_test
    nowrate = rateList{i,1};
    fire{5}(:,i) = nowrate(:,1000);
    fire{1}(:,i) = nowrate(:,150);
    fire{2}(:,i) = nowrate(:,500);
    fire{3}(:,i) = nowrate(:,850);
    fire{4}(:,i) = nowrate(:,950);
    fireatlast(:,i) = nowrate(:,1000);
end 

fireatlast = fireatlast';


stimulus = testingResult(:,1:2);

stimulus(:,3) = stimulus(:,1)>stimulus(:,2);
stimulus(:,4) = stimulus(:,1)- stimulus(:,2);   
