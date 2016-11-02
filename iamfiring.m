wmc = init_weights_s.weight_WMC_WMC;
min_stimulus = 0.1;
max_stimulus = 1.2;
num_trains = 1;
gainList1_train = min_stimulus + (max_stimulus-min_stimulus)*rand(num_trains, 1);
gainList2_train = min_stimulus + (max_stimulus-min_stimulus)*rand(num_trains, 1);

num_test = 100;
ratehaha = zeros(size(wmc,1),num_test);
rawhaha = zeros(size(wmc,1),num_test);
nowrate = ones(size(wmc,1),1)*gainList1_train;
nowrate= activity2rate(nowrate,1);

for i =1:num_test
    ratehaha(:,i) = activity2rate(wmc*nowrate,1);
    rawhaha(:,i) = wmc*nowrate;
    nowrate = ratehaha(:,i);
end