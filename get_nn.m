function nn=get_nn(index,data)
nn=zeros(200,2);
nn_js=0;
while 1
    nn_js=nn_js+1;
    index=Delete_endpoint(index,length(data));
    tt=find(index(:,1)==1&index(:,2)==0);
    data2=sum((data(index(tt+1:end,1),:)-data(index(tt+1:end,2),:)).^2,2).^0.5;
    [~,n]=max(data2);
    if isempty(index(n+tt,:))
        break
    end
    nn(nn_js,:)=index(n+tt,:);
    index(n+tt,:)=[];
end