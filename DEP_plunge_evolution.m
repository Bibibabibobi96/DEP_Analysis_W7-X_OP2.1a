%%
clear mesh

mesh.time_gap = 500;
mesh.r_gap = 1000;
if shot < 221206037
    mesh.max_r = 6080;
elseif shot == 221207050 || shot == 221207054
    mesh.max_r = 6200;
else
    mesh.max_r = 6150;
end
font_size = 12;

% tic

for i = 1:plunge_n
    %     i = 1

    mesh.min_r(i) = min(position(plunge_index(3*i-2):plunge_index(3*i)))+10;
    %     max_r = max(position(plunge_index(3*i-2):plunge_index(3*i)))+60;
    mesh.r(i,:) = linspace(mesh.min_r(i),mesh.max_r,mesh.r_gap);
    %     clear mesh_IA1 mesh_IA2 mesh_time1 mesh_time2

    [~,mesh.index1(i)] = min(abs(position(plunge_index(3*i-2):plunge_index(3*i-1)) - mesh.max_r));
    mesh.index2(i) = plunge_index(3*i-1) - plunge_index(3*i-2);
    [~,mesh.index3(i)] = min(abs(position(plunge_index(3*i-1):plunge_index(3*i)) - mesh.max_r));

    for j = 1:mesh.time_gap:mesh.index2(i) - mesh.index1(i)
        %     for j = 1:100:mesh.index1
        x = linspace(position( plunge_index(3*i-1) - j)+10 ,position( plunge_index(3*i-1) - j)+60, 11);
        for k = 1:11
            v1(k) = IA(k, plunge_index(3*i-1) - j);
            v2(k) = IB(k, plunge_index(3*i-1) - j);
        end
        mesh.IA1((j-1)/mesh.time_gap + 1,:) = interp1(x,v1,mesh.r(i,:),'cubic');
        mesh.IB1((j-1)/mesh.time_gap + 1,:) = interp1(x,v2,mesh.r(i,:),'cubic');
        mesh.time1((j-1)/mesh.time_gap + 1) = time(plunge_index(3*i-2) + mesh.index1(i) + j);
    end

    for j = 1:mesh.time_gap:mesh.index3(i)
        %     for j = 1:100:mesh.index1
        x = linspace(position( plunge_index(3*i-1) + j)+10 ,position( plunge_index(3*i-1) + j)+60, 11);
        for k = 1:11
            v1(k) = IA(k, plunge_index(3*i-1) + j);
            v2(k) = IB(k, plunge_index(3*i-1) + j);
        end
        mesh.IA2((j-1)/mesh.time_gap + 1,:) = interp1(x,v1,mesh.r(i,:),'cubic');
        mesh.IB2((j-1)/mesh.time_gap + 1,:) = interp1(x,v2,mesh.r(i,:),'cubic');
        mesh.time2((j-1)/mesh.time_gap + 1) = time(plunge_index(3*i-1) + j);
    end

    clear v1 v2 x fields

    mesh.IA{i} = [flip(mesh.IA1,1);mesh.IA2];
    mesh.IB{i} = [flip(mesh.IB1,1);mesh.IB2];
    mesh.time{i} = [flip(mesh.time1,1),mesh.time2];

    fields = {'IA1','IA2','IB1','IB2','time1','time2'};
    mesh = rmfield(mesh,fields);

end

toc




