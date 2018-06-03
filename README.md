# BEM
基函数扩展模型相关matlab代码，包含信道估计及其均衡


# Demo:
N=64;<br>
ap = ones(N,1);<br>
I_path_M = 1;% 假设的数据传输信道下的子径个数，该参数大于H_Path_M/P即可。<br>
I_Dopl_D = 32;% 假设的数据传输信道下的子径个数<br>
I_Dop_Max = 1 ; %假设的信道最大多普勒<br>
iA = calc_iA(ap,I_path_M,I_Dopl_D,I_Dop_Max);<br>
iH = calc_iH(iA,ap_estm,I_path_M,I_Dopl_D,I_Dop_Max,'ZF');<br>
