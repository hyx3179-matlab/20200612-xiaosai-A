% 默认不计算，直接载入数据
% 计算 设 js 为非零，计算时间 i7-7700hq 20秒左右
clear
load('matlab.data.mat')
% load('main3_jg.mat')
js=1;

if js
    tic
    swyj_index=[];
    while 1
        group_j=[];
        parfor ii=1:167
            %         if ~sum(zhwyj==ii)
            yj_cache=[yj;data([swyj_index,ii],:)];
            data_cache=data;
            data_cache([swyj_index,ii],:)=[];
            [~,~,~,group]=get_group(data_cache,yj_cache,zx);
            %             yj_j=[yj_j,yj_len];
            %             ej_j=[ej_j,ej_len];
            group_j=[group_j,group];
            %         end
            
        end
        
        [min_q_len,min_q_index]=min(max(group_j,[],1));
        
        if min_q_len<=40
            swyj_index=[swyj_index,min_q_index];
            break
        end
        
        [~,min_var_index]=min(var(group_j,1,1));
        
        swyj_index=[swyj_index,min_var_index];
        %     zhwyj=[zhwyj,wegwher];
    end
    toc
end
yj=[yj;data(swyj_index,:)];
data(swyj_index,:)=[];
[yj_len,ej_len,~]=get_len(data,yj,zx,1);
% [~,~,~,group]=get_group(data,yj,zx);

clear data yj zx group_j min_q_index min_q_len min_var_index js group_j
