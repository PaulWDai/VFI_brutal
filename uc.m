function [c2d,u2d] = uc(z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Goal: calculating the utility for pair (k,klead)

% Input: 
%           z (productivity)
% Output: 
%           c2d (2D grid of consumption)
%           u2d (2D grid of utility)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global alpha delta k2d klead2d infty 

c2d = z*k2d.^alpha+(1-delta)*k2d-klead2d;
u2d = (c2d>0).*log(c2d) + (c2d<=0).*(-infty); 

end

