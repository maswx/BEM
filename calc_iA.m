function iA = calc_iA(s,path_M,Dopl_D,Dop_Max)
N = length(s);
if path_M * Dopl_D >N
    error('path_M * Dopl_D >N !')
end
%% Ss_Toe
Ss_Toe = circ(s); 
%% A为已知信息
fd = linspace(0,Dop_Max,Dopl_D);%% 测频基 
A = zeros(N,N*Dopl_D);
n = 0:N-1;
for ddd = 0:1:Dopl_D-1
    Fd = exp(1j*2*pi*fd(ddd+1) * n/N);
    A(:,1+ddd*N:N+ddd*N) = diag(Fd) * Ss_Toe;
end

ED = eye(Dopl_D);
    M_ = path_M;
% if fix(N/Dopl_D)<path_M
%     M_ = path_M
% else
%     M_ = fix(N/Dopl_D);
% end
EM_ = eye(M_);
O_zeros = zeros(N-M_, M_);
Y = kron(ED,[EM_;O_zeros ]);

A = A*Y;
iA = pinv(A);%迫零
