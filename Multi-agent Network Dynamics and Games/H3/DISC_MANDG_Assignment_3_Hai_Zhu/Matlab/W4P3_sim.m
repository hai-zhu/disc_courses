clear all
close
clc

%% W4P3_sim
Num = 6;                    % number of agents
Gen = 100;                  % number of simulation generation
Age_his = zeros(Gen,Num);   % history of playing strategies

%% configuration
tau = 0.5*ones(Num,1);      % threshold for each agents
map = [1;0;1;0;1;0];        % coordinating (1) or anti-coordinating (0)
% creating the graph
G_s = [1 1 2 3 4 5];
G_t = [2 6 3 4 5 6];
G_weights = zeros(length(G_s),1);
G_names = {'1' '2' '3' '4' '5' '6'};
G = graph(G_s,G_t,G_weights,G_names);
% plot(G,'EdgeLabel',G.Edges.Weight);
period = 4;

%% simulation
Age_0 = [1;1;1;0;0;0];      % ininital playing strategies
                            % agents with its playing strategy, 
                            % 1 indicates A, 0 indicates B
Age_pre = Age_0;            % initialization
Age_next = Age_0;
for i = 1 : Gen
    for j = 1: Num          % loop for each agent
        % calculate the number of playing A of its neighbors
        neighbor = neighbors(G,j);          % neighbors of the agent
        num_A = sum(Age_pre(neighbor));     % number of neighbors playing A
        thr_nei = tau(j)*length(neighbor);  % threshold
        % updating the strategy of the agent
        if map(j) == 1                      % for coordinating agents
            if num_A == thr_nei
                Age_next(j) = Age_pre(j);
            else
                Age_next(j) = (num_A > thr_nei);
            end
        end
        if map(j) == 0                      % for anti-coordinating agents
            if num_A == thr_nei
                Age_next(j) = not(Age_pre(j));
            else
                Age_next(j) = (num_A < thr_nei);
            end
        end
    end
    Age_his(i,:) = Age_next';
    if Age_next == Age_pre
        break;
    end
    if i > period && sum(Age_his(i,:) == Age_his(i-period,:))==6
        break;
    end
    Age_pre = Age_next;
end


