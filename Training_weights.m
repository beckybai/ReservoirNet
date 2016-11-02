function [newWeights, trainingResults,rateList,testingResult] = ...
    Training_weights(Input, WMC, old_newWeights, time_s, train_para,test_para,...
    fireatlast,tr)

trainingResults = [];
dt = time_s.dt;
tau = time_s.tau;
simutime_len = length(time_s.simuTime);
%wo1 = init_weights_s.weight_CP_DM1;
%wo2 = init_weights_s.weight_CP_DM2;
wo1 = old_newWeights.weight_WMC_DM1;
wo2 = old_newWeights.weight_WMC_DM2;

num_train = 50;
test_para(1)= 30;
delta = train_para(2);
eta = 0.0001;


% set the training data
training_data_list = tr(:,1:2);



for k = 1:num_train
    % get the stimulus
    input_F = zeros(1, simutime_len);
    gainF1 = training_data_list(k, 1) ;  % presentation of stimulus f1
    gainF2 = training_data_list(k, 2)  ; % presentation of stimulus f2
    input_F(1, time_s.t1:time_s.t1+time_s.sdur) = gainF1;
    input_F(1, time_s.t2:time_s.t2+time_s.sdur) = gainF2;
    
    % initial the network of WMC
            r_WMC = (fireatlast(k,:))';
		    v1 = wo1'*r_WMC;
%		    v1 = activity2rate(v1,aaa);
		    v2 = wo2'*r_WMC;
%		    v2 = activity2rate(v2,aaa);

		    pa = 1./(1+exp(delta*(v2-v1)));
		    a = v1>v2;           
		    if (gainF1>gainF2)== a
			rw=2;
		    else
			rw=0;
            end

		%	r_WMC
		    if a	
                wo1 = wo1 + eta*(rw-pa)*r_WMC*v1;
   %             wo1(init_weights_s.weight_WMC_DM1==0)=0;
                wo1 = wo1/norm(wo1);
	%           wo1 = wo1/v1;
            else
				wo2 = wo2 + eta*(rw-1+pa)*r_WMC*v2;			
    %            wo2(init_weights_s.weight_WMC_DM2==0)=0;
				wo2 = wo2/norm(wo2);
			end
%			wo2 = wo2/v2;

            if gainF1>gainF2
                    trainingResults = [trainingResults;gainF1, gainF2, pa, rw];
            else
                    trainingResults = [trainingResults;gainF1, gainF2, 1-pa, rw];
            end
            %fprintf('train trial #: %d\n',k);

            
    w2dm{1}(:,k) = wo1;
	w2dm{2}(:,k) = wo2;
 
    if( k == num_train)
        % testing process
        gainF1;   % presentation of stimulus f1
        gainF2;  % presentation of stimulus f2
        newWeights.weight_WMC_WMC = old_newWeights.weight_WMC_WMC;
        newWeights.weight_Input_WMC = old_newWeights.weight_Input_WMC;
        %newWeights.weight_WMC_CP = init_weights_s.weight_WMC_CP;
        %newWeights.weight_CP_CP = init_weights_s.weight_CP_CP;
        newWeights.weight_WMC_DM1 = wo1;
        newWeights.weight_WMC_DM2 = wo2;
        [rateList, testingResult] = Testing(Input, WMC, old_newWeights, time_s, test_para);
        
        fprintf('train trial #: %d\n',k);
        rr = sum(testingResult(:,4)>0)/size(testingResult(:,4),1);
        testingResult
        fprintf('right rate #: %d\n',rr);
        %right = [right,rr];
        
        
        fprintf('%d\n',sum(r_WMC(:)>0.2)/size(r_WMC,1));
        fprintf('%d\n',sum(r_WMC(:)>0.5)/size(r_WMC,1));
        fprintf('%d\n',sum(r_WMC(:)>0.8)/size(r_WMC,1));
        fprintf('%d\n',sum(r_WMC(:)>0.95)/size(r_WMC,1));
    end
    fprintf('%3f %3f %f %f %d %d\n',gainF1, gainF2, v1,v2,v1>v2,gainF1>gainF2);

    
    if(mod(k,5) ==0)
        fprintf('train trial #: %d\n',k);
    end
    
end    
end
