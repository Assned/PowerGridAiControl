
sys = rss(3,2,2);

set(0,'defaulttextinterpreter','latex')
set(0,'defaultfigurecolor',[1 1 1])
set(0,'defaultaxesfontsize',11);
set(0,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor','DefaultTextColor'},...
    {'k','k','k','k'});


figure(3);
subplot(3,1,1);
plot(axis(:,1),S1_load1(:,1),'-','Color', [0.0 0.75 1.0],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.4 0.7]);
ylabel('$\Delta P_{Load_1}$ [p.u.]','FontSize',12);
%xlabel('(a)');
subplot(3,1,2);
plot(axis(:,1),S1_load2(:,1),'-','Color', [0.75 0.25 0.5],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.35 0.65]);
ylabel('$\Delta P_{Load_2}$ [p.u.]','FontSize',12);
subplot(3,1,3);
plot(axis(:,1),S1_load3(:,1),'-','Color', [0.0 0.5 0.5],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.2 0.325]);
ylabel('$\Delta P_{Load_3}$ [p.u.]','FontSize',12);
xlabel('Time [s]');
%xlabel('(b)');
axesHandles = findall(0,'type','axes');
set(axesHandles,'TickLabelInterpreter', 'latex')