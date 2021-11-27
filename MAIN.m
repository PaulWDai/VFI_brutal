
clear;
close;
clc;
%% Parameters

global ngrid iter_max err_max alpha delta beta k2d klead2d infty kgrid 
beta = 0.99;
z = 1;
alpha = 0.3;
delta = 0.1;
ngrid = 500;
kbar = (z/delta)^(1/(1-alpha));
kbar = .99*kbar; % a small modification to ensure the computation error will not lead a log undefined;
kmin = .1;

infty = 10^8;
iter_max = 2000;
err_max = 10^-5;


kgrid = linspace(kmin,kbar,ngrid);

[k2d,klead2d] = ndgrid(kgrid,kgrid);

% z = 1;
[c2d1,u2d1] = uc(1);
% z = 2;
[c2d2,u2d2] = uc(2);

%% Question 2(a)

disp('------------------- Question 2(a) --------------------')

disp('Guess 1 + beta = 0.99')
vguess1 = zeros(ngrid,1); % a worse guess
[v1,v1_store, opt_k_idx_1] = VFI(beta,vguess1,u2d1);
[~,len_v1_store] = size(v1_store);
% steady state:
% theoretical z = 1
[kss_thry_1] = kss_theory(1);
[kss_thry_2] = kss_theory(2);
% approximation
[kss_appr_1,~] = kss_approx(opt_k_idx_1);


fig1 = figure(1);
subplot(1,2,1)
for i = 1:len_v1_store
    plot(kgrid,v1_store(:,i));hold on
end
title("Iterations of Value Function",'Interpreter','Latex');ylim([-5 25])

subplot(1,2,2);
plot(kgrid,v1,'r','LineWidth',2.0);
title("Value Function",'Interpreter','Latex');ylim([-5 25]);
saveas(fig1,'fig_2a_i.png');

fig2 = figure(2);
plot(kgrid,kgrid(opt_k_idx_1),'r','LineWidth',2.0);hold on;
plot(kgrid,kgrid,'b-','LineWidth',2.0);hold on;
plot(kss_thry_1,kss_thry_1,'g*');
xlim([kmin kbar]);ylim([kmin kbar]);
legend({'Policy Function','45 Degree Line','Theoretical Steady State'},'Location','SouthEast','Interpreter','Latex');
title('Policy Function','Interpreter','Latex');

saveas(fig2,'fig_2a_ii.png');

%% Question 2(b)

disp('------------------- Question 2(b) --------------------')

disp('Guess 1 + beta = 0.10')
beta_new = 0.1;
[v1_beta,v1_beta_store, opt_k_idx_beta] = VFI(beta_new,vguess1,u2d1);
[~,len_v1_beta_store] = size(v1_beta_store);

fig3 = figure(3);
subplot(1,2,1)
for i = 1:len_v1_beta_store
    plot(kgrid,v1_beta_store(:,i));hold on
end
title("Iterations of Value Function",'Interpreter','Latex');ylim([-5 5])

subplot(1,2,2);
plot(kgrid,v1_beta,'r','LineWidth',2.0);
title("Value Function",'Interpreter','Latex');ylim([-5 5]);
saveas(fig3,'fig_2b.png');
%% Question 2(c)

disp('------------------- Question 2(c) --------------------')

disp('Guess 2 + beta = 0.99')
z = 1;
vguess2_1 = log(z*kgrid.^alpha-delta*kgrid)/(1-beta); % a better guess
vguess2_1 = vguess2_1';

z = 2;
vguess2_2 = log(z*kgrid.^alpha-delta*kgrid)/(1-beta); % a better guess
vguess2_2 = vguess2_2';
disp('z = 1');
% z = 1
[v2_1,v2_store_1, opt_k_idx_2_1] = VFI(beta,vguess2_1,u2d1);

disp('z = 2');
% z = 2; for question 3
[v2_2,~, opt_k_idx_2_2] = VFI(beta,vguess2_2,u2d2);

[~,len_v2_store] = size(v2_store_1);

fig4 = figure(4);

subplot(1,2,1);
for i = 1:len_v2_store
    plot(kgrid,v2_store_1(:,i));hold on
end
title("Iterations of Value Function",'Interpreter','Latex');ylim([-30 30])

subplot(1,2,2);
plot(kgrid,v2_1,'r','LineWidth',2.0);
title("Value Function");ylim([-30 30]);
saveas(fig4,'fig_2c.png');


%% Question 3(a)

disp('------------------- Question 3(a) --------------------')

[kss_appr_1,idx_ss_1] = kss_approx(opt_k_idx_2_1);
[kss_appr_2,idx_ss_2] = kss_approx(opt_k_idx_2_2);

disp('z = 1');
disp(['theory:',num2str(kss_thry_1)]);
disp(['approximation:',num2str(kss_appr_1)]);
disp('z = 2');
disp(['theory:',num2str(kss_thry_2)]);
disp(['approximation:',num2str(kss_appr_2)]);

fig5 = figure(5);
plot(kgrid,kgrid(opt_k_idx_2_1),'r-.','LineWidth',2.0);hold on;
plot(kgrid,kgrid(opt_k_idx_2_2),'b:','LineWidth',2.0);hold on;
plot(kgrid,kgrid,'g','LineWidth',2.0);
legend({'Policy Function for $z=1$','Policy Function for $z=2$','45 Degree Line'},'Location','SouthEast','Interpreter','Latex');
saveas(fig5,'fig_3a.png');


%% Question 3(b)

disp('------------------- Question 3(b) --------------------')

idx_path = nan(1,30);
idx_path(1,1) = idx_ss_1;

for i = 2:30
    idx_path(1,i) = opt_k_idx_2_2(idx_path(1,i-1));
end

k_path = kgrid(idx_path);

fig6 = figure(6);
plot([0:29],k_path,'LineWidth',2.0);
title('Impulse Response function','Interpreter','Latex');
saveas(fig6,'fig_3b.png');



