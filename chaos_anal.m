
t = 4;
dt = 0.005;
bins = t/dt;
distance = zeros(bins+1);

x0_WMC = x_ini*randn(WMC.numNeurons, 1);
x_WMC = x0_WMC;
r_WMC = activity2rate(x_WMC,1);

x0_WMC_C = x_ini*randn(WMC.numNeurons, 1);
x_WMC_C = x0_WMC_C;
r_WMC_C = activity2rate(x_WMC_C,1);


%r_WMC = rand(1200,1);
%r_WMC_C = randn(1200,1);
norm_rs = norm(r_WMC_C);
distance(1) = 10^(-8);
mul_norm_rs = norm_rs/distance(1);
r_WMC_C = r_WMC + r_WMC_C/sqrt(mul_norm_rs);




for i = 1:bins
    rhs = -x_WMC+init_weights_s.weight_WMC_WMC*r_WMC/gain +noiseGain*randn(WMC.numNeurons,1);
    x_WMC = x_WMC+dt *rhs;
    r_WMC=activity2rate(x_WMC,1);
    
    rhs_c = -x_WMC_C+init_weights_s.weight_WMC_WMC*r_WMC_C/gain + noiseGain*randn(WMC.numNeurons,1);
    x_WMC_C = x_WMC_C+dt *rhs_c;
    r_WMC_C=activity2rate(x_WMC_C,1);
    
    distance(i+1) = norm(r_WMC-r_WMC_C);
    r_WMC_C = r_WMC_C + distance(i+1)/distance(1)*(r_WMC_C - r_WMC);
    
end

ly = mean(log(distance(2:bins+1)/distance(1)));
fprintf('%f',ly);