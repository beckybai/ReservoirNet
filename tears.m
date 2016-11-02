
meanfire = mean(fireatlast);
 meanfire(meanfire>0.90) = 0;
 mein = find(meanfire(1:960));
% miin = find(meanfire(961:1200));
 
 me = mean(meanfire(mein));
% mi = mean(meanfire(miin+960));
 %fprintf('%d %d ',me,mi);
 figure;
imagesc(fireatlast);



figure;
fprintf('valued size = %d',valued_num);
time_size = size(fire,2);
test_size = min(20,size(fire{1},2));

for j = 5:5:test_size
    subplot(2,2,j/5);
    hold on;
    clear fireplot;
    for i = 1:time_size
            fireplot(i,:) = fire{1,i}(find(valued_index),j);
    end
    pic_num = min(20,valued_num);
    
    for i = 1:pic_num
        plot(fireplot(:,i));
    end
    title(strcat(num2str(testingResult(j,1)),':',num2str(testingResult(j,2)),'/',num2str(valued_num)));
    hold off;
end

figure;


rand('seed',520);
s2_rr = randperm(1200);
s2_f = s2_rr(1:20);
%s2_f = [20,21];

k=0;
for j = [17,18,19,20];
    k = k+1;
    subplot(2,2,k);
    hold on;
    clear fireplot;
    for i = 1:time_size
            fireplot(i,:) = fire{1,i}(s2_f,j);
    end
    pic_num = min(20,valued_num);
    for i = 1:pic_num
        plot(fireplot(:,i));
    end
    title(strcat(num2str(testingResult(j,1)),':',num2str(testingResult(j,2)),'/',num2str(valued_num)));
    hold off;
end



% fprintf('%d %d\n ',me,mi);
fprintf('the valued number is %d\n',valued_num);
fprintf('shot size %d\n',size(intersect(find(valued_index),find(newWeights.weight_Input_WMC)),1));