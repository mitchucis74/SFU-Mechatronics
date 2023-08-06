clear all
%--------------------------------------------------------------------------------------------
% WIND PARAMETERS
% Per unit system base values
Sb_wind = 1.5e6;
Vb = 690/sqrt(3);
Fb = 60;
Ib_wind = Sb_wind/(3*Vb);
Zb_wind = Vb/Ib_wind;
Omega_b = 2*pi*Fb;
Lb_wind = Zb_wind/Omega_b;
Cb_wind = 1/(Omega_b*Zb_wind);

% Rated wind speed
Wind_speed_b = 12;

% Generator Parameters
Omega_gen_b = 2*pi*53.33; % rated stator frequency
Ppairs = 16;
Tb = Ppairs*Sb_wind/Omega_gen_b; % rated mechanical torque Tm*omega_m = Pm ??
Ld = 0.5*Lb_wind;
Lq = 0.5*Lb_wind;
Rs = 0.01*Zb_wind;
H = 4; %inertia constant
J = 2*H*Sb_wind/(Omega_gen_b^2);

% dc-link parameters
Cdc_wind = 3;
Vdc_ref_wind = 1422; %SVM - (1/2)(w^2)
Vdc_capacitor_initial_wind = Vdc_ref_wind*Vb;

% generator side parameters
Cin = 0.12*Cb_wind;
Lboost_wind = 0.5*Lb_wind;
Fs_boost_wind = ;

% grid side parameters
Lgrid_pu_wind = ;
Lgrid_wind = 0.2*Lb_wind;
Rgrid_pu = ;
Rgrid_wind = Rgrid_pu*Zb_wind;

% Inverter switching frequency
Fs_inv_wind = 3000;
Fsampling = 10e3;

