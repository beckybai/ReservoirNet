%function [testingResult,rateList] = FlutterMain(tc,gain_factor)

% The model wigh CP on delayed flutter comparison
% disp('Clearing workspace.');
%
%close al;
clear
gain_factor = 1.5;
tc = 3;



%store_testing = cell(num_simulations, 1);
%store_training = cell(num_simulations,1);
num_train = 200;
num_test = 100;  
delta_const = 100;
min_stimulus = 0.1;
max_stimulus = 1;
noiseGain = 0.001;
x_ini = 0.001;      

ttq= [];

%change the property of the reservoir  network
p_list = 0:0.1:1;
num_simulations = 1:7;
i_num = 0;


for s_iter = num_simulations
    for p_value = p_list
    i_num = i_num + 1;
    % initial the model
    [Input, WMC, ForwardWeight] = InitNetwork();
    
    % seting the connections of the model
    init_weights_s = SetConnection(Input, WMC, ForwardWeight,p_value);
    
    % seting the upon of time
    time_s = SetTime(); 
   
    gain = (max(abs(eig(init_weights_s.weight_WMC_WMC))))/gain_factor;
    fprintf('the gain is %d\n', 1/gain );
    eta = 1/3000;

    train_para = [num_train, delta_const, eta, min_stimulus, max_stimulus, noiseGain, x_ini,gain,tc];
    
    test_para = [num_test, delta_const, min_stimulus, max_stimulus, noiseGain, x_ini,gain,tc];
    
    % training process
    [newWeights, trainingResult,rateList,testingResult] = Training(Input, WMC, init_weights_s, time_s, train_para,test_para,ttq);

    train_para(8) = gain;
    train_para(3)= eta/10;

    [newWeights, trainingResult,rateList,testingResult] = Training(Input, WMC, newWeights, time_s, train_para,test_para,ttq);

	p_rightrate = sum(testingResult(:,4)>0)/num_test;

	
        wholetuning;
	time_size = size(fire,2);
  	pf = figure;
        for o = 5:5:20
            subplot(2,2,o/5);
            hold on;
            
            clear fireplot;
            for p = 1:time_size
                fireplot(p,:) = fire{1,p}(find(1:1200),o);
            end
            pic_num = 20;
            
            for p = 1:pic_num
                plot(fireplot(:,p));
            end
          %  title(strcat(num2str(testingResult(f_j,1)),':',num2str(testingResult(f_j,2))));
            hold off;
             
        end
	

	num_card_base = strcat('b_',num2str(p_value),'_',num2str(s_iter),'_',num2str(p_rightrate));


%	nw{i_num} = newWeights;
%	tr{i_num} = 	
	save_path = sprintf('%s.mat',num_card_base);
	save_pic1 = sprintf('ra_%s.png',num_card_base);
	save_pic2 = sprintf('re_%s.png',num_card_base);
	b_testresult{i_num} = testingResult;	
	save(save_path,'testingResult','newWeights','fireatlast');
        saveas(pf,save_pic1);
        close;
 	p2 = figure;
        valid_points;
        saveas(p2,save_pic2);
        close;
 
    end
end
%save(strcat('Result_', date), 'store_training', 'store_testing');
