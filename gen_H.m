function H = gen_H(N,H_Path_M,H_Dopl_D,Dop_Max)
%% 基于循环前缀或连续数据发射模型的信道响应函数
% example :H = Gen_H(1024,4,4,0.01)
% N为采样点数
% H_Path_M为多径路径个数
% H_Dopl_D 为多普勒频移的个数。
% Dop_Max为最大多普勒频移，
d = zeros(1,N);
d(2) = 1;
D  = conj(circ(d)');
n  = 0:N-1;
fd = linspace(0,Dop_Max,H_Dopl_D);%% 
h_m_d = rand(H_Dopl_D,H_Path_M)-0.5 + (rand(H_Dopl_D,H_Path_M)-0.5) * 1j;
h_m_d = h_m_d/10;
H_temp = zeros(N);
for d = 1:H_Dopl_D
    Fd = diag(exp(1j*2*pi*fd(d) * n/N));
    for m = 1:H_Path_M
        H_temp = H_temp + Fd * conj((h_m_d(d,m) * D^(m-1))');
    end
end
%% 生成信道结束
H = H_temp;


%  
% %% 验证论文公式3-2-12
% Cd = zeros(N,N,H_Dopl_D); 
% for d = 1:H_Dopl_D
%     for m = 1:H_Path_M 
%         Cd(:,:,d) = Cd(:,:,d) + conj((h_m_d(d,m) * D^(m-1))'); 
%     end 
% end 
% H_temp2 = zeros(N);
% for d = 1:H_Dopl_D
%     Fd = diag(exp(1j*2*pi*fd(d) * n/N));
%     H_temp2 = H_temp2 + Fd * Cd(:,:,d);
% end
% tet = H_temp2 - H_temp;
% H_norm = norm(tet,2)
% %% 验证pass
% 
% 
% %% 验证公式3-2-16
% % s = ones(N,1) + ones(N,1) * 1j;
% s = round(rand(N,1)) + round(rand(N,1)) * 1j;
% r = H*s;
% Rr_Toe = zeros(N);
% Ss_Toe = circ(s);
% for d = 1:H_Dopl_D
%     Fd = diag(exp(1j*2*pi*fd(d) * n/N));
%     Rr_Toe = Rr_Toe + Fd * Ss_Toe * Cd(:,:,d);
% end
% r2 = Rr_Toe(:,1);
% r_norm = norm(r-r2,2)
% %% 验证pass
%     
% %% 验证A与c
% A = zeros(N,N*H_Dopl_D);
% for d = 1:H_Dopl_D
%     Fd = diag(exp(1j*2*pi*fd(d) * n/N));
%     A(:,1+(d-1)*N:N+(d-1)*N) = Fd * Ss_Toe;
% end
% c = zeros(N*H_Dopl_D,1);
% for d = 1:H_Dopl_D
%     h = Cd(:,:,d);
%     hd = h(:,1);
%     c(1 + (d-1)*N: N+(d-1)*N) = hd;
% end
% r_verify = A*c;
% r_norm = norm(r-r_verify,2)
% %% 验证pass
% 
% %% 验证iA 及其 计算出来的c
% ED  = eye(H_Dopl_D);
% EM_ = eye(fix(N/H_Dopl_D));
% O_zeros = zeros(N-fix(N/H_Dopl_D), fix(N/H_Dopl_D));
% Y = kron(ED,[EM_;O_zeros ]);
% A = A*Y;
% iA = pinv(A);%迫零
% c_ = iA*r;
% c_verify = Y*c_; 
% c_norm = norm(c - c_verify, 2 )
% %% 验证pass
% 
% %% 验证H
% 
% 
% cc = reshape(c_verify,[N,H_Dopl_D]); 
% H_est = zeros(N);
% for d = 1:1:H_Dopl_D 
%     Cd2 = circ(cc(:,d));
%     Fd = diag(exp(1j*2*pi*fd(d) * n/N));
%     H_est = H_est + Fd * Cd2 ; 
% end
% H_est_norm = norm(H - H_est,2)
% 
% figure(1)
% imagesc(abs( H )); 
% figure(2)
% imagesc(abs( H_est )); 
% 
%  
% 
% 



