% 
%% SAMPLE_MEAS_TP_OS_SPD
% Plots the speed and input voltage response found in the data_spd and
% data_vm variables. This script also finds the peak time and percentage
% overshoot of the response.
%
%% Load sample data from MAT files
% Comment these lines out if you want to use the data recently stored in
% the data_pos and data_vm variables from after running s_srv02_spd.mdl or
% q_srv02_spd.mdl.
% load('data_pi_spd_rsp_wl.mat');
% load('data_pi_spd_rsp_vm.mat');
%
%% Setup variables
% Load from variables set in workspace after running a Simulink model or
% from the previously saved response saved in the MAT files above.
t = data_spd(:,1);
yd = data_spd(:,2);
y = data_spd(:,3);
u = data_vm(:,2);
%
%% Plot response
figure(6);
subplot(2,1,1);
plot(t,yd,'b:',t,y,'r-');
ylabel('\omega_l (rad/s)');
subplot(2,1,2);
plot(t,u,'r-');
ylabel('V_m (V)');
xlabel('time (s)');
%
%% Measured Peak Time and Overshoot
% Note: measurements obtained using the "ginput" Matlab command.
% Init index
i = 1;
% Number of elements in data
N = length(yd);
% Variable indicating when to stop while loop
stop_loop = 0;
% Setpoint peak (rad)
yd_p = max(yd);
%
while (i < N) && (stop_loop < 2)
    yd_last = yd(i);
    y_last = y(i);
    i = i + 1;
    % Reference step start time (s)
    if ( yd(i) > yd_last ) && (stop_loop == 0)        
        t0 = t(i);
        stop_loop = 1;
    end
    % Peak value and time (rad, s)
     if (y(i) > yd_p ) && ( y(i) <= y_last ) && (stop_loop == 1)
         t1 = t(i);
         yp = y_last;
         stop_loop = 2;
     end
end
% Peak time (s)
tp_m = t1 - t0; 
% Amplitude of setpoint (rad)
yd_amp = max(yd) - min(yd);
% Percentage overshoot (%)
PO_m = 100 * (yp - yd_p) / yd_amp;
%% Measured steady-state error
% Time where to measure error (s)
t = 1;
% Sample time used in Simulink model
Ts = qc_get_step_size;
% Index to measure error
i = t/Ts;
% Measured steady-state error (rad)
e_ss_m = yd(i) - y(i);
%
%% Display Results
disp(' ');
disp( 'Measured peak time, percentage overshoot, and steady-state error: ' )
disp( [ '     tp = ' num2str( tp_m, 2 ) ' s' ] )
disp( [ '     PO = ' num2str( PO_m, 2 ) ' %' ] )
disp( [ '   e_ss = ' num2str( e_ss_m, 2 ) ' rad' ] )