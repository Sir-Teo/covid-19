
clear all;

% we assume that k5 (relative humidity) is constant across all scenarios
k5=0.0078;   %35 RH

% kj is the ACH in different scenarios. ACH is 3.19 in the office, 0 in the
% Guangzhou Restaurant, 6 in the bus of buddhists, and 6 in the room1 of 
% korean call center
kj=[3.19/60,0/60,6/60,6/60];

% the volume of different scenarios, in the order of the office, the
% restaurant, the bus, and room 1 of the call center. the unit is in m^3
V = [27.67,56.52,77.72,362.25]; 

% here, a is the constant that we want to manipulate in the probability of
% infection plot such that the probability of infection matches with the
% actual probability. For the Guangzhou Restaurant, 11 out of 21 were
% infected in the length of 73 minutes. We assume that a is constant across
% all four scenarios
a = 0.03;


for i = 1:4
    C(1)=1.584/(V(i));
    k=k5+kj(i);
    p(1)=0.6*(1-exp(-C(1)/k)); 
    % We are assuming that most people are
    % vaccinated 0.3 but the strain is virulent (omicron) x 2 =0.6.
  
    pb(1)=(factorial(3)/(factorial(2)*factorial(1)))*p(1)^1*(1-p(1))^2;

    % simulate the scenarios for 7 hours
    for j=2:1:420

    % average droplet concentration
    C(j)=(C(1)/k)*(1-exp(-k*j));

    % probability of infection
    p(j)=0.6*(1-exp(a*(C(j)/k-(C(1)/k)*j)));

    % This is the probability that 2 people come into office and 
    % one gets infected (so there are 3 people there)
    pb(j)=(factorial(3)/(factorial(2)*factorial(1)))*p(j)^1*(1-p(j))^2;
    end

% plotting for each scenarios
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

% adding the legend for each plot
for i = 1:3
    subplot(1,3,i)
    legend('Office','Restaurant','Bus','Call center');
end