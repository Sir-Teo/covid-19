figure(1), clf
R = [0.53/60,0.48/60,0.52/60,0.41/60];
lambda = [0.46/60,1.36/60,2.19/60,2.27/60];
%C(1)=C(1)/k
for i = 1:4
    C(1) = R(i);
    k = lambda(i);
    p(1)=0.6*(1-exp(-C(1))); %We are assuming that most people are
    pb(1)=(factorial(3)/(factorial(2)*factorial(1)))*p(1)^1*(1-p(1))^2;
    for j=2:1:500
    C(j)=(C(1)/k)*(1-exp(-k*j));
    p(j)=0.6*(1-exp(C(j)/k-(C(1)/k)*j));
    pb(j)=(factorial(3)/(factorial(2)*factorial(1)))*p(j)^1*(1-p(j))^2;
    end
subplot(1,3,1)
plot(C,'LineWidth',2);hold on
ylabel('Average droplet concentration','FontSize',15), xlabel('time (minutes)','FontSize',15)
subplot(1,3,2)
plot(p,'LineWidth',2);hold on
ylabel('Probability of Infection','FontSize',15), xlabel('time (minutes)','FontSize',15)
subplot(1,3,3)
plot(pb,'LineWidth',2);hold on
ylabel('Binomial probability of infection','FontSize',15), xlabel('time (minutes)','FontSize',15)
end
subplot(1,3,1)
legend('ACH0','ACH1.7','ACH2.45','ACH3.2')
subplot(1,3,2)
legend('ACH0','ACH1.7','ACH2.45','ACH3.2')
subplot(1,3,3)
legend('ACH0','ACH1.7','ACH2.45','ACH3.2')