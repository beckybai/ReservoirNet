
%caculate the firing rate change
%index = 151:2:165;
index = 7:30:218
pick_neuron =[1058
21
598
655
657
875
240
287
966
260
566
764
794
1030];
pick_neuron = reshape(pick_neuron,max(size(pick_neuron)),1)';
colOrd = [1,0,0;
          1,0.5,0.1;
    
            1,1,0; 
          0,1,0.5;
          0.5,0.8,0.1;
          0,0.8,1;
          0,0.6,1;
          0,0.4,1;
          ]
colOrd = colOrd(8:-1:1,:);
      
          
a = 1:940;
     


     
for nn = pick_neuron
    h_fig = figure('Visible', 'on');ii = 1;
    for i = index
        
        c = polyfit(a, rateList{i}(nn,a), 10);  %进行拟合，c为2次拟合后的系数
        d = polyval(c, a, 1);  
        col = colOrd(ii,:);
         
           
            plot(d,'LineWidth',2.5,'Color',col);
   %              plot(rateList{i}(nn,:),'LineWidth',3);
          
         hold on;ii=ii+1;
    end
   
    title(num2str(nn)); hold off;
    saveas(h_fig,strcat('f2_change/',num2str(3),num2str(nn),'.eps'),'psc2');
%    close(h_fig);

end
