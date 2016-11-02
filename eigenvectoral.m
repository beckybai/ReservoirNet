function [newdata, eigenvector,value] = eigenvectoral(data,mena)
remaindem = 6;
[M,N] = size(data);

data = data - mena;
covariance = 1/(N-1)*data*data';
[eigenvector,value] = eig(covariance);
value = diag(value);
%[~,rindices] = sort(-1*value);
value = value(1:remaindem);
eigenvector = eigenvector(:,1:remaindem);
newdata = eigenvector'*data;
newdata = newdata';
end