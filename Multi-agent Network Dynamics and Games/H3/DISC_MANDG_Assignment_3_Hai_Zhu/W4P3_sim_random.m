clear all
close
clc

%% W4P3_sim_random
Num = 6;                    % number of agents
Gen = 100;                  % number of simulation generation
Age_his = zeros(Gen,Num);   % history of playing strategies
Try_num = 1000;             % number of try to find a solution with period
period = 6;                 % to find a perodic solution
period_max = 6;
flag_stop = 0;              % if stop the serching
more = 2*period;            % evolution more generations after finding a solution
ind_more = 0;               % index

%% finding an example
for k = 1 : Try_num
    % threshold and coordination spercifying
    tau = rand(Num,1);          % threshold for each agents
%     tau = rand(1)*ones(Num,1);
    map = randi([0 1],Num,1);   % coordinating (1) or anti-coordinating (0)
    % creating the graph
    G_A = randi([0 1],Num,Num);
    G_A = G_A - tril(G_A,-1) + triu(G_A,1)';
    G_A = G_A - diag(diag(G_A));
    G_names = {'1' '2' '3' '4' '5' '6'};
    G = graph(G_A,G_names);
    %% simulation
%     Age_0 = randi([0 1],Num,1); % ininital playing strategies
                                % agents with its playing strategy, 
                                % 1 indicates A, 0 indicates B
    Age_0 = [1;1;1;0;0;0];
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
    %                 Age_next(j) = 1;
                else
                    Age_next(j) = (num_A > thr_nei);
                end
            end
            if map(j) == 0                      % for anti-coordinating agents
                if num_A == thr_nei
                    Age_next(j) = Age_pre(j);
    %                 Age_next(j) = 0;
                else
                    Age_next(j) = (num_A < thr_nei);
                end
            end
        end
        Age_his(i,:) = Age_next';
        if period == 1 && isequal(Age_his(i,:), Age_his(i-1,:))
            flag_stop = 1;
        elseif (i > period) && (isequal(Age_his(i,:), Age_his(i-period,:))) && (~isequal(Age_his(i,:), Age_his(i-1,:)))
            flag_stop = 1;
        end
        if flag_stop == 1 && ind_more > more
            break;
        end
        Age_pre = Age_next;
        ind_more = ind_more + 1;
    end
    if flag_stop == 1 && ind_more > more
        break;
    end
    Age_his = zeros(Gen,Num);
    ind_more = 0;
end

if flag_stop == 1
    h_G = plot(G,'MarkerSize',9,'Linewidth',2);
    highlight(h_G,find(map),'NodeColor','g');
    highlight(h_G,find(~map),'NodeColor','r','Marker','s');
end
