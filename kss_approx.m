function [kss_app,idx_ss] = kss_approx(opt_k_idx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Goal: calculating the approximated steady state
% Input: 
%           opt_k_idx (index of optimal capital investment tomorrow)
% Output: 
%           kss_app (approximated steady state)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global kgrid
[~,idx_ss] = min(abs(kgrid(opt_k_idx)-kgrid));
kss_app = kgrid(idx_ss);
end

