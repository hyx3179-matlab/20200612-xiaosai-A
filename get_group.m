function [yj_len,ej_len,a,group]=get_group(data,yj,zx)

[yj_len,ej_len,a]=get_len(data,yj,zx,0);

ff=length(yj);

a=a(find(a(:,1)==1&a(:,2)==0)+1:end,:);

for ii=1:ff
    a(a(:,2)==ii,3)=ii;
    a(a(:,1)==ii,3)=ii;
end

while 1
    for ii=1:ff
        n=[a(a(:,3)==ii,1);a(a(:,3)==ii,2)];
        for jj=1:length(n)
            a(a(:,2)==n(jj),3)=ii;
            a(a(:,1)==n(jj),3)=ii;
        end
    end
    if isempty(find(a(:,3)==0, 1))
        break
    end
end

data1=[yj;data];
group=zeros(ff,1);
for ii=1:ff
    n=find(a(:,3)==ii);
    data2=sum((data1(a(n,1),:)-data1(a(n,2),:)).^2,2).^0.5;
    group(ii,1)=sum(data2);
end