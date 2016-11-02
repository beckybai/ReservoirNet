
function matrix = sprand_me(size1,size2,pro,rs,s)

rng('shuffle', 'twister'); 

if nargin==4
    rand('seed',rs);
    scale = 1;
end

if nargin==3
    scale = 1;
    %rng('shuffle', 'twister'); 

end

if nargin==5
   scale = s; 
end


%matrix = zeros(size1,size2);


s = 0;
if(size1>size2)
    s = size2;
    size2 = size1;
    size1 = s;
end
matrix = zeros(size1,size2);

s2 =floor(size2*(pro));

% s2_r = randperm(size1);
% s2 = s2_r(1:s2);

% s2_r = randperm(size2);
% s2 = s2_r(1:s2);

for i = 1:size1
    s2_rr = randperm(size2);
    s2_f = s2_rr(1:s2);
    s2_r = lognrnd(0,1,[floor(s2),1]);
    for j = 1:size(s2_f,2);
        matrix(i,s2_f(j)) =s2_r(j,1);
    end
end
   
if s
    matrix = matrix';
end

end
