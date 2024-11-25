function graphofvoltage_K(G_K_max)

%This function takes an input and sets the variable G_K_max equal to the
%inputted integer. It iterates through a for loop to solve the differential
%equation for voltage. Then, it graphs the results. 

%Parameters
    %Conductances. 30,12000,2000,4770 
    G_leak= 30; %ns 
    G_Na_max= 12000; %uS
    %G_K_max= 2000; %uS
    G_A_max= 4770; %uS
    %Reversal potentials
    E_Na= 55; %mV
    E_K= -72; %mV
    E_A= -75; %mV
    E_leak= -17; %mV
    %Membrane capacitance
    C= 100; %pF

%Initializing time vector 
dt= 0.01; %ms
time= 0:dt:150;

%Initializing membrane voltage vector
Vm = zeros(size(time));
Vm(1)= E_leak;

%Allocating vectors for gating variables
m = zeros(size(time));
n = zeros(size(time));
h = zeros(size(time));
a = zeros(size(time));
b = zeros(size(time));

%Applied current vector + assignment (I picked 100 pA)
I_app = zeros(size(time));
I_app(time > 0) = 100;

%for loop to stimulate neuron
for i = 1:length(time)-1

    %voltage dependent gating variables
    alpha_m = (0.38 .* (Vm(i)+29.7)) ./ (1 - exp(-0.1 .* (Vm(i) + 29.7)));
    beta_m = 15.2 * exp(-0.0556 .* (Vm(i) + 54.7));

    alpha_h = 0.266 .* exp(-0.05 .* (Vm(i) + 48)); 
    beta_h = 3.8 ./ (1 + exp(-0.1 .* (Vm(i) + 18)));
         
    alpha_n = (0.02 .* (Vm(i)+45.7)) ./ (1 - exp(-0.1 .* (Vm(i) + 45.7)));
    beta_n = 0.25 * exp(-0.0125 .* (Vm(i) + 55.7));

    a_infinity = ((0.0761 .* exp(0.0314 .* (Vm(i) + 94.22))) ./ (1 + exp(0.0346 .* (Vm(i) + 1.17)))^(1/3));
    tau_a = 0.3632 + (1.158 ./ (1 + exp(0.0497 .* (Vm(i) + 55.96))));

    b_infinity = (1 ./ (1 + exp(0.0688 .* (Vm(i) + 53.3))))^4;
    tau_b = (1.24) + (2.678 ./ (1 + exp(0.0624 .* (Vm(i) + 50))));

    %steady state gating variables (for initialization purposes)
    m_inf = alpha_m ./ (alpha_m + beta_m);
    h_inf = alpha_h ./ (alpha_h + beta_h);
    n_inf = alpha_n ./ (alpha_n + beta_n);
    a_inf = a_infinity;
    b_inf = b_infinity;

        if i==1
            m(1) = m_inf;
            n(1) = n_inf;
            h(1) = h_inf;
            a(1) = a_inf;
            b(1) = b_inf;
        end

    %Differential equations 
    dm = (alpha_m * (1 - m(i)) - beta_m * m(i))*dt;
    m(i+1) = m(i) + dm;

    dn = (alpha_n * (1 - n(i)) - beta_n * n(i))*dt;
    n(i+1) = n(i) + dn;

    dh = (alpha_h * (1 - h(i)) - beta_h * h(i))*dt;
    h(i+1) = h(i) + dh;

    da = ((a_infinity - a(i)) ./ tau_a)*dt; 
    a(i+1) = a(i) + da;

    db = ((b_infinity - b(i)) ./ tau_b)*dt;
    b(i+1) = b(i) + db;

    %Sub-components of Connor-Stevens model (makes debugging easier)
    I_leak= G_leak * (E_leak - Vm(i));
    I_Na= G_Na_max * (m(i) * m(i) * m(i)) * h(i) * (E_Na - Vm(i));
    I_K= G_K_max * (n(i) * n(i) * n(i) * n(i)) * (E_K - Vm(i));
    I_A= G_A_max * (a(i) * a(i) * a(i)) * b(i) * (E_A - Vm(i));

    %The Connor-Stevens model
    dV = ((I_leak + I_Na + I_K + I_A + I_app(i)) / C) * dt;
    Vm(i+1) = Vm(i) + dV;
end

%Plotting results
plot(time,Vm)
xlabel('Time (ms)')
ylabel('Membrane voltage (mV)')

%I wanted a title that changed based on the user input to make my graphs
%easier to understand. I got the idea for this code from an answer to 
%someone's question on Matlab's website. 
title(sprintf('MV when K-current conductance = %.0f uS', G_K_max))
end