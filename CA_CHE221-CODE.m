%Given parameters
%Pressure
P=760;
%Antoine's Constants
A1=8.08097;
A2=8.07131;
B1=1582.271;
B2=1730.630;
C1=239.726;
C2=233.426;

%VAN LAAR Activity Coefficient Model constants
A12=0.7715;
A21=0.5775;
%Specifying temperature range
T=linspace(50,100,51);
x1=zeros(size(T)); %Mole fraction in liquid phase of methanol
x2=zeros(size(T)); %Mole fraction in liquid phase of water
y1=zeros(size(T)); %Mole fraction in vapour phase of methanol
y2=zeros(size(T)); %Mole fraction in vapour phase of water
G1=zeros(size(T)); %activity coefficient of methanol
G2=zeros(size(T)); %activity coefficient of water
P1sat=zeros(size(T));
P2sat=zeros(size(T));

% Calculation of vapour pressure of pure components
for i=1:51
P1sat(i)=10^(A1-(B1/(T(i)+C1)));
P2sat(i)=10^(A2-(B2/(T(i)+C2)));

%x1 calculation
eqn=@(x1) 760-P1sat(i)*x1*exp((A12)*((A21*(1-x1))/(A12*x1+A21*(1-x1)))*((A21*(1-x1))/(A12*x1+A21*(1-x1))))-P2sat(i)*(1-x1)*exp((A21)*((A12*x1)/(A12*x1+A21*(1-x1)))*((A12*x1)/(A12*x1+A21*(1-x1))));
x1(i)=fzero(eqn,0);
x2(i)=1-x1(i);

%VAN LAAR activity coefficients calculation
 G1(i)=exp((A12)*((A21*x2(i))/(A12*x1(i)+A21*x2(i)))*((A21*x2(i))/(A12*x1(i)+A21*x2(i))));
 G2(i)=exp((A21)*((A12*x1(i))/(A12*x1(i)+A21*x2(i)))*((A12*x1(i))/(A12*x1(i)+A21*x2(i))));
%y1 calculation
 y1(i)=P1sat(i)*x1(i)*G1(i)/P;
 y2(i)=P2sat(i)*x2(i)*G2(i)/P;
end
%% Graph plotting and  comparison from the given data

%Extracting the given data
Tpoints=[96.70,92.70,84.60,77.10,73.20,68.60,66.70,66.30];
xpoints=[0.159,0.476,0.1475,0.3515,0.5097,0.7595,0.8889,0.9408];
ypoints=[0.1100,0.2521,0.4716,0.6786,0.7923,0.8953,0.9536,0.9702];
tiledlayout(1,2);
nexttile;
%Plotting y vs x
plot(x1,y1);
hold on
plot(xpoints,ypoints,'--or');
hold off
xlim([0,1])
ylim([0,1])
nexttile;

%Plotiing T vs xy
plot(x1,T);
hold on
plot(y1,T);
hold on
plot(xpoints,Tpoints,'--or')
hold on 
plot(ypoints,Tpoints,'--or')
hold off
xlim([0,1])