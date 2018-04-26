
Pay = [1 2 0 -2; 3 1 1 3; 0 4 3 -1; 1 2 -1 1];

A = -Pay';
b = -Pay(1,:) + 0.00001;
Aeq = [1 1 1 1];
beq = 1;
lb = [0 0 0 0];
ub = [0 1 1 1];

f = [4 3 2 1];

x = linprog(f,A,b,Aeq,beq,lb,ub);
