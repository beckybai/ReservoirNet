function timeset = SetTime()

dt = 0.005;                     
t1 = 0.5;               % upon time of stimulus 1
sdur = 0.5;             % duration of two stimuli
ndelay = 3;             % delay between two stimuli
ddur = 0.7;               % duration of decision
tau = 0.50;
%tau2 = 0.50;


n_t1 = ceil(t1/dt);               
n_sdur = ceil(sdur/dt);           
n_t2 = n_t1 + ceil(ndelay/dt) + n_sdur;     
n_td = n_t2;
n_ddur = ceil(ddur/dt); 

nsecs = t1+ndelay+sdur+ddur;
%0.5+3+0.5+1 = 5;
simutime = dt:dt:nsecs;

timeset.dt = dt;

timeset.tau = tau;
%timeset.tau2 = tau2;
%timeset.tau = tau;
%0.5
timeset.t1 = n_t1;
%0.5s
timeset.sdur = n_sdur;
%0.5s
timeset.t2 = n_t2;
%4s
timeset.td = n_td;
%4s
timeset.ddur = n_ddur;
%1s
timeset.simuTime = simutime;
