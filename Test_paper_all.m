time = 10;
for i = 2:9
        fprintf('This test have i = %d\n,',i);

        [~,~,newWeights] = Testing_paper(Input, WMC, newWeights, time_s, test_para,time,i,i+1);     
        [~,~,newWeights] = Testing_paper(Input, WMC, newWeights, time_s, test_para,time,i,i-1);
        
      %  [rateList, testingResult] = Testing(Input, WMC, newWeights, time_s, test_para)
        
        
%        Testing_paper(Input, WMC, CP, newWeights, time_s, test_para,time,i,i);
        fprintf('--- --- \n');
end