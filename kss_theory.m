function [kss_the] = kss_theory(z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Goal: 
%           calculating the theoretical steady state
% Input: 
%           z (productivity)
% Output: 
%           kss_the (theoretical steady state)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global alpha beta delta

kss_the = (z*alpha/(1/beta-(1-delta)))^(1/(1-alpha));
end

