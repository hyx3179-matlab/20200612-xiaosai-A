% 默认不计算，直接载入数据,
clear
load('matlab.data.mat')

tt=length(data);

swyj_index=[];
for ii=1:2
    
    ej_j=[];
    parfor jj=1:tt
        yj_sdsd=[yj;data([swyj_index,jj],:)];
        data_feqf=data;
        data_feqf([swyj_index,ii],:)=[];
        [~,ej_len]=get_len(data_feqf,yj_sdsd,zx,0);
        ej_j=[ej_j;ej_len];
    end
     
    [~,min_ej_j]=min(ej_j);
    
    swyj_index=[swyj_index,min_ej_j];
end

yj=[yj;data(swyj_index,:)];
data(swyj_index,:)=[];
[yj_len,ej_len,~]=get_len(data,yj,zx,1);

clear data yj zx ii tt ej_j min_ej_j