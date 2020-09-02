function [yj_len,ej_len,index]=get_len(data,yj,zx,set_figure)
data1=data;
data=[yj;data];
FW=length(data);
S=zeros(1,length(data)*FW);
E=zeros(1,length(data)*FW);
W=zeros(1,length(data)*FW);
D=zeros(1,FW);
for ii=1:length(data)
    data2=sum((data-data(ii,:)).^2,2).^0.5;
    S(1,(ii-1)*FW+1:ii*FW)=D+ii;
    W(1,(ii-1)*FW+1:ii*FW)=data2;
    E(1,(ii-1)*FW+1:ii*FW)=1:length(data);
end
DG = sparse(S,E,W);
[~,pred]=graphminspantree(DG);

data_yj=[zx;yj];
FW=length(data_yj);
S=zeros(1,length(data_yj)*FW);
E=zeros(1,length(data_yj)*FW);
W=zeros(1,length(data_yj)*FW);
D=zeros(1,FW);
for ii=1:length(data_yj)
    data2=sum((data_yj-data_yj(ii,:)).^2,2).^0.5;
    S(1,(ii-1)*FW+1:ii*FW)=D+ii;
    W(1,(ii-1)*FW+1:ii*FW)=data2;
    E(1,(ii-1)*FW+1:ii*FW)=1:length(data_yj);
end
DG = sparse(S,E,W);
[~,pred_yj]=graphminspantree(DG);


index = [[1:length(pred_yj)-1,1:length(pred)];[pred_yj(2:end)-1,pred]]';
nn=get_nn(index,data);

for ii=1:length(nn)
    index(index(:,1)==nn(ii,1)&index(:,2)==nn(ii,2),:)=[];
end


tt=find(index(:,1)==1&index(:,2)==0);

data2=sum((data_yj(index(1:tt-1,1)+1,:)-data_yj(index(1:tt-1,2)+1,:)).^2,2).^0.5;
yj_len=sum(data2);
data2=sum((data(index(tt+1:end,1),:)-data(index(tt+1:end,2),:)).^2,2).^0.5;
ej_len=sum(data2);



if set_figure
    
    figure
    hold on
    scatter(data1(:,1),data1(:,2))
    scatter(yj(:,1),yj(:,2))
    scatter(zx(:,1),zx(:,2),'b')
    % awbraeynr=0;
    % for ii=1:length(data)
    %     if pred(ii)~=0
    % %         x=data(ii,1);
    % %         y=data(ii,2);
    % %         u=data(pred(ii),1)-data(ii,1);
    % %         v=data(pred(ii),2)-data(ii,2);
    %         %                 quiver(x+u,y+v,-u,-v,'c','AutoScale','off','LineWidth',1,'MaxHeadSize',1);
    % %         plot([data(ii,1),data(pred(ii),1)],[data(ii,2),data(pred(ii),2)],'b')
    %
    %     x=[data(ii,1),data(pred(ii),1)];
    %     y=[data(ii,2),data(pred(ii),2)];
    %     awbraeynr=awbraeynr+((x(1)-x(2))^2+(y(1)-y(2))^2)^.5;
    %     end
    % end
    for ii=13:length(index)
        if index(ii,2)~=0
            %         x=data(ii,1);
            %         y=data(ii,2);
            %         u=data(pred(ii),1)-data(ii,1);
            %         v=data(pred(ii),2)-data(ii,2);
            %                 quiver(x+u,y+v,-u,-v,'c','AutoScale','off','LineWidth',1,'MaxHeadSize',1);
            x=[data(index(ii,1),1),data(index(ii,2),1)];
            y=[data(index(ii,1),2),data(index(ii,2),2)];
            plot(x,y,'b')
        end
    end
    for ii=2:length(data_yj)
        %     x=data_yj(ii,1);
        %     y=data_yj(ii,2);
        %     u=data_yj(pred_yj(ii),1)-data_yj(ii,1);
        %     v=data_yj(pred_yj(ii),2)-data_yj(ii,2);
        %         quiver(x+u,y+v,-u,-v,'r','AutoScale','off','LineWidth',1,'MaxHeadSize',1);
        x=[data_yj(ii,1),data_yj(pred_yj(ii),1)];
        y=[data_yj(ii,2),data_yj(pred_yj(ii),2)];
        plot(x,y,'r')
    end
    hold off
    axis equal
    axis([0 49 0 56])
end
