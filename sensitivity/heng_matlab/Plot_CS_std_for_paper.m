krige_data = load('..\Data_for_Test_Case\BC_Data_From_Chen\4heng\CS_OK\Contact_surfaceexponential_drift0.txt');
krige_data = reshape(krige_data,120,120);
data2 = h5read('C:\Users\daih524\Desktop\2015_Spring\Data_for_Test_Case\Test_case_Input_Include_HDF5_Files\plot120x120x15_ngrid120x120x30_material.h5','/Materials/Material Ids');
datanew = reshape(data2,[120 120 30]);
for i = 1:120
    for j = 1:120
         a = find(datanew(j,i,:) == 4,1,'last');
         depth(j,i) = 95 + a*0.5;
    end
end
nsim = 100;
for i = 1:nsim
    CS_cs(1:14400,i) = load(sprintf('C:\\Users\\daih524\\Desktop\\2015_Spring\\Data_for_Test_Case\\BC_Data_From_Chen\\4heng\\CS_CS\\CS%d.txt',i));
    CS(1:120,1:120,i) = reshape(CS_cs(:,i),[120 120]);
end
CS_new(1:120,1:120,1) = krige_data';
CS_new(1:120,1:120,2) = depth';
CS_new(1:120,1:120,3) = CS(1:120,1:120,7)';
CS_new(1:120,1:120,4) = CS(1:120,1:120,20)';
CS_new(1:120,1:120,5) = CS(1:120,1:120,60)';
CS_new(1:120,1:120,6) = CS(1:120,1:120,94)';
CS_new(1:120,1:120,7) = CS(1:120,1:120,76)';
CS_new(1:120,1:120,8) = CS(1:120,1:120,67)';
CS_new(1:120,1:120,9) = CS(1:120,1:120,90)';
CS_new(1:120,1:120,10) = CS(1:120,1:120,99)';
for i = 1:120
    for j = 1:120
        CS_var(i,j) = std(CS_new(i,j,:));
    end
end
surface(1:120,1:120,CS_var,'edgecolor','none');
set(gca,'fontsize',20)
view(2);
axis square;
colormap jet;
box on;
colorbar;
axis([1 120 1 120]);
caxis([0 1.5]);
xlabel('X (m)','fontsize',24);
ylabel('Y (m)','fontsize',24);
title('Standard deviation of contact surface simulations');
