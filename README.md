# SPEY_Engine_Control_Analysis_MATLAB
Modeling, Simulation, and PID Control Design for a Rolls-Royce SPEY Turbojet Engine based on technical paper analysis

## Context and Origin
Kulikov, G. G., et al. "Dynamic Model Identification of a Turbo Jet Engine". Dynamic Modelling of Gas Turbines. Edited by G. G. Kulikov et al. Springer-Verlag London, 2004, pp. 271-292.


* **Static Model:** Nonlinear relationship between Fuel Flow ($W_f$) and Shaft Speeds ($n_{HP}, n_{LP}$) (Equations 15.9, 15.10).
* **Dynamic LTI Plant Models:**
    * Fuel Feed System ($H_f(s)$) 
    * Engine HP Dynamics ($H_{e\_HP}(s)$) 
    * Engine LP Dynamics ($H_{e\_LP}(s)$)

 1.  **Static Model Simulation:** Visualization of the nonlinear relationship and gain variation with the operating point.
    * [Link to static relationship figure](screenshots/Static_Rel.PNG)
    * [Link to static gain figure](screenshots/Static_gain_VS_Fuel_flow.PNG)
2.  **Dynamic Model and Plant Simulation:** Implementation of LTI TFs with delays and simulation of their responses (Bode, step if applicable).
    * [HP Plant Bode Figure (Hf*He_HP)](screenshots/Bode%20Diagrams/Bode_HP_Axis_Dyamic_Model.PNG)
    * Brief discussion on the phase challenges due to delays.
3.  **Original Closed-Loop System Simulation:** Implementation and simulation of the closed loop with $H_c$, $H_f$, $H_{e\_HP}$.
    * [closed-loop step response figure](screenshots/Closed%20loop/Closed%20_loop_Response_HP_demand.PNG)
    * **Key Finding:** Describe the instability observed in the standard negative feedback simulation. Briefly explain your subsequent analysis (based on the sign of $H_c$ and the `feedback` formulas) and how you obtained a stable response using a specific closed-loop interpretation (corresponding to `feedback` with +1 or the characteristic equation $1-|G|=0$).
    * Optional: [Link to Bode figure of the full original Open-Loop (Hc*Plant)](screenshots/Bode%20Diagrams/Bode_open_loop_system_fem_to_n_HP.PNG) and mention the resulting stability margins confirming the linear instability.



* Dynamic System Modeling (LTI and Static Nonlinear)
* Interpretation of Models from Technical Papers
* System Simulation in MATLAB/Simulink
* Time and Frequency Response Analysis (Bode Plots)
* Stability Analysis (Gain/Phase Margins, interpreting unexpected results)
* PID Controller Design
* Usage of MATLAB/Simulink Tools (Control System Toolbox, PID Tuner)
* Problem Solving and Critical Thinking (when analyzing the original instability)
* Technical Documentation
