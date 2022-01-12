clear;

RC = Airplane;

% Overall Properties
RC.Weight = 15; % pounds
RC.CL_Max = 1.278;
RC.CL = 0.55; % the current CL (not max)
RC.Speed = 29.88; % current speed (mph)
RC.CD_Zero_Lift = 0.01;

% Wing Properties
RC.Wing_Area = 12; % feet
RC.Wing_Span = 8; % feet
RC.Mean_Aerodynamic_Chord = 1.5; % feet

% Horizontal Stabilizer Properties
RC.Horizontal_Tail_Area = 2.1; % ft^2
RC.Horizontal_Tail_Lever_Arm = 4.8; % ft

% Vertical Stabilizer Properties
RC.Vertical_Tail_Area = 1.05; % ft^2
RC.Vertical_Tail_Lever_Arm = 4.8; % ft

% Propulsion Properties
RC.Propulsion_Power = 680; % Watts
RC.Total_Thrust = 20; % Pounds

% Ambient Properties
RC.Air_Density = 0.002377; % slugs / ft^3

RC