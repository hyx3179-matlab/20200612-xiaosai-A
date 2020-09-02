load('matlab.data.mat')
data1=data;
% data=[yj;data];
n=zeros(length(data),1);
for ii=1:length(data)
    data2=sum((data-data(ii,:)).^2,2).^0.5;
    data2(ii)=inf;
    [~,n(ii)]=min(data2);
end
figure
hold on
scatter(data(:,1),data(:,2))
scatter(yj(:,1),yj(:,2))
scatter(zx(:,1),zx(:,2),'b')

for ii=1:length(data)
    plot([data(ii,1),data(n(ii),1)],[data(ii,2),data(n(ii),2)],'c')
end