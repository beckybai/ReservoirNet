fprintf(' We have %d valid cells.',valued_num);

valued_index_num = find(valued_index,valued_num);
large = testingResult(:,1)> testingResult(:,2);
f = zeros(valued_num,3);

for i=1:valued_num
    index = valued_index_num(i);
    fff = fireatlast(:,index);
    f1 = fff(large);
    f2 = fff(~large);
    f(i,1) = sum((f1-mean(f1)).*(f1-mean(f1)));
    f(i,2) = sum((f2-mean(f2)).*(f2-mean(f2)));
    f(i,3) = (mean(f1)-mean(f2))^2 / (f(i,1)^2+ f(i,2)^2);
end

fprintf('average:%d,%d,%d\n ',mean(f));
fprintf('max:%d,%d,%d\n ',max(f));
fprintf('min:%d,%d,%d\n ',min(f));