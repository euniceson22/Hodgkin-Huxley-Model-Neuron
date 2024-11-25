# Predictive Model of a Functional Neuron

### Project Overview 
A comprehensive representation of how the following factors impact a neuron's firing behavior: sodium and potassium channels (and their varying subtypes), 
electrical conductance, extracellular charges, cell capacitance and the speed of opening and closing gates.  

### Context
The neuron's primary form of communication is through firing action potentials within and between connections. Adjusting the strength, speed, 
and firing patterns produce distinct results. Neuron receives stimulation -> Voltage threshold is surpassed -> sodium rushes in, voltage peaks -> potassium
is expelled, voltage undershoots -> refractory period -> returns to rest. 

### Sources Used 
*An Introductory Course in Computational Neuroscience* by Paul Miller
NSBV2004- Fundamentals in Computational Neuroscience (at Barnard College)

### Tools Used 
MATLAB_2023
  - 2D plotting
  - Graph visualization
    Custom functions
      - Spike counter
      - Peak electrical charge identifier

### Procedure Overview
1. Initialized parameters such as resting membrane potential, injected current, firing threshold, gating variables, and other cellular representations.
2. Adjusted amount of applied current to regulate excitability; ensure clarity in anticipated results for the following analysis.
3. Additional analysis of the potassium A-current & m,h and k gating variables.
   - The A-current is a special type of potassium channel that accounts for gating variables. 
5. Implemented custom functions that concisely identifies metrics.
6. Results are plotted and analyzed. 
