f1 = 0.1;
f2 = 0.1;

testresult = testingResult(testingResult(:,1)>f1 & testingResult(:,1) < f1+0.1,:);
x1 = sum(testresult(testresult(:,2)>f2 & testresult(:,2)<f2+0.1,4))
testresult(:,7) = ones(size(testresult,1),1);
x2 = sum(testresult(testresult(:,2)>f2 & testresult(:,2)<f2+0.1,7))
x1/x2