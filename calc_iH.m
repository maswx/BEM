function iH = calc_iH(iA,r,path_M,Dopl_D,Dop_Max,meth,SNR)
%% 根据输入A矩阵的逆矩阵iA以及接收到的导频信号 r 计算信道的逆矩阵
% example :iH = calc_iH(iA,ap,1,1,meth,SNR)
% 输入
% iA     : A矩阵的逆矩阵
% r      : 接收到的、过信道的导频信号ap
% path_M : 假设的最大信道时延
% Dopl_D  : 假设的最大多普勒个数
% Dop_Max: 假设的最大多普勒值， 假设的多普勒均匀分布在0~Dop_Max之间，中间的点数是Dopl_D
% meth   : 信道估计方法，支持两种。
%          meth='ZF':迫零估计
%          meth='MMSM':最小均方误差估计
% SNR    : 当前接收状态下信号的信噪比。
% 输出
% iH     : 信道矩阵H的逆矩阵。
 


N = length(r);
%% 
if path_M * Dopl_D >N
    error('path_M * Dopl_D >N !')
end
ED = eye(Dopl_D);
EM = eye(path_M);
O_zeros = zeros(N-path_M, path_M);
Y = kron(ED,[EM;O_zeros ]);
Y_iA = Y*iA;
c_temp = iA*r;
c = Y*c_temp; 

cc = reshape(c,[N,Dopl_D]); 
H_est = zeros(N);
n = 0:N-1;
fd = linspace(0,Dop_Max,Dopl_D);%% 测频基 
for ddd = 1:1:Dopl_D 
    Cd = circ(cc(:,ddd));
    Fd = exp(1j*2*pi*fd(ddd) * n/N);
    H_est = H_est + diag(Fd) * Cd ; 
end
snrIndB = SNR;
snrLinear = 10^(0.1*snrIndB);
if strcmp(meth,'ZF')
    iH = pinv(H_est);%迫零
elseif strcmp(meth, 'MMSE') 
    iH = pinv(H_est'*H_est + (N/snrLinear) *eye(N))*H_est';
end



