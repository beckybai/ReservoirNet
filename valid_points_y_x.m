% for find the right confidential region.

f1 = testingResult(:,1);
f2 = testingResult(:,2);
nt = size(testingResult,1);
s11 = sum((f1-mean(f1).^2));
s22 = sum((f2-mean(f2).^2));
s12 = sum((f1-mean(f1).*(f2-mean(f2))));
p = 3; %the number of the regreesion factor
%nt = 40; %the test number

x1 = 2.8603; %95% confidence 
x2 = 4.36; %99 confidence
F = fpdf([x1,x2],p,nt-p);
F1 = F(1);
F2 = F(2);


t = 2;% we have 5 points in totoal now
ft = fire{t}';
clear all_b;
all_b = [];

regfact = zeros(num_neuron,4);
%figure2 = figure;
%figure1 = figure;
%figure;
find_tot_xy = 0;
find_xy_list = [];

for i=1:size(ft,2)
    if(mean(ft(:,i)>1.95)) & ~ignore1
        large = large + 1;
        continue;
    end
    if(mean(ft(:,i) < 0.05))& ~ignore0
        small = small + 1;    
        continue;
    
    else
        valued_num = valued_num + 1;
   %     valued_index(i) = 1;
   %     valued_fireing = [valued_fireing  ft(:,i)];
        nowfiring = ft(:,i);
        % FOUR KIND OF REGRESSION RAW DATA
        f = zeros(size(ft,1),4);
        f(:,1) = f1;
        f(:,2) = f2;
        f(:,3) = f1-f2;
        f(:,4) = f1+f2;
        xf1 = [ones(size(ft,1),1) f1];
        xf2 = [ones(size(ft,1),1) f2];
        xf1_2 = [ones(size(ft,1),1) f1-f2];
        xf12 = [ones(size(ft,1),1) f1+f2];


        [b,bint1,r1,rint1,s] = regress(nowfiring,[xf1,f2]);
        
   %     regfact(valued_num,: ) = s(:,1);
        s2 = ([ones(size(ft,1),1),f1-mean(f1),f2-mean(f2)]*b - nowfiring)'*([ones(size(ft,1),1),f1-mean(f1),f2-mean(f2)]*b - nowfiring)/(nt-p);
        K1 = s2*p*F1;
        K2 = s2*p*F2;
        
        
        % For solving the b1 = -b2 equation.
        a1 = s11+s22-s12;
        b1 = -2*b(2)*s11+2*b(3)*s22+2*(b(2)-b(3))*s12;
        c1 = b(2)^2*s11+b(3)^2*s22+2*b(2)*b(3)*s12-K1;
        x1 = roots([a1,b1,c1]); 
        
   %     fprintf('The answer is %d, %d \n',min(x1),max(x1));
         plot([min(x1),max(x1)],[0,0],'--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
       hold on;
        
        % For f1 task , b1 = 0 equation
        a2 = s22;
        b2 = -2*b(3)*s22-2*b(2)*s12;
        c2 = b(3)*b(3)*s22 - K2 + 2*b(2)*b(3)*s12 + b(2)*b(2)*s11;
        x2 = roots([a2,b2,c2]);
        
  %      fprintf('The answer is %d, %d \n',min(x2),max(x2));
          plot([min(x2),max(x2)],[1,1],'--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
               
        %For f2 task, b2 = 0 equation
        a3 = s11;
        b3 = -2*b(2)*s11 - 2*b(3)*s12;
        c3 = b(3)*b(3)*s22 - K2 + 2*b(2)*b(3)*s12 + b(2)*b(2)*s11;
        x3 = roots([a3,b3,c3]);
         
 %       fprintf('The answer if %d, %d \n\n',min(x3),max(x3));
         plot([min(x3),max(x3)],[2,2],'--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
 
        hold off;
        
        if(max(x2)<max(x1)&& min(x1)<min(x2))
            if(min(x3)>min(x1)&& max(x3)<max(x1))
                find_tot_xy = find_tot_xy+1;
                find_xy_list = [find_xy_list;[i,b']];
                fprintf('Find One %d\n\n\n\n',i)
            end
        end
        
          
        
%        [x, fv, ef, out, jac ] = fsolve(@f_jcr, x0, [],[K1,K2,b(2),b(3),s11,s22,s12]);
   
%        scatter(b(2),b(3));
 %       hold on;
 %       plot(-1:0.1:1,-1:0.1:1);
 %       plot(-1:0.1:1,1:-0.1:-1);
 %       hold off;
        
        all_b = [all_b ;[b(1:3,:)',s(1)]];                                                               ,;
    end 
end

fprintf('The abnormal small number is %d\n',small);
fprintf('The abnormal large number is %d\n',large);

