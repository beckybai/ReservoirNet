fm1 = f1-mean(f1);
fm2 = f2-mean(f2);
nm = nowfiring - x*b;
n = size(fm1,1);

sb1 = sqrt(sum(fm2)*sum(nm.^2)/(sum(fm1.^2)*sum(fm2.^2)-(sum(fm1.*fm2))^2)/(n-3));