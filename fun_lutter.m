function testingResult = fun_lutter(gain_factor,tc_factor)

num_simulations = 1;
store_testing = cell(num_simulations, 1);
store_training = cell(num_simulations,1);

num_train = 300;
num_test = 100;
delta = 10;
min_stimulus = 0.1;
max_stimulus = 1.2;
noiseGain = 0.01;
x_ini = 0.001;

tc = 1/1.3;


store_testing = cell(num_simulations, 1);
store_training = cell(num_simulations,1);

for is = 1:num_simulations
    
    % initial the model
    [Input, WMC, ForwardWeight] = InitNetwork();
    
    % seting the connections of the model
    init_weights_s = SetConnection(Input, WMC, ForwardWeight);
    
    % seting the upon of time
    time_s = SetTime();
    
%    gain = abs(max(eig(init_weights_s.weight_WMC_WMC)));
%    tc =1;
    gain = abs(max(eig(init_weights_s.weight_WMC_WMC)))/gain_factor;
    tc = 1/ tc_factor;
 %   tc = 1/1.3;
    eta = 1/(1200)/10/gain;

    
    train_para = [num_train, delta, eta, min_stimulus, max_stimulus, noiseGain, x_ini,gain,tc];
    
    test_para = [num_test, delta, min_stimulus, max_stimulus, noiseGain, x_ini,gain,tc];
    
    % training process
    [newWeights, trainingResult,rateList,testingResult] = Training(Input, WMC, init_weights_s, time_s, train_para,test_para);
    %     save(strcat('Rate_', num2str(is), '_', date), 'rateList');
    %     save(strcat('Network_', num2str(is), '_', date), 'str_network');
    
end
save(strcat('Result_2', num2str(gain_factor*100),'_',num2str(tc_factor*100)), 'newWeights', 'testingResult');

end