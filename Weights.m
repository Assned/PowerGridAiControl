n=1;%number of actor outputs
h=3;%number of hidden neurons
m=3;%number of observation inputs
EpochsNumber=20;
Epochs=0;
BestAvrReward1=0;
BestAvrReward2=0;
BestAvrReward3=0;
w=2.0;%weight value
w2=2.0;
w3=2.0;
% Actor weights

while (Epochs<EpochsNumber)
 %Agent 1
 a_input_weights1=zeros(h,m);
 for i=1:m
    a_input_weights1(:,i)=-0+(w+0)*rand(1,h,'single');
 end
 a_hidden_weights1=zeros(n,h);
 for i=1:h
  a_hidden_weights1(:,i)=-0+(w+0)*rand(1,n,'single');
 end
 %Agent 2
 a_input_weights2=zeros(h,m);
 for i=1:m
    a_input_weights2(:,i)=-0+(w2+0)*rand(1,h,'single');
 end
 a_hidden_weights2=zeros(n,h);
 for i=1:h
  a_hidden_weights2(:,i)=-0+(w2+0)*rand(1,n,'single');
 end
 %Agent 3
 a_input_weights3=zeros(h,m);
 for i=1:m
    a_input_weights3(:,i)=-0+(w3+0)*rand(1,h,'single');
 end
 a_hidden_weights3=zeros(n,h);
 for i=1:h
  a_hidden_weights3(:,i)=-0+(w3+0)*rand(1,n,'single');
 end
 
 simOut=sim('NewMultiMicrogrid','SimulationMode','normal','AbsTol','1e-5',...
           'SaveState','on','StateSaveName','xout2',...
           'SaveTime','on','TimeSaveName','time',...
           'SaveFormat', 'Dataset');
 Epochs=1+Epochs;
 Reward1=simOut.get('Reward1');
 Reward2=simOut.get('Reward2');
 Reward3=simOut.get('Reward3');
 AvrReward1=mean(Reward1(2:1001,1));
 AvrReward2=mean(Reward2(2:1001,1));
 AvrReward3=mean(Reward3(2:1001,1));
 if (AvrReward1>BestAvrReward1)%Weights with max reward selection
   BestAvrReward1=AvrReward1;
   save('BestWeights1.mat','a_hidden_weights1','a_input_weights1','AvrReward1');
 end
 if (AvrReward2>BestAvrReward2)%Weights with max reward selection
   BestAvrReward2=AvrReward2;
   save('BestWeights2.mat','a_hidden_weights2','a_input_weights2','AvrReward2');
  end
 if (AvrReward3>BestAvrReward3)%Weights with max reward selection
   BestAvrReward3=AvrReward3;
   save('BestWeights3.mat','a_hidden_weights3','a_input_weights3','AvrReward3');
 end
 disp('Average reward');
 disp(AvrReward1+AvrReward2+AvrReward3);
 %clean;
end
%gamma=0.5;% discount factor
