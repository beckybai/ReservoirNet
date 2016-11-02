close all;
thecrucialtruth;

observetunning;
figure;
reg5points;
figure
newreg_nf
scatter(all_b(:,2),all_b(:,3),10);
axis([-1,1,-1,1]);
hold on
plot(-1:0.1:1,1:-0.1:-1);
hold off; 


w = eig(init_weights_s.weight_WMC_WMC/gain);
figure
scatter(real(w),imag(w));

%figure
wholetuning;
%reg4analydata_nf;
tears;
valid_points