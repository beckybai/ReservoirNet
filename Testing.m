function [rateList, testingResult,t_v1,t_v2] = Testing(Input, WMC, newWeights, time_s, test_para)


dt = time_s.dt;
tau = time_s.tau;
%tau1 = time_s.tau1;
%tau2 = time_s.tau2;
t_v1 = [];
t_v2 = [];

wo1 = newWeights.weight_WMC_DM1;
wo2 = newWeights.weight_WMC_DM2;


num_test = test_para(1);
delta = test_para(2);
min_stimulus = test_para(3);
max_stimulus = test_para(4);
noiseGain = test_para(5)*0.2;
x_ini = test_para(6);
gain = test_para(7);
tc = test_para(8);
dt_tau = tc*dt/tau;
%dt_tau = tc*dt/tau;

%dt_tau = dt/tau;
num_ex = 1200*4/5;



% set the training data
testing_data_list = SetTestingData(min_stimulus, max_stimulus, num_test);

testingResult = [];
rateList = cell(num_test, 1);
%rateSim_CP = zeros(CP.numNeurons, 1);

for k = 1:num_test
    
    simutime_len = length(time_s.simuTime);
    rateSim_WMC = zeros(WMC.numNeurons, (simutime_len));
    
    % get the stimulus
    input_F = zeros(1, simutime_len);
    gainF1 = testing_data_list(k, 1) ;  % presentation of stimulus f1
    gainF2 = testing_data_list(k, 2)  ; % presentation of stimulus f2
    input_F(1, time_s.t1:time_s.t1+time_s.sdur) = gainF1;
    input_F(1, time_s.t2:time_s.t2+time_s.sdur) = gainF2;
    
    % initial the network of WMC
    x0_WMC = x_ini*randn(WMC.numNeurons, 1);
    x_WMC = x0_WMC;
    r_WMC = activity2rate(x_WMC,1);
    % initial the CP network
    %     r_CP = zeros(CP.numNeurons, 1);
    %     y = zeros(CP.numNeurons, time_s.ddur);
    
    % learning process in a trial
    ti = 0;
    ra =floor(size(time_s.simuTime,2)*0.6);
    rand_delay = 0;
 %   rand_delay = floor((rand(1,1)-0.5)/2*100)/100;
    time_s.simuTime = 0:dt:(time_s.simuTime(end)+rand_delay);
    
    for t = time_s.simuTime
        ti = ti + 1;
        % the responses of the WMC
        %         x_WMC = (1.0-dt_tau)*x_WMC + newWeights.weight_WMC_WMC*(r_WMC*dt_tau) + ...
        %             newWeights.weight_Input_WMC*(input_F(ti)*dt_tau) + noiseGain*randn(WMC.numNeurons, 1).*dt_tau;
        %         r_WMC = activity2rate(x_WMC);
        
        tini=0;
        deltat=dt;
        
        
        if tini+ti*deltat < 0.5 % before s1
            s=0;
        elseif tini+ti*deltat < 1.0 % presentation of s1
            s=gainF1;
        elseif tini+ti*deltat < 4.0 + rand_delay % delay
            s=0;
        elseif tini+ti*deltat < 4.5 + rand_delay % presentation of s2; decision period 1
            s=gainF2;
        else % decision period 2
            s=0;
        end

        rhs = -x_WMC+(newWeights.weight_WMC_WMC*r_WMC/gain+newWeights.weight_Input_WMC*s+noiseGain*randn(WMC.numNeurons,1));
                
	x_WMC = x_WMC+dt_tau *rhs;
%        x_WMC(num_ex+1:end,:) = x_WMC(num_ex+1:end,:)+dt_tau2*rhs(num_ex+1:end,:);
	r_WMC=activity2rate(x_WMC,1);
        
%         rhs = -x_WMC+(newWeights.weight_WMC_WMC*r_WMC/gain+newWeights.weight_Input_WMC*s+noiseGain*randn(WMC.numNeurons,1));
%         x_WMC = x_WMC+dt_tau *rhs;
%         r_WMC=activity2rate(x_WMC,1);
%         
        rateSim_WMC(:,ti) = r_WMC;
        %    	if t ==     time_s.simuTime(test_size)
        if t == time_s.simuTime(end)
           %  trans_winner = reshape(r_WMC,size(r_WMC,1)/10,10);
           % r_WMC = max(trans_winner')';
%             trans_winner = reshape(r_WMC,size(r_WMC,1)/10,10)';
%            e_trans_winner = exp(trans_winner);
%            trans_winner = e_trans_winner./repmat(sum(e_trans_winner),10,1);
%            r_WMC = reshape(trans_winner,size(r_WMC,1),1);
%            
            v1 = wo1'*r_WMC;
%              v1 = activity2rate(v1,aaa);
%            t_v1(:,k)=v1;
            v2 = wo2'*r_WMC;
 %             v2 = activity2rate(v2,aaa);
%            t_v2(:,k)=v2;
            pa = 1./(1+exp(delta*(v2-v1)));
            a = v1>v2;

		    if (gainF1>gainF2)== a
                rw=1;
            elseif gainF1 < gainF2 == a
                rw=0;
            else
                rw  = (rand(1,1)>0.5);
            end
% %           v1 = wo1'*r_WMC;
% %  %         v1 = activity2rate(v1);
% %           pa = 1./(1+exp(delta*(v1)));
% %           a = gainF1>gainF2;
% %           b = v1>0;
% %           
% %           if a == b
% %               rw = 1;
% %           else
% %               rw = 0;
% %           end
% % 
% %          
% %           wo1 = wo1/norm(wo1);
% %           
% %           v2 = wo2'*r_WMC;
% %   %        v2 = activity2rate(v2);
% %           pa = 1./(1+exp(delta*(-v2)));
% %           a = gainF1>gainF2;
% %           b = v2<0;
% %           
% %           if a == b
% %               rw = 1;
% %           else
% %               rw = 0;
% %           end


            if gainF1>gainF2
                testingResult = [testingResult;gainF1, gainF2, pa, rw,v1,v2];
            else
                testingResult = [testingResult;gainF1, gainF2, 1-pa, rw,v1,v2];
            end
            break;
            
        end
        
    end
    
    rateList{k} = rateSim_WMC;
    
    %fprintf('test trial #: %d\n',k);
    
end
end

function gainList_test = SetTestingData(min_stimulus, max_stimulus, num_test)

gainList1_test = min_stimulus + (max_stimulus-min_stimulus)/num_test*(1:num_test)+0.1*randn(1,num_test);
gainList2_test = min_stimulus + (max_stimulus-min_stimulus)/num_test*(num_test:-1:1)+0.1*randn(1,num_test);
gainList_test = [gainList1_test', gainList2_test'];
sum(gainList_test(:,1) > gainList_test(:,2))

train_stimulus_range = max_stimulus - min_stimulus;
train_unit = train_stimulus_range/(sqrt(num_test)-1);
gg = min_stimulus:train_unit:min_stimulus+(sqrt(num_test)-1)*train_unit;
g1 = repmat(gg,sqrt(num_test),1);
g1 = reshape(g1,num_test,1);
g2 = repmat(gg',sqrt(num_test),1);

gainList1_train = min_stimulus + (max_stimulus-min_stimulus)*(1/2+randn(num_test, 1)/5);
gainList2_train = min_stimulus + (max_stimulus-min_stimulus)*(1/2+randn(num_test, 1)/5);
gainList_train = [gainList1_train, gainList2_train];
%index = randperm(num_test);
gainList_test = [g1,g2];
%gainList_test = gainList_train(index,:);
gainList1_test = min_stimulus + (max_stimulus-min_stimulus)/num_test*(1:num_test)+0.1*randn(1,num_test);
gainList2_test = min_stimulus + (max_stimulus-min_stimulus)/num_test*(num_test:-1:1)+0.1*randn(1,num_test);
%gainList_test = [gainList1_test', gainList2_test'];

end
