%%Game theory exercise E2.10
%%Forward backward method simulation
close all;
x0=[1.5;1.2;0];
x=x0;
epsilon=0.05;
syms x1 x2
J1=x1*x2;
J2=-x1*x2;
i=0;
figure(1);
hold on;
hold on;
xlabel('x_1');
ylabel('x_2');
title('Simulation Forward-Backward Method');
cost_1=[];
cost_2=[];
while(norm(x)>epsilon)

   B=[x(2)+x(1);-x(1);-1+x(1)+x(2)];
   %ith iteration
   i=i+1;
   
   %next iteration
   x=x-epsilon*B;
   
   
   if(-1+x(1)+x(2)>0)
       plot(x(1),x(2),'r+');
   else
       plot(x(1),x(2),'b+');
   end
   %vanishing step sizes
   epsilon=epsilon*exp(-i/100000);
   %plot cost
   cost_1(i)=0.5*x(1)^2+x(1)*x(2);
   cost_2(i)=-x(1)*x(2);
   if i>5000
       break;
   end
   
end

figure;
subplot(2,1,1);
hold on;
title('J_1 Cost');
xlabel('x_1');
ylabel('J_1');
plot(1:1:length(cost_1),cost_1);

subplot(2,1,2);
hold on;
title('J_2 Cost');
xlabel('x_2');
ylabel('J_2');
plot(1:1:length(cost_2),cost_2);
