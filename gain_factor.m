%script to do a lot of experiments
clear;
gain_list = 0.8:0.1:2.0;
tc = 1.5:0.1:5;
tot_size = size(gain_list,2)*size(tc,2);
clear rightrate test_result;

f_num = 1;
for f_j = 1:size(gain_list,2)
    g_t = gain_list(f_j);
    for f_k = 1:size(tc,2)
        f_t = tc(f_k);
        f_t
        g_t
        [test_result{f_num},rateList]=FlutterMain(f_t,g_t);
        rightrate(f_num) = sum(test_result{f_num}(:,4))/size(test_result{f_num},1);
        
        testingResult = test_result{f_num};
        observetunning;
        wholetuning;
        test_size = size(test_result{f_num},1);
        time_size = size(fire,2);
        pf =figure;
        
        for o = 5:5:20
            subplot(2,2,o/5);
            hold on;
            
            clear fireplot;
            for p = 1:time_size
                fireplot(p,:) = fire{1,p}(find(1:1200),o);
            end
            pic_num = 20;
            
            for p = 1:pic_num
                plot(fireplot(:,p));
            end
            title(strcat(num2str(testingResult(f_j,1)),':',num2str(testingResult(f_j,2))));
            hold off;
          
        end
          saveas(pf,strcat('a',num2str(f_t),'_',num2str(g_t),'_',num2str(rightrate(f_num)),'.png'));
            close;
        p2 = figure;
        valid_points;
        saveas(p2,strcat('ar',num2str(f_t),'_',num2str(g_t),'_',num2str(rightrate(f_num)),'.png'));
        close; 
        f_num = f_num+1;
        f_j = f_j+1;
        f_k = f_k+1;
        
    end
end


