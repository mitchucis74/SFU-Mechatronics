clear all;
% % % SOLAR PARAMETERS 
Sb_solar = ; 
Vb = 208/sqrt(3); 
Fb = 60;
Ib_solar = Sb_solar/(3*Vb);
Zb_solar = Vb/(Ib_solar);
Omega_b = 2*pi*Fb;
Lb_solar = Zb_solar/Omega_b;
Cb_solar = 1/(Omega_b*Zb_solar);

% grid-side filter inductor
Lgrid_pu=;
Lgrid=Lgrid_pu*Lb_solar;
Rgrid_pu=;
Rgrid=Rgrid_pu*Zb_solar;

% dc-link parameters
Vdc_ref = ; % SVM
Vdc_capacitor_initial = Vdc_ref*Vb; %

% switching frequency
Fs_inv = 2000;  % Inverter switching frequency
Fsampling = 10e3;

% Boost converter
Cpv = 0.05*Cb_solar;
Lboost = 0.5*Lb_solar;
Fs_boost = ;
Cdc = ; 

