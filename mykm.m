mena_rateList = [];
for i = 1:(size(rateList,1))
    mena_rateList(i,:) = mean(rateList{i,1}(:,200:800));
end
mena_rateList = repmat(mean(mena_rateList),1200,1);

rate_tot = rateList{1,1}(:,200:800);

n = size(rateList,1);
for i = 2:n
rate_tot = rate_tot + rateList{i,1}(:,200:800);
end
rate = rate_tot/n;
[newdata, eigenvector,value] = eigenvectoral(rate,mena_rateList);


%%%%%%%%%%%%%%%%%%%%%%%%%%555
