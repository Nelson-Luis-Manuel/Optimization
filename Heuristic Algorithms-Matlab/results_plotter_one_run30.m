
clc;
clear;
% clear all;
%% Optimal K's
kEO      = round([20,5.34425347035111,3.54097038154907],10);
kPSO     = round([20,5.34377921779517,3.54077893762727],10);
%kTLBO   = round([19.9999999999978,5.34425358436046,3.54097040611925],10);
kSanTLBO = round([20,5.34425348943154,3.54097039962968],10);
kDE      = round([20,5.34011936022638,3.54024626188532],10);
kGA      = round([19.9999999998496,5.33535872088901,3.54012059480040,0.000416037765047858],10);

figure(11)
col = {'Kp','Ki','Kd'};
row = {'EO','PSO','TLBO','DE','GA'};
dat = {num2str(kEO(1)),num2str(kEO(2)),num2str(kEO(3));...
       num2str(kPSO(1)),num2str(kPSO(2)),num2str(kPSO(3));...
       num2str(kSanTLBO(1)),num2str(kSanTLBO(2)),num2str(kSanTLBO(3));...
       num2str(kDE(1)),num2str(kDE(2)),num2str(kDE(3));...
       num2str(kGA(1)),num2str(kGA(2)),num2str(kGA(3))...
       };
uitable('columnname',col,'rowname',row,'position',[10 120 390 300],'data',dat);


%% EO-PID
Kp_1 = kEO(1); Ki_1 = kEO(2); Kd_1 = kEO(3);
sys1 = tf([15*Kd_1,15*Kp_1,15*Ki_1],[1.08,(6.1+15*Kd_1),(1.63+15*Kp_1),(15*Ki_1)]);

%% PSO-PID
Kp_2 = kPSO(1); Ki_2 = kPSO(2); Kd_2 = kPSO(3);
sys2 = tf([15*Kd_2,15*Kp_2,15*Ki_2],[1.08,(6.1+15*Kd_2),(1.63+15*Kp_2),(15*Ki_2)]);

%% TLBO-PID
Kp_3 = kSanTLBO(1); Ki_3 = kSanTLBO(2); Kd_3 = kSanTLBO(3);
sys3 = tf([15*Kd_3,15*Kp_3,15*Ki_3],[1.08,(6.1+15*Kd_3),(1.63+15*Kp_3),(15*Ki_3)]);

%% DE-PID
Kp_4 = kDE(1); Ki_4 = kDE(2); Kd_4 = kDE(3);
sys4 = tf([15*Kd_4,15*Kp_4,15*Ki_4],[1.08,(6.1+15*Kd_4),(1.63+15*Kp_4),(15*Ki_4)]);

%% GA-PID
Kp_5 = kGA(1); Ki_5 = kGA(2); Kd_5 = kGA(3);
sys5 = tf([15*Kd_5,15*Kp_5,15*Ki_5],[1.08,(6.1+15*Kd_5),(1.63+15*Kp_5),(15*Ki_5)]);

%% Bode Plots
figure(1)
bode(sys1,'r',sys2,'b',sys3,'y',sys4,'m',sys5,'c');
grid on;
legend('EO','PSO','TLBO','DE','GA');
%% Step Response
figure(2)
step(sys1,'g',sys2,'b',sys3,':m',sys4,'--y',sys5,'r',1.2);
ylabel('Speed')
legend('EO','PSO','TLBO','DE','GA');
set(findall(gcf,'type','line'),'linewidth',1.25);

%% RiseTime, Settling Time and OverShoot
info1 = stepinfo(sys1);
info2 = stepinfo(sys2);
info3 = stepinfo(sys3);
info4 = stepinfo(sys4);
info5 = stepinfo(sys5);

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

figure(3)
X = categorical({'EO','PSO','TLBO','DE','GA'});
X = reordercats(X,{'EO','PSO','TLBO','DE','GA'});
Y = [info1.RiseTime,info2.RiseTime,info3.RiseTime,info4.RiseTime,info5.RiseTime];
bar(X,Y,'b');
ylabel('Rise Time (s)');
grid on

figure(4)
X = categorical({'EO','PSO','TLBO','DE','GA'});
X = reordercats(X,{'EO','PSO','TLBO','DE','GA'});
Y = [info1.SettlingTime,info2.SettlingTime,info3.SettlingTime,info4.SettlingTime,info5.SettlingTime];
bar(X,Y,'b');
ylabel('Settling Time (s)');
grid on
 
figure(5)
X = categorical({'EO','PSO','TLBO','DE','GA'});
X = reordercats(X,{'EO','PSO','TLBO','DE','GA'});
Y = [info1.Overshoot,info2.Overshoot,info3.Overshoot,info4.Overshoot,info5.Overshoot];
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

% BandWidth:
bw1 = bandwidth(sys1);
bw2 = bandwidth(sys2);
bw3 = bandwidth(sys3);
bw4 = bandwidth(sys4);
bw5 = bandwidth(sys5);
figure(9)
col = {'Gain Margin','Phase Margin','BandWidth'};
row = {'EO','PSO','TLBO','DE','GA'};
dat = {num2str(Gm1),num2str(Pm1),num2str(bw1);num2str(Gm2),num2str(Pm2),num2str(bw2);num2str(Gm3),num2str(Pm3),num2str(bw3);num2str(Gm4),num2str(Pm4),num2str(bw4);num2str(Gm5),num2str(Pm5),num2str(bw5)};
uitable('columnname',col,'rowname',row,'position',[10 120 390 300],'data',dat);

%nyquist(sys1)
%% Optimal K's
% kEO   = [20,5.34425347035111,3.54097038154907];
% kPSO  = [20,5.34377921779517,3.54077893762727];
% kTLBO = [19.9999999999978,5.34425358436046,3.54097040611925];
% kDE   = [20,5.34011936022638,3.54024626188532];
% kGA   = [19.2099139145948,5.11611169559863,3.39637749773014];
% kSanTLBO = [20,5.34425348943154,3.54097039962968];

%% ITAE per 30 Runs
numRun   = 1:1:30;
figure(6)
EO_run      = round([0.000413498082259106,0.000413157397665200,0.000413208004392857,0.000413152025087792,0.000413178469599503,0.000413286646764438,0.000413154677821772,0.000413213751979472,0.000421695969363291,0.000413155168949435,0.000413185595643891,0.000413169356791267,0.000413153220294573,0.000414020070752761,0.000413151142438239,0.000414183642745895,0.000413151218423307,0.000413178772186513,0.000413160576673015,0.000413151119863526,0.000413168335596746,0.000413151146059300,0.000414196345453575,0.000413170918241221,0.000413206551079038,0.000413163687216987,0.000414478480840879,0.000413153793608078,0.000413153970868241,0.000419826422755555],10);
PSO_run     = round([0.000413470476215757;0.000413365111261940;0.000413433445279390;0.000413909509981132;0.000413951282975371;0.000413284939368944;0.000413230518244076;0.000413695091221565;0.000413396853830541;0.000414086365835256;0.000413164470171159;0.000414296681163592;0.000413946942323456;0.000413624383572889;0.000413245364087802;0.000413216148655294;0.000413394737755176;0.000413330409217119;0.000413335330161847;0.000413478958373956;0.000413251232861046;0.000413400544469716;0.000413361253071235;0.000413167284793522;0.000413154132844809;0.000413184572220652;0.000413165968517833;0.000413390492516795;0.000413176770643567;0.000413236993359889]',10);
%TLBO_run   = round([0.000413151166200377,0.000413151119911861,0.000413151119859344,0.000413151119835103,0.000413151182429147,0.000413151119830878,0.000413151120064580,0.000413151119910292,0.000413151120288509,0.000413151120147829,0.000413151119828219,0.000413151169902054,0.000413151127882297,0.000413151119877506,0.000413151120365125,0.000413151125539959,0.000413151210807006,0.000413151120429780,0.000413151119867918,0.000413151119833333,0.000413151120392037,0.000413151121768733,0.000413151222713536,0.000413151122771493,0.000413151122063321,0.000413151138475338,0.000413151119951889,0.000413151122156287,0.000413151120224787,0.000413151478714808],10);
sanTLBO_run = round([0.000413151879777608;0.000413151147892798;0.000413151120595976;0.000413151120707369;0.000413151121718238;0.000413151122304684;0.000413151204829385;0.000413151123633383;0.000413153544671798;0.000413151120142850;0.000413151121930555;0.000413151136331433;0.000413151344122098;0.000413151285497814;0.000413151119948193;0.000413151125312027;0.000413151146990576;0.000413151123160771;0.000413151119858262;0.000413151248754540;0.000413151308081902;0.000413151159417200;0.000413151199907349;0.000413151221570403;0.000413151122330758;0.000413151120006038;0.000413151151278401;0.000413151153623602;0.000413151119882853;0.000413151124798450]',10);
DE_run      = round([0.000417443576141534,0.000437161671338831,0.000415031700891045,0.000423928262025217,0.000461357369978070,0.000499525481267376,0.000414905283018385,0.000426725715990062,0.000434697913715152,0.000416642147704064,0.000418351894074094,0.000421254250318025,0.000414273710798665,0.000419258325058089,0.000419497960764602,0.000426101276874221,0.000419203548376859,0.000445778642739762,0.000419496580911057,0.000457140671187390,0.000415003209293874,0.000496119993393951,0.000418826047432643,0.000415684023743109,0.000424485473185246,0.000417546064612187,0.000428558542069510,0.000418801719352826,0.000417369868234742,0.000420464075241121],10);
%GA_run     = round([0.00221385960009131;0.00108981359976501;0.000689712146430146;0.000453072172469036;0.00255434464475871;0.000811051298467164;0.00142755177518124;0.000555748198892259;0.000477364084597943;0.00217060867232037;0.000659945779916665;0.000538139274461591;0.00162681788725084;0.000462799714759274;0.000612907262749904;0.00124131056073735;0.000545476156140047;0.000595395692215302;0.00101583327441429;0.000540100774961669;0.000690345359176114;0.00103392015386548;0.000650873775439393;0.000489256197584184;0.00145773854041333;0.000895189764597751;0.00123230255818695;0.00175889544652085;0.00141007743003253;0.000691515983523592]',10);
GA_run      = round([0.00129595802141300;0.000702930984483735;0.000685628284655533;0.000429961382216842;0.000466174043452369;0.000423128386102034;0.000424550425176494;0.00208780836628793;0.000440511473858966;0.000416441699779364;0.000463765092949889;0.000597295407139997;0.000589798180910272;0.000442002640440842;0.000612575633633417;0.00191087587756652;0.00110667047232841;0.000433825083497217;0.000562980055505687;0.000420283595473995;0.000416037765047858;0.00216034456462796;0.000551792806440352;0.000507125446920059;0.000418988665548078;0.000417506838692454;0.000444669655775265;0.000548048732354917;0.000499644324924722;0.000465368434496445]',10);

plot(numRun,EO_run,'b','LineWidth',1.5);
hold on
plot(numRun,PSO_run,'g','LineWidth',1.5);
plot(numRun,sanTLBO_run,'m-o','LineWidth',1.5);
plot(numRun,DE_run,'r-o','LineWidth',1.5);
plot(numRun,GA_run,'y-o','LineWidth',1.5);


legend('EO','PSO','TLBO','DE','GA');
xlim([1 30]);
% set(gca, 'XTick',numRun); 
xlabel('Number of runs');
ylabel('ITAE');
hold off


%% Statistical KPI's

col = {'EO','PSO','TLBO','DE','GA'};
row = {'Maximum','Minimum','Mean','Median','Standard deviation'};
dat = {num2str(max(EO_run)),num2str(max(PSO_run)),num2str(max(sanTLBO_run)),num2str(max(DE_run)),num2str(max(GA_run));...
       num2str(min(EO_run)),num2str(min(PSO_run)),num2str(min(sanTLBO_run)),num2str(min(DE_run)),num2str(min(GA_run));...
       num2str(mean(EO_run)),num2str(mean(PSO_run)),num2str(mean(sanTLBO_run)),num2str(mean(DE_run)),num2str(mean(GA_run));...
       num2str(median(EO_run)),num2str(median(PSO_run)),num2str(median(sanTLBO_run)),num2str(median(DE_run)),num2str(median(GA_run));...
       num2str(std(EO_run)),num2str(std(PSO_run)),num2str(std(sanTLBO_run)),num2str(std(DE_run)),num2str(std(GA_run))...
       };

figure(10);
uitable('columnname',col,'rowname',row,'position',[10 120 550 300],'data',dat);


%% ITAE per 50 Iterations
numIter   = 1:1:50;
figure(7)

EO_iter      = round([0.00155425671389397;0.00146695322761872;0.00136446494692567;0.00114995000072012;0.00114995000072012;0.00105193180150900;0.00105193180150900;0.00102520093160941;0.000662512763389312;0.000604110261798020;0.000578294679177532;0.000578294679177532;0.000541049927991337;0.000541049927991337;0.000541049927991337;0.000477147181591170;0.000477147181591170;0.000477147181591170;0.000452575612639098;0.000442603317538131;0.000428517703917287;0.000423382228806929;0.000417965199956857;0.000417965199956857;0.000417965199956857;0.000417965199956857;0.000417656869837697;0.000415681347278822;0.000415681347278822;0.000414677304705154;0.000413600319341708;0.000413600319341708;0.000413199918630741;0.000413199918630741;0.000413199918630741;0.000413186747753890;0.000413186747753890;0.000413179783030476;0.000413174764657685;0.000413158406337576;0.000413155192364310;0.000413152855312025;0.000413151468537066;0.000413151468537066;0.000413151158399612;0.000413151121395165;0.000413151120608397;0.000413151119922120;0.000413151119863526;0.000413151119863526]',10);
PSO_iter     = round([0.000894482382878693;0.000582476324080495;0.000582476324080495;0.000561205592011040;0.000501644964192623;0.000501644964192623;0.000501644964192623;0.000501644964192623;0.000501644964192623;0.000486376751399935;0.000472169940660704;0.000472169940660704;0.000453607394205484;0.000423303358257763;0.000423303358257763;0.000423303358257763;0.000423303358257763;0.000423303358257763;0.000423303358257763;0.000423303358257763;0.000420670692904255;0.000420670692904255;0.000420670692904255;0.000420670692904255;0.000416268201207131;0.000415810613708656;0.000415026650471775;0.000415026650471775;0.000415026650471775;0.000415026650471775;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000414456620409320;0.000413574940800546;0.000413574940800546;0.000413533612396898;0.000413272716658195;0.000413231270756827;0.000413231270756827;0.000413231270756827;0.000413182523381891;0.000413154132844809;0.000413154132844809;0.000413154132844809;0.000413154132844809]',10);
%TLBO_iter   = round([0.00295072396789812;0.00215455672171926;0.00119973436105146;0.00100432329738946;0.000595292220108241;0.000544506637502182;0.000544506637502182;0.000544506637502182;0.000504572897079478;0.000464345618937892;0.000464345618937892;0.000456157558909070;0.000448363235834957;0.000442353534296820;0.000429341385743269;0.000422336238421656;0.000415175921254950;0.000415175921254950;0.000415175921254950;0.000414737104462335;0.000414737104462335;0.000414238710034361;0.000413515055727381;0.000413515055727381;0.000413452783873017;0.000413452783873017;0.000413452783873017;0.000413452783873017;0.000413238042381796;0.000413238042381796;0.000413225158711595;0.000413225158711595;0.000413179134921208;0.000413153776201037;0.000413153776201037;0.000413153776201037;0.000413153776201037;0.000413153106666140;0.000413152121405380;0.000413152121405380;0.000413152121405380;0.000413151794079463;0.000413151794079463;0.000413151794079463;0.000413151432898457;0.000413151288653462;0.000413151288653462;0.000413151288653462;0.000413151169902054;0.000413151169902054]',10);
sanTLBO_iter = round([0.00145015004412940;0.00119400401627810;0.00119400401627810;0.000919327043180744;0.000919327043180744;0.000800088626267298;0.000550681830937206;0.000550681830937206;0.000476417143357991;0.000451451941401401;0.000430256528376624;0.000430256528376624;0.000421078249828481;0.000421078249828481;0.000421078249828481;0.000420428964964417;0.000413705591614443;0.000413705591614443;0.000413705591614443;0.000413705591614443;0.000413705591614443;0.000413705591614443;0.000413705591614443;0.000413337459227679;0.000413337459227679;0.000413337459227679;0.000413227531402680;0.000413227531402680;0.000413212711332313;0.000413189219164438;0.000413177729982421;0.000413157565975213;0.000413153910720723;0.000413153385978369;0.000413153082078848;0.000413153082078848;0.000413152157598042;0.000413151401304079;0.000413151158276261;0.000413151126909738;0.000413151126909738;0.000413151126909738;0.000413151126909738;0.000413151126909738;0.000413151121881285;0.000413151120359373;0.000413151120359373;0.000413151119858262;0.000413151119858262;0.000413151119858262]',10);
DE_iter      = round([0.00159430239821800;0.00142536550674753;0.00142536550674753;0.00142536550674753;0.000647293856959860;0.000647293856959860;0.000647293856959860;0.000638918520289799;0.000472463583483572;0.000447387609207326;0.000447387609207326;0.000447387609207326;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000429320568589987;0.000415248459621312;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414769212236763;0.000414273710798665;0.000414273710798665;0.000414273710798665]',10);
%GA_iter     = round([0.000572523320651411;0.000572523320651411;0.000487755733764198;0.000486106318799765;0.000485633454519009;0.000457002261253531;0.000456695792129450;0.000456695792129450;0.000455694380291952;0.000455454760342534;0.000455454760342534;0.000455452569907263;0.000455446344515676;0.000455446344515676;0.000455446331559013;0.000455446297556394;0.000455446297556394;0.000455446297523638;0.000455446297175516;0.000453182443531003;0.000453182443531003;0.000453182443531003;0.000453105782270193;0.000453105782270193;0.000453072977699205;0.000453072977699205;0.000453072348317777;0.000453072180666053;0.000453072178011251;0.000453072175533303;0.000453072173001243;0.000453072172645441;0.000453072172616108;0.000453072172474854;0.000453072172474854;0.000453072172469959;0.000453072172469127;0.000453072172469127;0.000453072172469057;0.000453072172469057;0.000453072172469045;0.000453072172469045;0.000453072172469043;0.000453072172469038;0.000453072172469038;0.000453072172469038;0.000453072172469038;0.000453072172469038;0.000453072172469038;0.000453072172469036]',10);
GA_iter      = round([0.000940002784971389;0.000939806480097407;0.000905096380487744;0.000789139159870820;0.000787587841575022;0.000685811532511790;0.000606481052835914;0.000606481052835914;0.000501785551130956;0.000470645874295139;0.000469950051519462;0.000427278074162530;0.000427278074162530;0.000427278074162530;0.000427218205051350;0.000426613557364544;0.000426611647113599;0.000426611240423036;0.000426608590052396;0.000426608075790359;0.000426598366233115;0.000426598336067251;0.000426598194580248;0.000426598194580248;0.000426598068535465;0.000416083672090883;0.000416083672090883;0.000416083672090883;0.000416052082111282;0.000416040126528128;0.000416039135119964;0.000416038450270361;0.000416038450270361;0.000416037778478502;0.000416037777155232;0.000416037777138168;0.000416037775498771;0.000416037765211742;0.000416037765207851;0.000416037765200070;0.000416037765200070;0.000416037765048867;0.000416037765048867;0.000416037765048560;0.000416037765047890;0.000416037765047864;0.000416037765047864;0.000416037765047861;0.000416037765047858;0.000416037765047858]',10);

plot(numIter,EO_iter,'--b','LineWidth',1.25);
hold on
plot(numIter,PSO_iter,'--g','LineWidth',1.25);
plot(numIter,sanTLBO_iter,'--m','LineWidth',1.25);
plot(numIter,DE_iter,'--y','LineWidth',1.25);
plot(numIter,GA_iter,'--r','LineWidth',1.25);

legend('EO','PSO','TLBO','DE','GA');
xlim([1 50]);
% set(gca, 'XTick',numIter); 
xlabel('Iteration');
ylabel('ITAE');
hold off


%% Run using bar graph
figure(8)
barData = round([0.000413498082259106,0.000413470476215757,0.000413151879777608,0.000417443576141534,0.00221385960009131;0.000413157397665200,0.000413365111261940,0.000413151147892798,0.000437161671338831,0.00108981359976501;0.000413208004392857,0.000413433445279390,0.000413151120595976,0.000415031700891045,0.000689712146430146;0.000413152025087792,0.000413909509981132,0.000413151120707369,0.000423928262025217,0.000453072172469036;0.000413178469599503,0.000413951282975371,0.000413151121718238,0.000461357369978070,0.00255434464475871;0.000413286646764438,0.000413284939368944,0.000413151122304684,0.000499525481267376,0.000811051298467164;0.000413154677821772,0.000413230518244076,0.000413151204829385,0.000414905283018385,0.00142755177518124;0.000413213751979472,0.000413695091221565,0.000413151123633383,0.000426725715990062,0.000555748198892259;0.000421695969363291,0.000413396853830541,0.000413153544671798,0.000434697913715152,0.000477364084597943;0.000413155168949435,0.000414086365835256,0.000413151120142850,0.000416642147704064,0.00217060867232037;0.000413185595643891,0.000413164470171159,0.000413151121930555,0.000418351894074094,0.000659945779916665;0.000413169356791267,0.000414296681163592,0.000413151136331433,0.000421254250318025,0.000538139274461591;0.000413153220294573,0.000413946942323456,0.000413151344122098,0.000414273710798665,0.00162681788725084;0.000414020070752761,0.000413624383572889,0.000413151285497814,0.000419258325058089,0.000462799714759274;0.000413151142438239,0.000413245364087802,0.000413151119948193,0.000419497960764602,0.000612907262749904;0.000414183642745895,0.000413216148655294,0.000413151125312027,0.000426101276874221,0.00124131056073735;0.000413151218423307,0.000413394737755176,0.000413151146990576,0.000419203548376859,0.000545476156140047;0.000413178772186513,0.000413330409217119,0.000413151123160771,0.000445778642739762,0.000595395692215302;0.000413160576673015,0.000413335330161847,0.000413151119858262,0.000419496580911057,0.00101583327441429;0.000413151119863526,0.000413478958373956,0.000413151248754540,0.000457140671187390,0.000540100774961669;0.000413168335596746,0.000413251232861046,0.000413151308081902,0.000415003209293874,0.000690345359176114;0.000413151146059300,0.000413400544469716,0.000413151159417200,0.000496119993393951,0.00103392015386548;0.000414196345453575,0.000413361253071235,0.000413151199907349,0.000418826047432643,0.000650873775439393;0.000413170918241221,0.000413167284793522,0.000413151221570403,0.000415684023743109,0.000489256197584184;0.000413206551079038,0.000413154132844809,0.000413151122330758,0.000424485473185246,0.00145773854041333;0.000413163687216987,0.000413184572220652,0.000413151120006038,0.000417546064612187,0.000895189764597751;0.000414478480840879,0.000413165968517833,0.000413151151278401,0.000428558542069510,0.00123230255818695;0.000413153793608078,0.000413390492516795,0.000413151153623602,0.000418801719352826,0.00175889544652085;0.000413153970868241,0.000413176770643567,0.000413151119882853,0.000417369868234742,0.00141007743003253;0.000419826422755555,0.000413236993359889,0.000413151124798450,0.000420464075241121,0.000691515983523592],10);

barData(:,1) = EO_run';
barData(:,2) = PSO_run';
barData(:,3) = sanTLBO_run';
barData(:,4) = DE_run';
barData(:,5) = GA_run';

bar(barData);
legend('EO','PSO','TLBO','DE','GA');
set(gca, 'XTick',numRun); 
xlabel('Number of runs');
ylabel('ITAE');

%% Run using boxplot
boxData(:,1) = EO_run';
boxData(:,2) = PSO_run';
boxData(:,3) = sanTLBO_run';
boxData(:,4) = DE_run';
boxData(:,5) = GA_run';

boxplot(boxData,'labels',{'EO','PSO','TLBO','DE','GA'});
set(gca, 'XTick',numRun); 
ylabel('ITAE');
% legend('EO','PSO','TLBO','DE','GA');


