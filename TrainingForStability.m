n=1;%number of actor outputs
h=3;%number of hidden neurons
m=3;% number of observation inputs
EpochsNumber=20;
Epochs=0;
BestAvrReward1=0;
BestAvrReward2=0;
BestAvrReward3=0;
% Actor weights
while (Epochs<EpochsNumber)
 %Agent 1
 a_input_weights=zeros(h,m);
 for i=1:m
    a_input_weights(:,i)=-2+(2+2)*rand(1,h,'single');
 end
 a_hidden_weights=zeros(n,h);
 for i=1:h
  a_hidden_weights(:,i)=-2+(2+2)*rand(1,n,'single');
 end
% Critic weights

% State path
%  c_input_weights=zeros(2000,m);
%  for i=1:2000
%  c_input_weights(i,:)=-1+(1+1)*rand(1,m,'single');
%  end
%  c_hidden_weights=zeros(200,2000);
%  for i=1:200
%  c_hidden_weights(i,:)=-1+(1+1)*rand(1,2000,'single');
%  end
%  c_hidden_weights2=-1+(1+1)*rand(1,200,'single');
% 
%  % Actor path 
%  c_input_weights_a=zeros(200,n);
%  for i=1:200
%  c_input_weights_a(i,:)=-1+(1+1)*rand(1,n,'single'); 
%  end
%  c_hidden_weights_a=-1+(1+1)*rand(1,200,'single');
 simOut=sim('Stability','SimulationMode','normal','AbsTol','1e-5',...
           'SaveState','on','StateSaveName','xout2',...
           'SaveTime','on','TimeSaveName','time',...
           'SaveFormat', 'Dataset');
 Epochs=1+Epochs;
 Reward1=simOut.get('Reward1');
 AvrReward1=mean(Reward1);
 if (AvrReward1>BestAvrReward1)%Weights with max reward selection
   BestAvrReward1=AvrReward1;
   save('BestWeightsStabile.mat','a_hidden_weights','a_input_weights','AvrReward1');
 end
 disp('Average reward');
 disp(AvrReward1);
 %clean;
end
%gamma=0.5;% discount factor
