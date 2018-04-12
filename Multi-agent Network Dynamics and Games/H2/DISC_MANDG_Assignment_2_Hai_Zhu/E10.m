%% Exercise E2.10
% Simulation of forward-backward algorithm
clear all;
clc;

% Initial configurations
x0 = [1, 1];            % initial condition
xk = x0;                % state at the moment
xN = x0;                % iteration history
threshhold = 0.001;      % tolerant error

%% Simulation with constant step size
% iteration
eps = 0.1;
T = [1-eps, -eps; eps, 1];
while (norm(xk) > threshhold)
    xk = (T * xk')';    % iteration step
    xN = [xN; xk];
end
N = size(xN(:,1));      % total iteration steps
% plotting state history
figure;
hold on;
box on;
xlabel('steps');
ylabel('state');
plot(1:N, xN(:,1), 1:N, xN(:,2));
legend('x_1','x_2');
saveas(gca,'E210_cons_state','pdf');
system('pdfcrop E210_cons_state.pdf E210_cons_state.pdf');
% plotting trajectory
figure;
hold on;
box on;
xlabel('x_1');
ylabel('x_2');
plot(xN(:,1), xN(:,2));
saveas(gca,'E210_cons_tra','pdf');
system('pdfcrop E210_cons_tra.pdf E210_cons_tra.pdf');
% plotting cost function history
J1N = 0.5.*xN(:,1).*xN(:,1) + xN(:,1).*xN(:,2);
J2N = -xN(:,1).*xN(:,2);
figure;
hold on;
box on;
xlabel('steps');
ylabel('cost function');
plot(1:N, J1N, 1:N, J2N);
legend('J_1','J_2');
saveas(gca,'E210_cons_cost','pdf');
system('pdfcrop E210_cons_cost.pdf E210_cons_cost.pdf');

%% Simulation with vanishing step size
xk = x0; xN = x0;
k = 0;
eps = 1;
while (norm(xk) > threshhold)
    T = [1-eps, -eps; eps, 1];
    xk = (T * xk')';    % iteration step
    xN = [xN; xk];
    k = k+1;
    eps = 1 / k;
end
N = size(xN(:,1));      % total iteration steps
% plotting state history
figure;
hold on;
box on;
xlabel('steps');
ylabel('state');
plot(1:N, xN(:,1), 1:N, xN(:,2));
legend('x_1','x_2');
saveas(gca,'E210_van_state','pdf');
system('pdfcrop E210_van_state.pdf E210_van_state.pdf');
% plotting trajectory
figure;
hold on;
box on;
xlabel('x_1');
ylabel('x_2');
plot(xN(:,1), xN(:,2));
saveas(gca,'E210_van_tra','pdf');
system('pdfcrop E210_van_tra.pdf E210_van_tra.pdf');
% plotting cost function history
J1N = 0.5.*xN(:,1).*xN(:,1) + xN(:,1).*xN(:,2);
J2N = -xN(:,1).*xN(:,2);
figure;
hold on;
box on;
xlabel('steps');
ylabel('cost function');
plot(1:N, J1N, 1:N, J2N);
legend('J_1','J_2');
saveas(gca,'E210_van_cost','pdf');
system('pdfcrop E210_van_cost.pdf E210_van_cost.pdf');
