figure1 = figure;
figure2 = figure;
for i = 2:5 
    subplot(2,2,i-1);
    f = fire{i}';
    [all_b ,all_s]= reg4analydata(f,testingResult);
    
%     scatter(all_b(:,1),all_b(:,2));
%     hold on
%     plot(-1:0.1:1,-1:0.1:1);
%     plot(-1:0.1:1,1:-0.1:-1);
%     hold off
    xlim([-1,1]);
    ylim([-1,1]);
    
end 

b = {};
figure2 = figure;
% for i = 2:5 
%     subplot(2,2,i-1);
%     f = fire{i}';
%     [all_b ,all_s]= reg4analydata(f,testingResult);
%     
%     scatter(all_s(:,1),all_s(:,2));
%     hold on
%     plot(-1:0.1:1,-1:0.1:1);
%     plot(-1:0.1:1,1:-0.1:-1);
%     hold off
%     xlim([-1,1]);
%     ylim([-1,1]);
%     
% end 


for i = 1:5 
%    subplot(2,2,i-1);
    f = fire{i}';
    [all_b ,all_s]= reg4analydata(f,testingResult);
    b{i} = all_b;
    
    scatter(all_b(:,1),all_b(:,2));
    b{i} = all_b;
%     hold on
%     plot(-1:0.1:1,-1:0.1:1);
%     plot(-1:0.1:1,1:-0.1:-1);
%     hold off
    xlim([-1,1]);
    ylim([-1,1]);
end 




figure;

for num = 1:size(b{1},1)
    for i = 1:size(b,2)
        x(i) = b{i}(num,1);
        y(i) = b{i}(num,2);
        
    end
    
    plot(x,y);
    for i = 1:size(b,2)
        text(x(i),y(i),num2str(i));
    end
end