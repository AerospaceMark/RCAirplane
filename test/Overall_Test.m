clear;

RC = Airplane;

% Overall Properties
RC.Weight = 15; % pounds
RC.CL_Max = 1.278;
RC.CL = 0.227; % the current CL (not max)
RC.CD = 0.014; % the current CD
RC.Speed = 29.88; % current speed (mph)
RC.CD_Zero_Lift = 0.01;
RC.CD_Parasitic = 0.003;

% Wing Properties
RC.Wing_Area = 12; % feet
RC.Wing_Span = 8; % feet
RC.Mean_Aerodynamic_Chord = 1.5; % feet
RC.Inviscid_Efficiency = 1.0;

% Horizontal Stabilizer Properties
RC.Horizontal_Tail_Area = 2.1; % ft^2
RC.Horizontal_Tail_Lever_Arm = 4.8; % ft

% Vertical Stabilizer Properties
RC.Vertical_Tail_Area = 1.05; % ft^2
RC.Vertical_Tail_Lever_Arm = 4.8; % ft

% Propulsion Properties
RC.Propulsion_Power = 680; % Watts
RC.Total_Thrust = 20; % pounds
RC.Battery_Weight = 2; % pounds
RC.Battery_Total_Energy = 1000; % Watt-hours
RC.Propulsion_Efficiency = 0.5;

% Other
RC.Bank_Angle = 10; % Degrees

% Ambient Properties
RC.Air_Density = 0.002377; % slugs / ft^3
RC.Gravitational_Acceleration = 32.2; % ft/s^2
RC.Kinematic_Viscosity = 1.5723e-4; % ft^2/s

RC