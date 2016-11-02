wmc = newWeights.weight_WMC_WMC;
a = wmc(1:960,1:960)>0;
a1 = sum(a(:));
sum2 = sum(a(:));
sum3 = sum(sum(a>0));
c1 = sum3/(960*960);

b1 = sum2/(960*960);
fprintf('%d\t',sum(a(:)));
%fprintf('%d\t',c1);
fprintf('%d\n',sum2/(960*960));


a = wmc(1:960,961:1200)<0;
sum2 = sum(a(:));
a2 = sum(a(:));
b2 = sum2/(960*240);
sum3 = sum(sum(a>0));
c2 = sum3/(960*240);
fprintf('%d\t',sum(a(:)));
%fprintf('%d\t',c2);
fprintf('%d\n',sum2/(960*240));

a = wmc(961:1200,1:960)>0;
sum2 = sum(a(:));
a3= sum(a(:));
b3 = sum2/(960*240);
sum3 = sum(sum(a>0));
c3 = sum3/(960*240);
fprintf('%d\t',sum(a(:)));
%fprintf('%d\t',c3);
fprintf('%d\n',sum2/(960*240));

a = wmc(961:1200,961:1200)<0;
sum2 = sum(a(:));
a4 = sum(a(:));
b4 = sum2/(240*240);
sum3 = sum(sum(a>0));
c4 = sum3/(960*240);
fprintf('%d\t',sum(a(:)));
%fprintf('%d\t',c4);
fprintf('%d\n\n',sum2/(240*240));


fprintf('%d\t',a1+a3-a2-a4);
%fprintf('%d\t',c1+c3-c2-c4);
fprintf('%d\n',b1+b3-b2-b4);