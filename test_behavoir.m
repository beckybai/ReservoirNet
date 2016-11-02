%te is the best model.

clear t;
load te1
t{1} = testingResult;
load te2
t{2} = testingResult;
load tb1
t{3} = testingResult;
load tb2
t{4} = testingResult;
load tq2
t{5} = testingResult;
load tq3
t{6} = testingResult;
load tc1
t{7} = testingResult;
load tc2
t{8} = testingResult;
load tqw1
t{9} = testingResult;
load tqw2
t{10} = testingResult;
load tr1
t{11} = testingResult;
load tr2
t{12} = testingResult;
load tx1
t{13} = testingResult;
load tx2
t{14} = testingResult;
load sp1
t{15} = testingResult;
load sp2
t{16} = testingResult;
load twrong1 
%t{17} = testingResult;
load twrong2
%t{18} = testingResult;

n = size(t,2)
t_tot = t{1};
for i = 2:n
    t_tot = t_tot + t{i};
end


t_average = t_tot/n;

figure;surf(0.1:0.9/14:1.0,0.1:0.9/14:1.0,reshape(t_average(:,4),15,15));
hold on;
imagesc(0.1:0.9/14:1.0,0.1:0.9/14:1.0,reshape(t_average(:,4),15,15));