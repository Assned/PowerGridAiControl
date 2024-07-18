8%Code implementing reinforcement learning with simplified DDPG training algorithm
%Copyrights Vjatseslav Skiparev 
load('BestWeights1.mat');
load('BestWeights2.mat');
load('BestWeights3.mat');
n=1;% number of actor outputs
h=3;% number of hidden layers
m=3;% number of observations
%Critic weights

 %State path
 c_input_weights1=zeros(1000,m);
 for i=1:1000
 c_input_weights1(i,:)=-1+(1+1)*rand(1,m,'single');
 end
 c_hidden_weights11=zeros(100,1000);
 for i=1:100
 c_hidden_weights11(i,:)=-1+(1+1)*rand(1,1000,'single');
 end
 c_hidden_weights12=-1+(1+1)*rand(1,100,'single');
  % Actor path 1
 c_input_weights_a1=zeros(100,n);
 for i=1:100
 c_input_weights_a1(i,:)=-1+(1+1)*rand(1,n,'single'); 
 end
 c_hidden_weights_a1=-1+(1+1)*rand(1,100,'single');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 c_input_weights2=zeros(1000,m);
 for i=1:1000
 c_input_weights2(i,:)=-1+(1+1)*rand(1,m,'single');
 end
 c_hidden_weights21=zeros(100,1000);
 for i=1:100
 c_hidden_weights21(i,:)=-1+(1+1)*rand(1,1000,'single');
 end
 c_hidden_weights22=-1+(1+1)*rand(1,100,'single');
 % Actor path 2
 c_input_weights_a2=zeros(100,n);
 for i=1:100
 c_input_weights_a2(i,:)=-1+(1+1)*rand(1,n,'single'); 
 end
 c_hidden_weights_a2=-1+(1+1)*rand(1,100,'single');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 c_input_weights3=zeros(1000,m);
 for i=1:1000
 c_input_weights1(i,:)=-1+(1+1)*rand(1,m,'single');
 end
 c_hidden_weights31=zeros(100,1000);
 for i=1:100
 c_hidden_weights31(i,:)=-1+(1+1)*rand(1,1000,'single');
 end
 c_hidden_weights32=-1+(1+1)*rand(1,100,'single');

 % Actor path 3
 c_input_weights_a3=zeros(100,n);
 for i=1:100
 c_input_weights_a3(i,:)=-1+(1+1)*rand(1,n,'single'); 
 end
 c_hidden_weights_a3=-1+(1+1)*rand(1,100,'single');

%Training
EpochsNumber=50;% The training duration
Epochs=0;
BestAvrCritic1=0;% created for selection best reward
BestAvrCritic2=0;
BestAvrCritic3=0;
BestAvrReward1=0;
BestAvrReward2=0;
BestAvrReward3=0;
gamma=0.5;% discount factor
% Adaptive Learning Rate
LearningRateC=0.01;% better to keep a small learning rate
LearningRateA=0.01;
Tau=0.95;% Smoothing factor (Fastes is 0.5)
Rewards=zeros(1,EpochsNumber);
x=0:1:EpochsNumber;
figure
xlim([0 EpochsNumber])
ylim([0 50])
while (Epochs<EpochsNumber)
simOut=sim('MultiMicrogrid','SimulationMode','normal','AbsTol','1e-5',...
           'SaveState','on','StateSaveName','xout2',...
           'SaveTime','on','TimeSaveName','time',...
           'SaveFormat', 'Dataset');
CriticOutput1=simOut.get('CriticOutput1');
CriticOutput2=simOut.get('CriticOutput2');
CriticOutput3=simOut.get('CriticOutput3');
Action1=simOut.get('Action1');
Action2=simOut.get('Action2');
Action3=simOut.get('Action3');
Epochs=1+Epochs;
Reward1=simOut.get('Reward1');
Reward2=simOut.get('Reward2');
Reward3=simOut.get('Reward3');
AE1=simOut.get('IAE1');
AE2=simOut.get('IAE2');
AE3=simOut.get('IAE3');
AvrReward1=mean(Reward1);
AvrReward2=mean(Reward2);
AvrReward3=mean(Reward3);
AvrAction1=mean(Action1);
AvrAction2=mean(Action2);
AvrAction3=mean(Action3);
IAE1=sum(AE1);
IAE2=sum(AE2);
IAE3=sum(AE3);

Rewards1(Epochs)=AvrReward1;
Rewards2(Epochs)=AvrReward2;
Rewards3(Epochs)=AvrReward3;
IAEs1(Epochs)=IAE1;
IAEs2(Epochs)=IAE2;
IAEs3(Epochs)=IAE3;

AvrCritic1=mean(CriticOutput1);%Optimal critic output 
AvrCritic2=mean(CriticOutput2);%Optimal critic output
AvrCritic3=mean(CriticOutput3);%Optimal critic output
subplot(6,1,1);
plot(x(1:Epochs), Rewards1(1:Epochs),'-b');
ylabel('Average Reward1');
subplot(6,1,2);
plot(x(1:Epochs), Rewards2(1:Epochs),'-b');
ylabel('Average Reward2');
subplot(6,1,3);
plot(x(1:Epochs), Rewards3(1:Epochs),'-b');
ylabel('Average Reward3');
subplot(6,1,4);
plot(x(1:Epochs), IAEs1(1:Epochs), '-r');
ylabel('IAE1');
subplot(6,1,5);
plot(x(1:Epochs), IAEs2(1:Epochs), '-r');
ylabel('IAE2');
subplot(6,1,6);
plot(x(1:Epochs), IAEs3(1:Epochs), '-r');
ylabel('IAE3');
xlabel('Epochs');

if (AvrReward1>BestAvrReward1)%Max reward selection
   BestAvrReward1=AvrReward1;
   BestAvrCritic1=AvrCritic1;
end

if (AvrReward2>BestAvrReward2)%Max reward selection
   BestAvrReward2=AvrReward2;
   BestAvrCritic2=AvrCritic2;
end

if (AvrReward3>BestAvrReward3)%Max reward selection
   BestAvrReward3=AvrReward3;
   BestAvrCritic3=AvrCritic3;
end

disp('Episode');
disp(Epochs);
disp('Average reward');
disp(AvrReward1);
disp(AvrReward2);
disp(AvrReward3);
disp('Average critic prediction');
disp(AvrCritic1);
disp(AvrCritic2);
disp(AvrCritic3);

WeightMax=1;
WeightMin=-1;
WeightMaxA=2;%0.5
WeightMinA=-2;%0.5
GradientValue=10000;
%reinforcement learning
LossCrit1=(AvrReward1+gamma*BestAvrCritic1-AvrCritic1)^2;% Loss Function - Prediction vs Real
LossAct1=AvrCritic1;%Action;%log
GradientCrit1=bound(LossCrit1,-GradientValue,GradientValue);
GradientAct1=bound(LossAct1,-GradientValue,GradientValue);
LossCrit2=(AvrReward2+gamma*BestAvrCritic2-AvrCritic2)^2;% Loss Function - Prediction vs Real
LossAct2=AvrCritic2;%Action;%log
GradientCrit2=bound(LossCrit2,-GradientValue,GradientValue);
GradientAct2=bound(LossAct2,-GradientValue,GradientValue);
LossCrit3=(AvrReward3+gamma*BestAvrCritic3-AvrCritic3)^2;% Loss Function - Prediction vs Real
LossAct3=AvrCritic3;%Action;%log
GradientCrit3=bound(LossCrit3,-GradientValue,GradientValue);
GradientAct3=bound(LossAct3,-GradientValue,GradientValue);
    
    for i=1:h
      for j=1:m
         a_input_weights1(i,j)=bound(a_input_weights1(i,j)*Tau-a_input_weights1(i,j)*(1-Tau)*GradientAct1*LearningRateA,WeightMinA,WeightMaxA);
       end
    end
    for i=1:1
      for j=1:3
         a_hidden_weights1(i,j)=bound(a_hidden_weights1(i,j)*Tau-a_hidden_weights1(i,j)*(1-Tau)*GradientAct1*LearningRateA,WeightMinA,WeightMaxA);
      end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:h
      for j=1:m
         a_input_weights2(i,j)=bound(a_input_weights2(i,j)*Tau-a_input_weights2(i,j)*(1-Tau)*GradientAct2*LearningRateA,WeightMinA,WeightMaxA);
       end
    end
    for i=1:1
      for j=1:3
         a_hidden_weights2(i,j)=bound(a_hidden_weights2(i,j)*Tau-a_hidden_weights2(i,j)*(1-Tau)*GradientAct2*LearningRateA,WeightMinA,WeightMaxA);
      end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:h
      for j=1:m
         a_input_weights3(i,j)=bound(a_input_weights3(i,j)*Tau-a_input_weights3(i,j)*(1-Tau)*GradientAct3*LearningRateA,WeightMinA,WeightMaxA);
       end
    end
    for i=1:1
      for j=1:3
         a_hidden_weights3(i,j)=bound(a_hidden_weights3(i,j)*Tau-a_hidden_weights3(i,j)*(1-Tau)*GradientAct3*LearningRateA,WeightMinA,WeightMaxA);
      end
    end

    % Update critic weight
    % State path
    for i=1:1000
      for j=1:m
        c_input_weights1(i,j)=bound(c_input_weights1(i,j)*Tau-c_input_weights1(i,j)*(1-Tau)*GradientCrit1*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
      for j=1:1000
       c_hidden_weights11(i,j)=bound(c_hidden_weights11(i,j)*Tau-c_hidden_weights11(i,j)*(1-Tau)*GradientCrit1*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
       c_hidden_weights12(i)=bound(c_hidden_weights12(i)*Tau-c_hidden_weights12(i)*(1-Tau)*GradientCrit1*LearningRateC,WeightMin,WeightMax);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:1000
      for j=1:m
        c_input_weights2(i,j)=bound(c_input_weights2(i,j)*Tau-c_input_weights2(i,j)*(1-Tau)*GradientCrit2*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
      for j=1:1000
       c_hidden_weights21(i,j)=bound(c_hidden_weights21(i,j)*Tau-c_hidden_weights21(i,j)*(1-Tau)*GradientCrit2*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
       c_hidden_weights22(i)=bound(c_hidden_weights22(i)*Tau-c_hidden_weights22(i)*(1-Tau)*GradientCrit2*LearningRateC,WeightMin,WeightMax);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:1000
      for j=1:m
        c_input_weights3(i,j)=bound(c_input_weights3(i,j)*Tau-c_input_weights3(i,j)*(1-Tau)*GradientCrit3*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
      for j=1:1000
       c_hidden_weights(i,j)=bound(c_hidden_weights31(i,j)*Tau-c_hidden_weights31(i,j)*(1-Tau)*GradientCrit3*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
       c_hidden_weights32(i)=bound(c_hidden_weights32(i)*Tau-c_hidden_weights32(i)*(1-Tau)*GradientCrit3*LearningRateC,WeightMin,WeightMax);
    end

    % Actor path
    for i=1:100
      for j=1:n
        c_input_weights_a(i,j)=bound(c_input_weights_a1(i,j)*Tau-c_input_weights_a1(i,j)*(1-Tau)*GradientCrit1*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
         c_hidden_weights_a(i)=bound(c_hidden_weights_a1(i)*Tau-c_hidden_weights_a1(i)*(1-Tau)*GradientCrit1*LearningRateC,WeightMin,WeightMax);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:100
      for j=1:n
        c_input_weights_a2(i,j)=bound(c_input_weights_a2(i,j)*Tau-c_input_weights_a2(i,j)*(1-Tau)*GradientCrit2*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
         c_hidden_weights_a2(i)=bound(c_hidden_weights_a2(i)*Tau-c_hidden_weights_a2(i)*(1-Tau)*GradientCrit2*LearningRateC,WeightMin,WeightMax);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:100
      for j=1:n
        c_input_weights_a3(i,j)=bound(c_input_weights_a3(i,j)*Tau-c_input_weights_a3(i,j)*(1-Tau)*GradientCrit3*LearningRateC,WeightMin,WeightMax);
      end
    end
    for i=1:100
         c_hidden_weights_a3(i)=bound(c_hidden_weights_a3(i)*Tau-c_hidden_weights_a3(i)*(1-Tau)*GradientCrit3*LearningRateC,WeightMin,WeightMax);
    end
    disp('Critic Gradient');
    disp(GradientCrit1);
    disp(GradientCrit2);
    disp(GradientCrit3);
    disp('Actor Gradient');
    disp(GradientAct1);
    disp(GradientAct2);
    disp(GradientAct3);
    if (Reward1+Reward2+Reward3>53.00)
      break;   
    end
end



