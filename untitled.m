% 在工作进程中计算 pi 的值
parpool
spmd
    N = 1000000;
    x = 1:N;
    y = (-1).^(x+1)./x;
    pi_part = 4*sum(y);
end

% 将所有工作进程中计算得到的 pi 值求平均
pi_total = mean([pi_part{:}]);

% 输出结果
fprintf('pi = %f\n', pi_total);

% 初始化变量
n = 10000;
a = zeros(1, n);
b = ones(1, n);

% 使用 for 循环计算
tic
for i = 1:n
    a(i) = i^2;
    b(i) = sin(i);
end
toc

% 使用 spmd 语句并行计算
tic
spmd
    % 每个工作进程计算一部分 a 和 b 的值
    my_n = ceil(n/numlabs);
    my_start = (labindex-1)*my_n + 1;
    my_end = min(labindex*my_n, n);
    for i = my_start:my_end
        a(i) = i^2;
        b(i) = sin(i);
    end
end
toc


