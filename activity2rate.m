function y = activity2rate(x,a)

% if nargin < 2, r0=0.1; rmax = 1; end
% 
% if ~isempty(find(x<=0)) && ~isempty(find(x>0))
%     px = x;
%     px(find(px<=0)) = 0;
%     nx = x;
%     nx(find(nx>0)) = 0;
%     nr = r0*tanh(nx/r0);
%     pr = (rmax - r0)*tanh(px/(rmax - r0));
%     rate = r0 + nr + pr;
% elseif ~isempty(find(x<=0))
%     rate = r0 + r0*tanh(x/r0);
% elseif ~isempty(find(x>0))
%     rate = r0 + (rmax - r0)*tanh(x/(rmax - r0));
% end

y0=0.1; ymax=1.2;
a = 1;
y=zeros(size(x));
id= x<=0;
y(id)= y0+y0* tanh(a*x(id)/y0);
y(~id)= y0+(ymax-y0)*tanh(a*x(~id)/(ymax-y0));
%y = 1./(1 + exp(-x));