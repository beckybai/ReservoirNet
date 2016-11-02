figure;
for i = 2:5 
    subplot(2,2,i-1);
    f = fire{i}';
    all_b = reg4analydata_old(f,testingResult);
    
    scatter(all_b(:,1),all_b(:,2));
    hold on
    plot(-1:0.1:1,-1:0.1:1);
    plot(-1:0.1:1,1:-0.1:-1);
    hold off
    xlim([-1,1]);
    ylim([-1,1]);
    
end 

figure
for i = 2:5 
    subplot(2,2,i-1);
    f = fire{i}';
    [all_b ,all_s]= reg4analydata_old(f,testingResult);
    
    scatter(all_s(:,1),all_s(:,2));
    hold on
    plot(-1:0.1:1,-1:0.1:1);
    plot(-1:0.1:1,1:-0.1:-1);
    hold off
    xlim([-1,1]);
    ylim([-1,1]);
    
end 