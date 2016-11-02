%figure1 = figure;
%figure2 = figure;
close all

clear all_b

for i = 2:5 
    subplot(2,2,i-1);
    f = fire{i}';
    all_b(:,(3*(i-2)+1):3*(i-1))= reg4analydata(f,testingResult);
    
    scatter(all_b(:,3*(i-2)+2),all_b(:,3*(i-1)),10);
    hold on
    plot(-1:0.1:1,-1:0.1:1);
    plot(-1:0.1:1,1:-0.1:-1);
    hold off
    xlim([-1,1]);
    ylim([-1,1]);
    
end 

b = {};


%figure
%for i = 2:5 
%    subplot(2,2,i-1);
%    f = fire{i}';
%    [all_b ,all_s]= reg4analydata(f,testingResult);
%    
%    scatter(all_s(:,1),all_s(:,2));
%    hold on
%    plot(-1:0.1:1,-1:0.1:1);
%    plot(-1:0.1:1,1:-0.1:-1);
%    hold off
%    xlim([-1,1]);
%    ylim([-1,1]);
    
%end 


% for i = 1:50 
% %    subplot(2,2,i-1);
%     f = fire{i}';
%     [all_b ,all_s]= reg4analydata(f,testingResult);
%     b{i} = all_b;
%     
%     scatter(all_b(:,1),all_b(:,2));
%     hold on
%     plot(-1:0.1:1,-1:0.1:1);
%     plot(-1:0.1:1,1:-0.1:-1);
%     hold off
%     xlim([-1,1]);
%     ylim([-1,1]);
%     
% end 