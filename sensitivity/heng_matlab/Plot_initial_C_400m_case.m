subplot(2,2,1);
h_initial = h5read('C:/Users/daih524/Desktop/2015_Spring/BC_400m_Dr_Chen/H_initial_hdf5_OK_2015_2016/H_initial_OK.h5','/Initial_Head/Data');

x1 = linspace(1,399,200);
y1 = linspace(1,399,200);
surf(x1,y1,h_initial,'edgecolor','none');
xlim([0 400]);
ylim([0 400]);
set(gca,'fontsize',14);
%set(gca, 'Position', [0.03 0.03 0.225*2 0.400*2])
xlabel('X','FontSize',18);
ylabel('Y','FontSize',18);
view(2);
box on;
colorbar;
caxis([105.43 105.63]);

subplot(2,2,2);
h_initial = h5read('C:/Users/daih524/Desktop/2015_Spring/BC_400m_Dr_Chen/H_initial_hdf5_OK_2010_2015_wrong/H_initial_OK.h5','/Initial_Head/Data');

x1 = linspace(1,399,200);
y1 = linspace(1,399,200);
surf(x1,y1,h_initial,'edgecolor','none');
xlim([0 400]);
ylim([0 400]);
set(gca,'fontsize',14);
%set(gca, 'Position', [0.03 0.03 0.225*2 0.400*2])
xlabel('X','FontSize',18);
ylabel('Y','FontSize',18);
view(2);
box on;
colorbar;
caxis([105.43 105.63]);

subplot(2,2,3);
h_initial = h5read('C:/Users/daih524/Desktop/2015_Spring/BC_400m_Dr_Chen/H_initial_hdf5_OK_2015_2016_test/H_initial_OK.h5','/Initial_Head/Data');

x1 = linspace(1,399,200);
y1 = linspace(1,399,200);
surf(x1,y1,h_initial,'edgecolor','none');
xlim([0 400]);
ylim([0 400]);
set(gca,'fontsize',14);
%set(gca, 'Position', [0.03 0.03 0.225*2 0.400*2])
xlabel('X','FontSize',18);
ylabel('Y','FontSize',18);
view(2);
box on;
colorbar;
caxis([105.005 105.055]);

subplot(2,2,4);
h_initial = h5read('C:/Users/daih524/Desktop/2015_Spring/BC_400m_Dr_Chen/H_initial_hdf5_OK_2015_2016_wrong/H_initial_OK.h5','/Initial_Head/Data');

x1 = linspace(1,399,200);
y1 = linspace(1,399,200);
surf(x1,y1,h_initial,'edgecolor','none');
xlim([0 400]);
ylim([0 400]);
set(gca,'fontsize',14);
%set(gca, 'Position', [0.03 0.03 0.225*2 0.400*2])
xlabel('X','FontSize',18);
ylabel('Y','FontSize',18);
view(2);
box on;
colorbar;
caxis([105.005 105.055]);