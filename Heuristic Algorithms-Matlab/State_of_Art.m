
clc;
clear;
close all;

%% DC Motor Parameters:
 
% Armature Voltage :
% V = 200;       %[V] 
% Armature Resistor :  
Ra = 0.4;      %[ohm] 
% Armature Inductance :
La = 2.7;    %[H]
% Tork constant:  
Kt = 0.015;      %[N.m/A]  
% Rotor inertia:
Jm = 0.0004;      %[Kg.m2]
% Electromotive Force:
Kb = 0.05;     %[V.s/rad]  
% Viscous Friction: 
Bm = 0.0022;    %[N.m.s/rad] 

%% SCENARIO I
% Ra = 0.30;
% Kt = 0.012;
%% SCENARIO II
% Ra = 0.30;
% Kt = 0.018;
%% SCENARIO III
% Ra = 0.50;
% Kt = 0.012;
%% SCENARIO IV
% Ra = 0.50;
% Kt = 0.018;


%% Optimal K's
OBL_HSO      = round([16.9327 0.9508 2.8512],10);
HSO          = round([13.4430 1.2059 2.2707],10);
ASO          = round([11.9437 2.0521 2.4358],10);
SFS          = round([1.6315  0.2798 0.2395],10);
GWO          = round([6.8984  0.5626 0.9293],10);
SCA          = round([4.5012 0.5260 0.5302],10);

figure(1)
col = {'Kp','Ki','Kd'};
row = {'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'};
dat = {num2str(OBL_HSO(1)),num2str(OBL_HSO(2)),num2str(OBL_HSO(3));...
       num2str(HSO(1)),num2str(HSO(2)),num2str(HSO(3));...
       num2str(ASO(1)),num2str(ASO(2)),num2str(ASO(3));...
       num2str(SFS(1)),num2str(SFS(2)),num2str(SFS(3));...
       num2str(GWO(1)),num2str(GWO(2)),num2str(GWO(3));...
       num2str(SCA(1)),num2str(SCA(2)),num2str(SCA(3))
       };
uitable('columnname',col,'rowname',row,'position',[10 120 390 300],'data',dat);


%% 
% Kp_1 = kEO(1); Ki_1 = kEO(2); Kd_1 = kEO(3);
numer1 = [Kt*OBL_HSO(3) Kt*OBL_HSO(1) Kt*OBL_HSO(2)];
denom1 = [La*Jm (La*Bm + Ra*Jm + Kt*OBL_HSO(3)) (Ra*Bm + Kb*Kt + Kt*OBL_HSO(1))  Kt*OBL_HSO(2)];
  sys1 = tf(numer1, denom1);
% sys1 = tf([15*Kd_1,15*Kp_1,15*Ki_1],[1.08,(6.1+15*Kd_1),(1.63+15*Kp_1),(15*Ki_1)]);

%% 
numer2 = [Kt*HSO(3) Kt*HSO(1) Kt*HSO(2)];
denom2 = [La*Jm (La*Bm + Ra*Jm + Kt*HSO(3)) (Ra*Bm + Kb*Kt + Kt*HSO(1))  Kt*HSO(2)];
sys2 = tf(numer2, denom2);

%% 
numer3 = [Kt*ASO(3) Kt*ASO(1) Kt*ASO(2)];
denom3 = [La*Jm (La*Bm + Ra*Jm + Kt*ASO(3)) (Ra*Bm + Kb*Kt + Kt*ASO(1))  Kt*ASO(2)];
sys3 = tf(numer3, denom3);

%% 
numer4 = [Kt*SFS(3) Kt*SFS(1) Kt*SFS(2)];
denom4 = [La*Jm (La*Bm + Ra*Jm + Kt*SFS(3)) (Ra*Bm + Kb*Kt + Kt*SFS(1))  Kt*SFS(2)];
sys4 = tf(numer4, denom4);
%% 
numer5 = [Kt*GWO(3) Kt*GWO(1) Kt*GWO(2)];
denom5 = [La*Jm (La*Bm + Ra*Jm + Kt*GWO(3)) (Ra*Bm + Kb*Kt + Kt*GWO(1))  Kt*GWO(2)];
sys5 = tf(numer5, denom5);

%%
numer6 = [Kt*SCA(3) Kt*SCA(1) Kt*SCA(2)];
denom6 = [La*Jm (La*Bm + Ra*Jm + Kt*SCA(3)) (Ra*Bm + Kb*Kt + Kt*SCA(1))  Kt*SCA(2)];
sys6 = tf(numer6, denom6);

%% Bode Plots
figure(2)
bode(sys1,'r',sys2,'b',sys3,'y',sys4,'m',sys5,'c',sys6,'k');
grid on;
legend('OBL_HSO','HSO ','ASO','SFS','GWO','SCA');
%% Step Response
figure(3)
step(sys1,'g',sys2,'b',sys3,':m',sys4,'--y',sys5,'r',sys6,'k',1.2);
ylabel('Speed')
legend('OBL_HSO','HSO ','ASO','SFS','GWO','SCA');
set(findall(gcf,'type','line'),'linewidth',1.25);

%% RiseTime, Settling Time and OverShoot
info1 = stepinfo(sys1);
info2 = stepinfo(sys2);
info3 = stepinfo(sys3);
info4 = stepinfo(sys4);
info5 = stepinfo(sys5);
info6 = stepinfo(sys6);
% info1.RiseTime
% info1.SettlingTime
% info1.Overshoot

% info2.RiseTime
% info2.SettlingTime
% info2.Overshoot

% info3.RiseTime
% info3.SettlingTime
% info3.Overshoot

% info4.RiseTime
% info4.SettlingTime
% info4.Overshoot

% info5.RiseTime
% info5.SettlingTime
% info5.Overshoot

% info6.RiseTime
% info6.SettlingTime
% info6.Overshoot

figure(4)
X = categorical({'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
X = reordercats(X,{'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
Y = [info1.RiseTime,info2.RiseTime,info3.RiseTime,info4.RiseTime,info5.RiseTime,info6.RiseTime];
bar(X,Y,'b');
ylabel('Rise Time (s)');
grid on

figure(5)
X = categorical({'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
X = reordercats(X,{'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
Y = [info1.SettlingTime,info2.SettlingTime,info3.SettlingTime,info4.SettlingTime,info5.SettlingTime,info6.SettlingTime];
bar(X,Y,'b');
ylabel('Settling Time (s)');
grid on
 
figure(6)
X = categorical({'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
X = reordercats(X,{'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
Y = [info1.Overshoot,info2.Overshoot,info3.Overshoot,info4.Overshoot,info5.Overshoot,info6.Overshoot];
bar(X,Y,'b');
ylabel('Overshoot (%)');
grid on

%% Gain Margin , Phase Margin  and BandWidth

% Gain Margin (GM) and Phase Margin (PM):
[Gm1,Pm1,Wcg1,Wcp1] = margin(sys1);
[Gm2,Pm2,Wcg2,Wcp2] = margin(sys2);
[Gm3,Pm3,Wcg3,Wcp3] = margin(sys3);
[Gm4,Pm4,Wcg4,Wcp4] = margin(sys4);
[Gm5,Pm5,Wcg5,Wcp5] = margin(sys5);
[Gm6,Pm6,Wcg6,Wcp6] = margin(sys6);
% BandWidth:
bw1 = bandwidth(sys1);
bw2 = bandwidth(sys2);
bw3 = bandwidth(sys3);
bw4 = bandwidth(sys4);
bw5 = bandwidth(sys5);
bw6 = bandwidth(sys6);

figure(7)
col = {'Gain Margin','Phase Margin','BandWidth'};
row = {'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'};
dat = {num2str(Gm1),num2str(Pm1),num2str(bw1);...
    num2str(Gm2),num2str(Pm2),num2str(bw2);...
    num2str(Gm3),num2str(Pm3),num2str(bw3);...
    num2str(Gm4),num2str(Pm4),num2str(bw4);...
    num2str(Gm5),num2str(Pm5),num2str(bw5);...
    num2str(Gm6),num2str(Pm6),num2str(bw6)
    };
uitable('columnname',col,'rowname',row,'position',[10 120 390 300],'data',dat);

%nyquist(sys1)

%% Performance Index
SP = 1;

[y1,t1] = step(SP*sys1);
Ess1 = abs(SP - y1(end));
Mp1  = info1.Overshoot/100;
Tr1  = info1.RiseTime;
Ts1  = info1.SettlingTime;


[y2,t2] = step(SP*sys2);
Ess2 = abs(SP - y2(end));
Mp2  = info2.Overshoot/100;
Tr2  = info2.RiseTime;
Ts2  = info2.SettlingTime;

[y3,t3] = step(SP*sys3);
Ess3 = abs(SP - y3(end));
Mp3  = info3.Overshoot/100;
Tr3  = info3.RiseTime;
Ts3  = info3.SettlingTime;

[y4,t4] = step(SP*sys4);
Ess4 = abs(SP - y4(end));
Mp4  = info4.Overshoot/100;
Tr4  = info4.RiseTime;
Ts4  = info4.SettlingTime;

[y5,t5] = step(SP*sys5);
Ess5 = abs(SP - y5(end));
Mp5  = info5.Overshoot/100;
Tr5  = info5.RiseTime;
Ts5  = info5.SettlingTime;

[y6,t6] = step(SP*sys6);
Ess6 = abs(SP - y6(end));
Mp6  = info6.Overshoot/100;
Tr6  = info6.RiseTime;
Ts6  = info6.SettlingTime;


W1 = W_index(Mp1,Tr1,Ts1,Ess1);
W2 = W_index(Mp2,Tr2,Ts2,Ess2);
W3 = W_index(Mp3,Tr3,Ts3,Ess3);
W4 = W_index(Mp4,Tr4,Ts4,Ess4);
W5 = W_index(Mp5,Tr5,Ts5,Ess5);
W6 = W_index(Mp6,Tr6,Ts6,Ess6);

figure(8)
X = categorical({'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
X = reordercats(X,{'OBL_HSO','HSO ','ASO','SFS','GWO','SCA'});
Y = [W1,W2,W3,W4,W5,W6];
bar(X,Y,'b');
ylabel('W performance index');
grid on

%% Disturbance
k1 = OBL_HSO;
k2 = HSO;
k3 = ASO;
k4 = SFS;
k5 = GWO;

figure(9)
%Ref
plot(out.w_ref_EO_PID.Time,out.w_ref_EO_PID.Data,'--k');
hold on;
%EO
plot(out.w_out_EO_PID.Time,out.w_out_EO_PID.Data,'m','LineWidth',1.5);
%PSO
plot(out.w_out_PSO_PID.Time,out.w_out_PSO_PID.Data,'c','LineWidth',1.5);
%TLBO
plot(out.w_out_TLBO_PID.Time,out.w_out_TLBO_PID.Data,'m','LineWidth',1.5);
%DE
plot(out.w_out_DE_PID.Time,out.w_out_DE_PID.Data,'g','LineWidth',1.5);
%GA
plot(out.w_out_GA_PID.Time,out.w_out_GA_PID.Data,'y','LineWidth',1.5);

% set(gca, 'YTick',scaleY);   
xlabel('Time (s)');
ylabel('Speed');
legend('Reference','EO-PID','PSO-PID','TLBO-PID','DE-PID','GA-PID');

hold off;

%% Control signal Analysis

% col = {'Energy','Umax'};
% row = {'EO','PSO','TLBO','DE','GA'};
% dat = {num2str(out.u_energy_EO.Data(end)),num2str(max(out.u_signal_EO.Data));...
%        num2str(out.u_energy_PSO.Data(end)),num2str(max(out.u_signal_PSO.Data));...
%        num2str(out.u_energy_TLBO.Data(end)),num2str(max(out.u_signal_TLBO.Data));...
%        num2str(out.u_energy_DE.Data(end)),num2str(max(out.u_signal_DE.Data));...
%        num2str(out.u_energy_GA.Data(end)),num2str(max(out.u_signal_GA.Data))...
%        };
% figure(10)
% uitable('columnname',col,'rowname',row,'position',[10 120 550 300],'data',dat);
