% for find the right confidential region.
%rateList = RL;testingResult= tr;
observetunning;

% for find the right confidential region.

f1 = testingResult(:,1);
f2 = testingResult(:,2);
nt = size(testingResult,1);
s11 = sum((f1-mean(f1)).^2);
s22 = sum((f2-mean(f2)).^2);
s12 = sum((f1-mean(f1)).*(f2-mean(f2)));
p = 3; %the number of the regreesion factor
%nt = 40; %the test number

F95 = 252.1957;
F99 = 6300.649; 
%F99 = 252.1957;
%F993 = 26.316;
%F992 = 62.79428;
%F952 = 62.79428;

t = 1;% we have 5 points in totoal now
ft = fire{t}';
clear all_b;
all_b = [];

regfact = zeros(num_neuron,4);
%figure2 = figure;
%figure1 = figure;
%figure;
observetunning

find_tot_x = 0;
find_x_list = [];
find_tot_y = 0;
find_y_list = [];
find_tot_xy = 0;
find_xy_list = [];
find_zero_list = [];
find_none_list = [];

all_F = [];
ignore1 = 1;
ignore0 = 1;

for i=1:size(ft,2)
    if(mean(ft(:,i)>1.95)) & ~ignore1
        large = large + 1;
        continue;
    end
    if(mean(ft(:,i) < 0.05))& ~ignore0
        small = small + 1;    
        continue;
    
    
    else
        flag = 1;
   %     valued_index(i) = 1;
   %     valued_fireing = [valued_fireing  ft(:,i)];
        nowfiring = ft(:,i);
        % FOUR KIND OF REGRESSION RAW DATA
        test_num = size(f1,1);
        
        x = [ones(test_num,1) f1 f2];
        
        
        [b,bint1,r1,rint1,s] = regress(nowfiring,x,0.01);

        
   %     regfact(valued_num,: ) = s(:,1);
        rss = (x*b - nowfiring)'*(x*b - nowfiring);
        R0 = [0,1,0;0,0,1];
        ga0= 0;
        R1 = [0,1,1];
        ga1 = 0;
        R2 = [0,1,0];
        ga2 = 0;
        R3 = [0,0,1];
        ga3 = 0;
        
        F0 = (ga0 - R0*b)'* (R0*inv(x'*x)*R0')^(-1)*(ga0 - R0*b)/(rss/(test_num-3))/2;
        F1 = (ga1 - R1*b)^2 * (R1*inv(x'*x)*R1')^(-1)/(rss/(test_num-3));
        F2 = (ga2 - R2*b)^2 * (R2*inv(x'*x)*R2')^(-1)/(rss/(test_num-3));
        F3 = (ga3 - R3*b)^2 * (R3*inv(x'*x)*R3')^(-1)/(rss/(test_num-3));
 %       fprintf('%d %d %d \n',F1,F2,F3);
        if(F0 < 99.482)
                        find_zero_list = [find_zero_list;[s(2) s(3) i,b']];
            flag = 0;
                    find_none_list = [find_none_list;[i,b' F1 F2 F3]];            
            continue;
        end

        
        %find x
        if(F1 > F99 && F2 > F95 && F3 < F99)
              flag = 0;   
                find_tot_x = find_tot_x+1;
                find_x_list = [find_x_list;[i,b']];
  %              fprintf('Find One %d\n\n\n\n',i)
                continue;
        end
        
        %find y
        if(F1 > F99 && F2 < F99 && F3 > F95)
                 flag = 0;
                find_tot_y = find_tot_y+1;
                find_y_list = [find_y_list;[i,b'] F1 F2 F3];
               continue;
  %              fprintf('Find One %d\n\n\n\n',i)
        end
        
        %find_xy
        if(F1 < F95 && F2 < F99 && F3 < F99)
            flag = 0;
                find_tot_xy = find_tot_xy+1;
                find_xy_list = [find_xy_list;[i,b' F1 F2 F3]];
                continue;
                %              fprintf('Find One %d\n\n\n\n',i)
        end
                
        
        
        if flag==1
  %      else
                    find_none_list = [find_none_list;[i,b' F1 F2 F3]];
          end        
        
%        [x, fv, ef, out, jac ] = fsolve(@f_jcr, x0, [],[K1,K2,b(2),b(3),s11,s22,s12]);
   
%        scatter(b(2),b(3));
 %       hold on;
 %       plot(-1:0.1:1,-1:0.1:1);
 %       plot(-1:0.1:1,1:-0.1:-1);
 %       hold off;
        all_F = [all_F ;F1,F2,F3];
        all_b = [all_b ;[b(1:3,:)',s(2)]];                 
    end 

end

%fprintf('The abnormal small number is %d\n',small);
%fprintf('The abnormal large number is %d\n',large);
figure;hold on;
if(~find_y_list)
scatter(find_y_list(:,3),find_y_list(:,4),50);
end

if(~find_xy_list)
scatter(find_xy_list(:,3),find_xy_list(:,4),10);
end

if(~find_x_list)
scatter(find_x_list(:,3),find_x_list(:,4),30);
end


xlim([-1,1]);
ylim([-1,1]);
a = -1:0.1:1;
plot(a,a);
plot(a,-a);
plot(a*0,-a);
plot(a,a*0);


hold off;

figure;
scatter(find_none_list(:,3),find_none_list(:,4),5);

