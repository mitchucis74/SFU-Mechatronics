%% SETUP_BALL_BEAM
% Sets the necessary parameters to run the Ball and Beam experiment.
%
clear;
%
%% Servo Configuration
% External Gear Configuration: set to 'HIGH' or 'LOW'
EXT_GEAR_CONFIG = 'HIGH';
% Type of Load: set to 'NONE', 'DISC', or 'BAR'
LOAD_TYPE = 'NONE';
% Amplifier gain used. 
% Note: VoltPAQ users: Set K_AMP to 1 and Gain switch on amplifier to 1
K_AMP = 1;
% Amplifier Type
AMP_TYPE = 'VoltPAQ';
% Is servo equipped with tachometer? Set to 'YES' or 'NO'
TACH_OPTION = 'NO';
%
%% Lab Configuration
% Type of controller: set it to 'AUTO', 'MANUAL'
% CONTROL_TYPE = 'AUTO';
CONTROL_TYPE = 'MANUAL';
%
%% Control specifications
% Settling time percentage
c_ts = 0.04;
% Settling time (s)
ts = 3;
% Percentage overshoot (%)
PO = 5.0;
% Ball and beam filter cutoff frequency (rad/s)
wf = 2 * pi * 4.0;
%
%% System Parameters
% Sets model variables according to the user-defined system configuration
[ Rm, kt, km, Kg, eta_g, Beq, Jm, Jeq, eta_m, K_POT, K_ENC, VMAX_AMP, IMAX_AMP ] = config_servo( EXT_GEAR_CONFIG, TACH_OPTION, AMP_TYPE, LOAD_TYPE );
% Load Ball and Beam model parameters.
[ L, r_arm, r_b, m_b, J_b, g, THETA_OFF, THETA_MIN, THETA_MAX, K_BS] = config_bb( );
%
%% Calculate Control Parameters
if strcmp ( CONTROL_TYPE , 'MANUAL' )
    % Load model parameters based on servo configuration.    
    K = 1.53; % enter correct value
    tau = 0.034; % enter correct value
    % Rotary servo position control proportional gain (V/rad)
    kp = 0.4989;
    % Calculate Ball and Beam model gain.
    K_bb = 0.418;
    % Design Ball and Beam compensator
    z = 1.4;
    Kc = 5.3;
    %
elseif strcmp ( CONTROL_TYPE , 'AUTO' )
    % Load nominal model parameters 
    [K,tau] = d_model_param(Rm, kt, km, Kg, eta_g, Beq, Jeq, eta_m);
    % Rotary servo position control proportional gain (V/rad)
    kp = 12;
    % Calculate Ball and Beam model gain.
    [ K_bb ] = d_bb_model_param(r_arm, L);
    % Design Ball and Beam compensator
    [ Kc, z ] = d_bb_pd(K_bb, PO, ts, c_ts);
end
%
%% Display
disp( ' ' );
%
disp( 'Ball and Beam model parameter: ' );
disp( [ '   K_bb = ' num2str( K_bb, 3 ) ' m/s^2/rad' ] );
%
disp( 'Ball and Beam Control Specifications: ' );
disp( [ '   ts = ' num2str( ts, 3 ) ' s' ] );
disp( [ '   PO = ' num2str( PO, 3 ) ' %' ] );
%
disp( 'Ball and Beam control: ' );
disp( [ '   Kc = ' num2str( Kc, 3 ) ' s/m' ] );
disp( [ '   z = ' num2str( z, 3 ) ' rad/s' ] );
disp( [ '   wf = ' num2str( wf, 3 ) ' rad/s' ] );
%