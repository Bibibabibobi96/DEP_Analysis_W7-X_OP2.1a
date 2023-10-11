%把任意偏滤器靶板上的点转变为module 1下靶板上对应位置的点
% xyz表示点的坐标，应为在同一靶板上的坐标
% n表示module number，configuration表示位形
%
function [x,y,z] = W7X_divertorXYZ_transform(x,y,z,n,configuration)

if n ~= 1
    original_points = [x;y;z]';

    angle_degrees = -72*(n-1);
    angle_radians = deg2rad(angle_degrees);

    % 绕Z轴旋转矩阵
    rotation_matrix = [
        cos(angle_radians), -sin(angle_radians), 0;
        sin(angle_radians), cos(angle_radians), 0;
        0, 0, 1;
        ];

    % 执行旋转操作
    rotated_points = (rotation_matrix * original_points')';

    x = rotated_points(:,1)';
    y = rotated_points(:,2)';
    z = rotated_points(:,3)';
end

% if (strcmp(configuration, 'standard') && (n == 1 || n == 5)) || ...
%         (strcmp(configuration, 'high iota') && (n == 3 || n == 5))
if sum(z>0) > 0
    % 转换为矩阵形式
    points = [x', y', z'];

    % 定义镜像平面的法向量
    phi_deg = 90;  % 镜像平面的角度（度数）
    phi_rad = deg2rad(phi_deg);
    mirror_plane_normal = [cos(phi_rad), 0, sin(phi_rad)];

    % 对称变换
    mirrored_points = points - 2 * ((points * mirror_plane_normal') ./ norm(mirror_plane_normal)^2) * mirror_plane_normal;

    % 提取镜像后的坐标
    mirrored_x = mirrored_points(:, 1);
    mirrored_y = mirrored_points(:, 2);
    mirrored_z = mirrored_points(:, 3);

    x = mirrored_x';
    y = -mirrored_y';
    z = mirrored_z';
end

end



