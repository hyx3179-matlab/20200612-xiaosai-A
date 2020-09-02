function index=Delete_endpoint(index,len)
% global inder
while 1
    jj=length(index);
    for ii=1:len
        n=[find(index(:,2)==ii);index(index(:,1)==ii,2)];
        if length(n)==1
            index(index(:,1)==ii,:)=[];
            index(index(:,2)==ii,:)=[];
        end
    end
    if jj==length(index)
        break
    end
end