
remaindem = 4;
clear covariance;
clear rate_kind;
mena_rateList = [];
for i = 1:(size(rateList,1))
    mena_rateList(:,i) = mean(rateList{i,1}(:,200:799),2);
end
mena_rateList = repmat(mean(mena_rateList,2),1,size(200:799,2));


cov_tot = zeros(1200,1200);
n = size(rateList,1);

for range = 0:15:225-15
    index = floor(range/15)+1;
    rate_tot = zeros(size(rateList{1,1}(:,200:799)));
for i = range+1:range+15
 rate_tot = rate_tot + rateList{i,1}(:,200:799);
 end
 rate_kind{index,1} = rate_tot/15;
 data = rate_kind{index,1};
 [M,N] = size(data);
%rate = rateList{101,1}(:,200:799);

%[newdata, eigenvector,value] =[newdata, eigenvector,value]+ eigenvectoral(rate,mena_rateList);
covariance{index} = 1/(N)*(data-mena_rateList)*(data-mena_rateList)';
cov_tot = cov_tot + covariance{index};
%[eigenvector,value] = eig(covariance);
end

cov_tot = cov_tot/index;


[eigenvector,value] = eig(cov_tot);

value = diag(value);
%[~,rindices] = sort(-1*value);
value = value(1:remaindem);
eigenvector = eigenvector(:,1:remaindem);



clear newdata;
n = size(rateList,1);

if(1==1)
    for i = 1:remaindem
        figure;
        for j = 1:1:15
            data = rate_kind{j,1};
            data = data - mena_rateList;
            newdata_t = (eigenvector'*data)';
            newdata{j,1} = newdata_t;
            plot(newdata_t(:,i),'LineWidth',3);
            hold on;
      %      ylim([-90,60])
        end
        hold off;
    end
end


% 
% for i = 91:105
%  new_rate_tot = new_rate_tot + newdata{i,1};
%  end
%  new_rate = new_rate_tot/15;
% 

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

clear ZT ZF

ZT = newdata{1,1};
ZF(1,:) = mean(newdata{1,1});
for i = 2:size(newdata,1)
    ZT = ZT + newdata{i,1};
    ZF(i,:) = mean(newdata{i,1});
end

% 1 can be index from 1 to 15
%ZF = ZF(1,:);

ZT = ZT/size(newdata,1);

NUM_T = 600;
num_test =  size(newdata,1);%15 different firing rates
SZT = ZT'*ZT/NUM_T;
SZF = ZF'*ZF/num_test;

S = SZT - SZF;

[doc_t_eve,doc_t_eva] = eig(SZT);
[doc_f_eve,doc_f_eva] = eig(SZF);
[doc_eigenvector,doc_value] = eig(S);

clear do_newdata;

if(1==1)
    for i = 1:remaindem
        figure;
        for j = 1:2:15
            data = newdata{j,1};
            doc_newdata_t = -(doc_eigenvector'*data')';
            doc_newdata{j,1} = doc_newdata_t;
            plot(doc_newdata_t(:,i),'LineWidth',3,'Color',colOrd((j-1)/2+1,:));
            ylim([-4,4]);
            hold on;
        end
        hold off;
 %         saveas(gcf,strcat('dpca',num2str(i),'_2','.eps'),'psc2');
    end
end
figure;
plot(var(ZT)/sum(var(ZT)),'LineWidth',3);
hold on;
plot(var(ZF)/sum(var(ZF)),'LineWidth',3);
