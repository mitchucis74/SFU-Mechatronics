% Base values 
Pb=1.9e6;% real power from dc unit
Vb=690/sqrt(3);
Fb=60;
Ib=Pb/(Vb);
Zb=Vb/Ib;
Omega_b=2*pi*Fb;
Lb=Zb/Omega_b;
Cb=1/(Omega_b*Zb);

% grid-side filter inductor
Lgrid_pu=0.2;
Lgrid=Lgrid_pu*Lb;
Rgrid_pu=0.005;
Rgrid=Rgrid_pu*Zb;
Power_loss=Rgrid_pu*Pb;

%dc link
Cdc=4*Cb;
Vdc_ref = sqrt(6)*(1/0.8);
Vdc_capacitor_initial = Vdc_ref*Vb; %

% DC supply
Rdc_series=0.1*Zb; % might be changed here
Idc=(Pb + Power_loss)/(Vdc_ref*Vb);
Vdc_supply=Vdc_ref*Vb + Idc*Rdc_series;
 
 
%switching frequency
Fs=2040;% 34 times fundamental frequency
% sampling frqquency for controller
Fsampling=10e3;% at least 2 times Fs recommended