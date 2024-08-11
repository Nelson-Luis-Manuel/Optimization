function w = W_index(Mp,Tr,Ts,Ess)

rho = 1;
w = (1 - exp(-rho))*(Mp + Ess) + (exp(-rho))*(Ts - Tr);

end
