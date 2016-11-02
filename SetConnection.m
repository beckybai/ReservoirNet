

% 2015-11-15-4:00 Becky for a new WMC-WMC initialization

function init_weights_s = SetConnection(Input, WMC, ForwardWeight,p_value)
%seed = 520;
% set the synaptic weights in the WMC
excited_num = WMC.numNeurons / 5 * 4;
inhibited_num = WMC.numNeurons - excited_num;
% e_e = abs(full(sprandn(excited_num,excited_num,0.1)));
% e_i = -abs(full(sprandn(excited_num,inhibited_num,0.42;
% i_e = abs(full(sprandn(inhibited_num,excited_num,0.08)));clear
% i_i = -abs(full(sprandn(inhibited_num,inhibited_num,0.3)));
%%
%_____________________



fact = 1;%
%e_e = abs((sprand_me(excited_num,excited_num,fact*0.1)));
part = 96;%86
%part = 320;%82/85
%part = 160;%95/88
n = 960;
k = 48;
t = k*2;
% p is a variable of this function.(reconnect possibility)
%p = 0.2;
e_e = zeros(n,n);

for i = 1:n
	if i-k-1<0
	  e_e(i,1:i+k) = lognrnd(0,1,[1,i+k]);
	  left = abs(i-k-1);
	  e_e(i,n-left+1:n)=lognrnd(0,1,[1,left]);
	elseif i+k >n
	  e_e(i,i-k:n) = lognrnd(0,1,[1,n+k-i+1]);
	  left = abs(k-(n-i));
	  e_e(i,1:left) = lognrnd(0,1,[1,left]);
	else 
	  e_e(i,i-k:i+k) = lognrnd(0,1,[1,2*k+1]);
	end
	e_e(i,i)=0;
end

size(e_e)


if p_value == 0

else
   for i = 1:n
	x = e_e(i,:);
	y = find(x);
	yr = randperm(2*k);
%	size(y)
%	size(yr)
%	y
%	yr(1,1:round((2*k)*p))
	
%	y(1,yr(1,1:round((2*k)*p)))
	e_e(i,y(1,yr(1,1:round((2*k)*p_value))))=0;
	
	yr2 = randperm(n);
	e_e(i,yr2(1,1:round((2*k)*p_value)))=lognrnd(0,1,[1,round((2*k)*p_value)]);
	%new weight connection
	e_e(i,i)=0;
   end 
end




for i = 1:part:960-part+1   
%    e_e(i:i+part-1,i:i+part-1)=abs(sprand_me(part,part,96/part));
end

%e_e = e_e + abs((sprand_me(excited_num,excited_num,0.01)));
e_i = -abs((sprand_me(excited_num,inhibited_num,fact*0.4)));
i_e = abs((sprand_me(inhibited_num,excited_num,fact*0.1)));
i_i = -abs((sprand_me(inhibited_num,inhibited_num,fact*0.4)));

%%

weight_WMC_WMC = [[e_e e_i];[i_e i_i]];

%weight_WMC_WMC = randn(WMC.numNeurons, WMC.numNeurons)*WMC.gain*scale; 

%
%weight_WMC_WMC = sprandn(WMC.numNeurons, WMC.numNeurons, WMC.prob); 
%weight_WMC_WMC = full(weight_WMC_WMC);

scale = 1.0/sqrt(fact*0.1 * excited_num+ 0.4*fact*inhibited_num);

%scale = 1.0/sqrt(WMC.numNeurons*WMC.prob);
weight_WMC_WMC = 1*weight_WMC_WMC*scale; 



% the connections between input and WMC layers
weight_Input_WMC = (sprand_me(WMC.numNeurons, Input.numNeurons, 0.5));

%weight_Input_WMC = [weight_Input_WMC; zeros(inhibited_num,1)];
%weight_Input_WMC =  full(weight_Input_WMC);
weight_Input_WMC =  ForwardWeight.Input_WMC_gain*weight_Input_WMC;
%weight_Input_WMC = ones(WMC.numNeurons, Input.numNeurons)*0.8;


% the connections between WMC and output

weight_WMC_DM1 =abs(sprand_me(WMC.numNeurons, Input.numNeurons, 0.5));
%weight_WMC_DM1(481:960,:)=0;
%actor* (rand(WMC.numNeurons,1));
weight_WMC_DM2 = abs(sprand_me(WMC.numNeurons, Input.numNeurons, 0.5));
%weight_WMC_DM2(1:600,:)=0
%factor* (rand(WMC.numNeurons,1));
%weight_WMC_DM1 = (rand(199,1))*ForwardWeight.WMC_DM_gain;
% weight_WMC_DM2 = (rand(199,1))*ForwardWeight.WMC_DM_gain;


%weight_WMC_DM1  = full(sprandn(WMC.numNeurons,1,1));
%weight_WMC_DM2 = full(sprandn(WMC.numNeurons,1,1));
%weight_WMC_DM1 = weight_WMC_DM1/norm(weight_WMC_DM1);
%weight_WMC_DM2 = weight_WMC_DM2/norm(weight_WMC_DM2);
%weight_WMC_DM1 = weight_WMC_DM1;
%weight_WMC_DM2 = weight_WMC_DM2;


% initial the output conncetions
%weight_WMC_DM1 = (rand(WMC.numNeurons,1));
%weight_WMC_DM2 = (rand(WMC.numNeurons,1));
weight_WMC_DM1 = weight_WMC_DM1./norm(weight_WMC_DM1);
weight_WMC_DM2 = weight_WMC_DM2./norm(weight_WMC_DM2);

init_weights_s.weight_WMC_WMC = weight_WMC_WMC;
init_weights_s.weight_Input_WMC = weight_Input_WMC;
init_weights_s.weight_WMC_DM1 = weight_WMC_DM1;
init_weights_s.weight_WMC_DM2 = weight_WMC_DM2;
