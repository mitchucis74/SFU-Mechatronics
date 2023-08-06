clear all;
% % % SOLAR PARAMETERS 
Sb_solar = 10000; % - 10KVa apparent power 
Vb = 208/sqrt(3); % - LL voltage=208V
Fb = 60; % - Grid Frequency
Ib_solar = Sb_solar/(3*Vb);
Zb_solar = Vb/(Ib_solar);
Omega_b = 2*pi*Fb;
Lb_solar = Zb_solar/Omega_b;
Cb_solar = 1/(Omega_b*Zb_solar);

% grid-side filter inductor
Lgrid_pu=0.2; % - grid filter B
Lgrid=Lgrid_pu*Lb_solar;
Rgrid_pu=0.005; % - grid filter R
Rgrid=Rgrid_pu*Zb_solar;

% dc-link parameters
Vdc_ref = sqrt(6)*(1/1); % SVM  - Assume: Grid-side Phase voltage=1pu & ma=1 
Vdc_capacitor_initial = Vdc_ref*Vb; 

% switching frequency
Fs_inv = 2000;  % Inverter switching frequency
Fsampling = 10e3;

% Boost converter
Cpv = 0.05*Cb_solar; % - input C
Lboost = 0.5*Lb_solar; % - input B
Fs_boost = 10000; % - Boost switch frequency
Cdc = 3*Cb_solar; %output C 

