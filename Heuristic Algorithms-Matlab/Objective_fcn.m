function fitness = Objective_fcn(k)
Kp = k(1); Ki = k(2); Kd = k(3);
closed_loop = tf([15*Kd,15*Kp,15*Ki],[1.08,(6.1+15*Kd),(1.63+15*Kp),(15*Ki)]);
[omega,Tsim] = step(closed_loop,1);
e = 1 - omega;
fitness = trapz(Tsim,Tsim.*abs(e));
end