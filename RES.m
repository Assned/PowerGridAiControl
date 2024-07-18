sys = rss(3,2,2);

set(0,'defaulttextinterpreter','latex')
set(0,'defaultfigurecolor',[1 1 1])
set(0,'defaultaxesfontsize',11);
set(0,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor','DefaultTextColor'},...
    {'k','k','k','k'});


figure(3);
subplot(3,1,1);
plot(axis(:,1),S1_RES1(:,1),'-','Color', [0.25 0.5 0.5],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.15 0.35]);
ylabel('$\Delta P_{RES_1}$ [p.u.]','FontSize',12);
%xlabel('(a)');
subplot(3,1,2);
plot(axis(:,1),S1_RES2(:,1),'-','Color', [0.25 0.5 0.25],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.15 0.275]);
ylabel('$\Delta P_{RES_2}$ [p.u.]','FontSize',12);
subplot(3,1,3);
plot(axis(:,1),S1_RES3(:,1),'-','Color', [0.25 0.25 0.5],'LineWidth',1.25);
xlim([0 1000]);
ylim([0.05 0.2]);
ylabel('$\Delta P_{RES_3}$ [p.u.]','FontSize',12);
xlabel('Time [s]');
%xlabel('(b)');
axesHandles = findall(0,'type','axes');
set(axesHandles,'TickLabelInterpreter', 'latex')