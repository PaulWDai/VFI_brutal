function [v1,v1_store, opt_k_idx] = VFI(beta,vguess,u2d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%           beta: discount factor
%           vguess: initial guess
%           u2d: utility matrix 

% Output:   
%           v1: final result of value function
%           v1_store: matrix storing result of each iteration
%           opt_k_idx: index of optimal capital (control)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global ngrid iter_max err_max 

v1 = vguess;
iter =0;
err = 1;

tic
while iter<iter_max && err>err_max
    iter = iter+1;
    vv = u2d + beta*permute(repmat(v1,[1,ngrid]),[2,1]);
    [vnew, opt_k_idx] = max(vv,[],2);
    err = max(abs(vnew-v1),[],'all');
    v1 = vnew;
    v1_store(:,iter) = v1;
end
toc

end

