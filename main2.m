% Ĭ�ϲ����㣬ֱ����������  swyj_index II������ΪI��������
% ���� �� js Ϊ���㣬����ʱ�� i7-7700hq 200������
clear
load('matlab.data.mat')
% load('main2_sj.mat')
js=1;

if js
    tt=length(data);
    ej_j=[];
    parfor ii=1:tt
        for jj=ii+1:tt
            yj_cache=[yj;data([ii jj],:)];
            data_cache=data;
            data_cache([ii jj],:)=[];
            [~,ej_len]=get_len(data_cache,yj_cache,zx,0);
            ej_j=[ej_j;[ej_len,ii,jj]];
        end
    end
end


[~,min_ej_index]=min(ej_j(:,1));

swyj_index=ej_j(min_ej_index,2:end);

yj=[yj;data(swyj_index,:)];
data(swyj_index,:)=[];
[yj_len,ej_len,~]=get_len(data,yj,zx,1);

clear data yj zx min_ej_index js ej_j
