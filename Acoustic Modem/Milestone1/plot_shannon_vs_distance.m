% shannonplot = zeros(20,1);
% disp('Kortste Afstand!');
% for it = 1 : 1 : 20
%    
%         disp('Sample nu!');
%         fastshannon;
%         shannonplot(it,1)=C;
%         disp('Verder..');
%         pause;
% end
% figure(2);
% plot(shannonplot);
figure('Name','Channel capacity vs distance from speaker')
shannonplot = importdata('shannonplot.mat')
distance = 1 : 8 : 160;
plot(distance,shannonplot);
ylabel('Capacity');
xlabel('Distance');