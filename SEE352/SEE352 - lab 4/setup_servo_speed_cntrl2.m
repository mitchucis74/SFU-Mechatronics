%% SETUP_SERVO_SPEED_CNTRL
%
% Sets the necessary parameters to run the Servo Speed Control lab.
% 
clear all;
%
%% Servo Configuration
% External Gear Configuration: set to 'HIGH' or 'LOW'
EXT_GEAR_CONFIG = 'HIGH';
% Type of Load: set to 'NONE', 'DISC', or 'BAR'
LOAD_TYPE = 'DISC';
% Amplifier Gain used: set to 1, 3, or 5
K_AMP = 1;
% Power Amplifier Type: set to 'VoltPAQ', 'UPM_1503', or 'UPM_2405'
AMP_TYPE = 'VoltPaq';
% Is servo equipped with tachometer?: set to 'YES' or 'NO'
TACH_OPTION = 'NO';
%
%% Lab Configuration
% Type of controller: set it to 'AUTO', 'MANUAL'
% CONTROL_TYPE = 'AUTO';
CONTROL_TYPE = 'MANUAL';
%
%% PI Specifications
% Peak time (s)
tp = 0.1; % 0.05;
% Percentage overshoot (%)
PO = 5;
% Steady-state error (rad)
e_ss_des = 0.0;
%
%% Control Specifications of Compensated Open-Loop System
% Desired crossover frequency (rad/s)
% wg_des = 60.0; % 75
% Desired phase margin (deg)
PM_des = 72.5;
%
%% System Parameters
% Load servo system parameters.
[ Rm, kt, km, Kg, eta_g, Beq, Jm, Jeq, eta_m, K_POT, K_ENC, VMAX_AMP, IMAX_AMP ] = config_servo( EXT_GEAR_CONFIG, TACH_OPTION, AMP_TYPE, LOAD_TYPE );
%
%% Calculate Control Gains
if strcmp ( CONTROL_TYPE , 'MANUAL' )
    % Load model parameters based on servo configuration.
    K = 10; % enter correct value
    tau = 0.1; % enter correct value
    % Proportional gain (V/rad)
    kp = 0;
    % Integral gain (V/rad/s)
    ki = 0;
    % Set-point weight
    bsp = 0;
    % Lead Compensator
    a = 1;
    T = 1;
    % Lead proportional gain (V/rad/s)
    Kc = 0;
elseif strcmp ( CONTROL_TYPE , 'AUTO' )
    % Load model parameters based on servo configuration.
    [ K, tau ] = d_model_param(Rm, kt, km, Kg, eta_g, Beq, Jeq, eta_m );
    % Calculate PI control gains given specifications.
    [ kp, ki ] = d_pi_design( K, tau, PO, tp );
    % Set-point weight
    bsp = 0;
    % Lead Compensator
    d_lead;    
end
%
%% Display
disp( ' ' );
disp( 'Servo model parameters: ' );
disp( [ '   K = ' num2str( K, 3 ) ' rad/s/V' ] );
disp( [ '   tau = ' num2str( tau, 3 ) ' s' ] );
disp( 'PI control gains: ' );
disp( [ '   kp = ' num2str( kp, 3 ) ' V/rad' ] );
disp( [ '   ki = ' num2str( ki, 3 ) ' V/rad/s' ] );
disp( 'Lead compensator parameters: ' );
disp( [ '   Kc = ' num2str( Kc, 3 ) ' V/rad/s' ] );
disp( [ '   1/(a*T) = ' num2str( 1/(a*T), 3 ) ' rad/s' ] );
disp( [ '   1/T = ' num2str( 1/T, 3 ) ' rad/s' ] );
% 