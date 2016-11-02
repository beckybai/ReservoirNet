
% for find the right confidential region.
%observetunning;
f1 = testingResult(:,1);
f2 = testingResult(:,2);
nt = size(testingResult,1);

s11 = sum((f1-mean(f1)).^2);
s22 = sum((f2-mean(f2)).^2);
s12 = sum((f1-mean(f1)).*(f2-mean(f2)));



p = 3; %the number of the regreesion factor
%nt = 40; %the test number

%F1 = 26.1775;
%F2 = 8.5388;

%for 225+100
F1 = 26.2;
F2 = 8.55; 

%for 200+100
F1 = 26.18285;
F2 = 8.55;


t = 90;% we have 5 points in totoal now

for t = size(fire,2)
ft = fire{t}';
clear all_b;
all_b = [];
delta = [];

regfact = zeros(num_neuron,4);
%figure2 = figure;o
%figure1 = figure;
%figure;
ignore1 = 1;
ignore0 = 1;
find_tot = 0;

find_tot_x = 0;
find_x_list = [];
find_tot_y = 0;
find_y_list = [];
find_tot_xy = 0;
find_xy_list = [];
find_zero_list = [];
find_none_list = [];
temle = [];
x = [ones(nt,1) f1-mean(f1),f2-mean(f2)];
xr = [ones(nt,1) f1-mean(f1),f2-mean(f2)];

for i=1:size(ft,2)
    if(mean(ft(:,i)>1.95)) & ~ignore1
        large = large + 1;
        continue;
    else
        nowfiring = ft(:,i);
        [b,bint1,r1,rint1,s] = regress(nowfiring,xr);       
        coeff{i, t} = [b(2), b(3)];         
        s2 = (x*b - nowfiring)'*(x*b - nowfiring)/(nt-p);
        K1 = s2*p*F1;
        K2 = s2*p*F2;

        % significance from the origin
        beta_1 = 0;
        beta_2 = 0;
        delta_beta_1 = beta_1 - b(2);
        delta_beta_2 = beta_2 - b(3);
        temleft = delta_beta_1^2*s11 + delta_beta_2^2*s22 + 2*delta_beta_1*delta_beta_2*s12;
        temle = [temle; temleft];
              
        if temleft <= K1 % origion
            coeff{i, t} = [coeff{i, t}, 0];
        else

            delta_y = (-2*(s22*b(3)+b(2)*s12))^2 - 4*s22*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K2);
            delta_x = (-2*(s12*b(3)+s11*b(2)))^2 - 4*s11*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K2);
            delta_xy = (2*(s11*b(2)-s22*b(3)+s12*b(3)-s12*b(2)))^2 - 4*(s11+s22-2*s12)*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K2);
            delta_y_v = (-2*(s22*b(3)+b(2)*s12))^2-4*s22*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K1);
            delta_x_v = (-2*(s12*b(3)+s11*b(2)))^2 - 4*s11*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K1);
            delta_xy_v = (2*(s11*b(2)-s22*b(3)+s12*b(3)-s12*b(2)))^2-4*(s11+s22-2*s12)*(b(2)^2*s11+b(3)^2*s22+2*s12*b(2)*b(3)-K1);
            delta = [delta;[i delta_x,delta_y,delta_xy, delta_x_v, delta_y_v, delta_xy_v]];
            if delta_y > 0 && delta_x_v <= 0 && delta_xy_v <=0 % vertical
                coeff{i, t} = [coeff{i, t}, 1];
                find_tot_y = find_tot_y+1;
                find_y_list = [find_y_list;[i,b']];
                if(b(3)>0)
                        coeff_s(i,t) = 10;% +f2
                    else
                        coeff_s(i,t) = 20;% -f2
                    end
            elseif delta_x > 0  && delta_y_v <= 0 && delta_xy_v <=0 % horizon
                coeff{i, t} = [coeff{i, t}, 2];
                find_tot_x = find_tot_x+1;
                find_x_list = [find_x_list;[i,b']];  
                       if(b(2)>0)
                        coeff_s(i,t) = 30;
                    else
                        coeff_s(i,t) = 40;
                    end             
                
                
            elseif delta_xy > 0 && delta_x_v <= 0  && delta_y_v <= 0 % diagnol
                coeff{i, t} = [coeff{i, t}, 3];
                find_tot_xy = find_tot_xy+1;
                find_xy_list = [find_xy_list;[i,b']];
                 if(b(2)<0)
                    coeff_s(i,t) = 50;%f2-f1
                else
                    coeff_s(i,t) = 60;
                end               
                
            else                                                     % another
                coeff{i, t} = [coeff{i, t}, 4];
                coeff_s(i,t) = -20;
                find_none_list = [find_none_list;[i,b']];               
            end
        end
        
        
        all_b = [all_b ;[b(1:2,:)',s(1)]];                                                               
    end 
    
end

p2 = figure;
hold on;
if(find_tot_x)
scatter(find_x_list(:,3),find_x_list(:,4),30);
end
if(find_tot_y)
scatter(find_y_list(:,3),find_y_list(:,4),50);
end
if(find_tot_xy)
scatter(find_xy_list(:,3),find_xy_list(:,4),10);
end

xlim([-1,1]);
ylim([-1,1]);
a = -1:0.1:1;
plot(a,a);
plot(a,-a);
plot(a*0,-a);
plot(a,a*0);


hold off;


%saveas(p2,strcat('ar',num2str(f_num),num2str(t),'.png'));


end

hold on;

%scatter(find_none_list(:,3),find_none_list(:,4));
if(find_tot_x)
scatter(find_x_list(:,3),find_x_list(:,4),30);
end
if(find_tot_y)
scatter(find_y_list(:,3),find_y_list(:,4),50);
end
if(find_tot_xy)
scatter(find_xy_list(:,3),find_xy_list(:,4),10);
end

xlim([-1,1]);
ylim([-1,1]);
a = -1:0.1:1;
plot(a,a);
plot(a,-a);
plot(a*0,-a);
plot(a,a*0);


hold off;

%coeff_s = coeff_s(:,80:90);


