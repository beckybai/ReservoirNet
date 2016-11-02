f1 = testingResult(:,1);
f2 = testingResult(:,2);
right = testingResult(:,4)>0;
large = testingResult(:,1)> testingResult(:,2);

valued_num = 0;
valued_index = [];
valued_fireing = [];
valued_regress = [];
b =  zeros(4,2);
s = zeros(4,4);

ignore = 1;

plotwrong = 1;
plotclass = 1;


for i=1:size(fireatlast,2)
    if(mean(fireatlast(:,i)>0.9)) & ~ignore
        continue;
    end
    if(mean(fireatlast(:,i) < 0.1)) & ~ignore
            continue;
    else
        now_index = i;
        valued_num = valued_num + 1;
        valued_index = [valued_index,i];
        valued_fireing = [valued_fireing  fireatlast(:,i)];
        nowfiring = fireatlast(:,i);
        % FOUR KIND OF REGRESSION RAW DATA
        f = zeros(size(fireatlast,1),4);
        f(:,1) = f1;
        f(:,2) = f2;
        f(:,3) = f1-f2;
        f(:,4) = f1+f2;
        xf1 = [ones(size(fireatlast,1),1) f1];
        xf2 = [ones(size(fireatlast,1),1) f2];
        xf1_2 = [ones(size(fireatlast,1),1) f1-f2];
        xf12 = [ones(size(fireatlast,1),1) f1+f2];
        regress(nowfiring,xf1)
        
        [b(1,:),bint1,r1,rint1,s(1,:)] = regress(nowfiring,xf1);
        [b(2,:),bint2,r2,rint2,s(2,:)] = regress(nowfiring,xf2);
        [b(3,:),bint3,r3,rint3,s(3,:)] = regress(nowfiring,xf1_2);
        [b(4,:),bint4,r4,rint4,s(4,:)] = regress(nowfiring,xf12);
%        newfigure = figure('Visible','off');
        figure;
        title(strcat(' index: ',num2str(valued_num)));
        x = cell( 4, 1 ); 
        x{1} = 0:0.1:1.2;
        x{2} = x{1};
        x{3} = -1.2:0.1:1.2;
        x{4} = 0:0.1:2.4;
        for j = 1:4
            subplot(2,2,j);           
            if(plotwrong)
                f_now = f(:,j);
                fg = f_now(right);
                fy = f_now(~right);
                nfg = nowfiring(right);
                nfr = nowfiring(~right);
                scatter(fg,nfg,'g');hold on
                scatter(fy,nfr,'r+');
            end
        if(plotclass)
            f_now = f(:,j);
            fg = f_now(large);
            fy = f_now(~large);
            nfg = nowfiring(large);
            nfr = nowfiring(~large);                 
            scatter(fg,nfg,'g');hold on
            scatter(fy,nfr,'b');      
        else
            scatter(f(:,j),nowfiring);hold on
        end
            
            title(strcat(num2str(b(j,1)),'+',num2str(b(j,2)),'x:',...
                num2str(s(j))));
            y = b(j,1)+b(j,2)*x{j};
            plot(x{j},y);
            hold off;
        end
%        saveas(figure,strcat('./last_pic/',num2str(now_index),'.jpg'));
    end
        
end