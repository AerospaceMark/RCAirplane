classdef Airplane
    
    properties
        
        % Main Airplane Properties
        Weight = [];
        CL_Max = []; % The maximum lift coefficient
        Speed = []; % The current speed
        CL = []; % The current lift coefficient
        CD = []; % The current drag coefficient
        CD_Zero_Lift = []; % The no-lift drag coefficient
        CD_Parasitic = []; % The parasitic drag coefficient
        
        % Wing Properties
        Wing_Area = []; % ft^2
        Mean_Aerodynamic_Chord = []; % ft
        Wing_Span = []; % ft
        Inviscid_Efficiency = [];
        
        % Horizontal Stabilizer Properties
        Horizontal_Tail_Area = []; % ft^2
        Horizontal_Tail_Lever_Arm = []; % ft
        
        % Vertical Stabilizer Properties
        Vertical_Tail_Area = []; % ft^2
        Vertical_Tail_Lever_Arm = []; % ft
        
        % Propulsion Properties
        Propulsion_Power = []; % Watts
        Total_Thrust = []; % pounds
        Battery_Weight = []; % pounds
        Battery_Total_Energy = []; % Watt-hours
        Propulsion_Efficiency = [];
        
        % Other Properties
        Bank_Angle = []; % degrees
        
        % Ambient Properties
        Air_Density = []; % slugs/ft^3
        Gravitational_Acceleration = 32.2; % ft/s^2
        Kinematic_Viscosity = 1.5723e-4; % ft^2/s
        
    end
        
    properties (Dependent)
        
        Horizontal_Tail_Volume
        Vertical_Tail_Volume
        Wing_Loading % lbs / ft^2
        Stall_Speed % mph
        Lift % pounds
        Drag % pounds
        Dynamic_Pressure
        Takeoff_Distance % ft
        Maximum_Speed % mph
        CL_For_Max_Efficiency
        CL_For_Max_Endurance
        Reynolds_Number
        Aspect_Ratio
        Range % miles
        Endurance % hours
        Lift_To_Drag_Ratio
        Rate_Of_Climb % ft/s
        Turning_Radius % ft
        Load_Factor
        
    end
        
        
    methods
        
        function value = get.Horizontal_Tail_Volume(obj)
            
            value = obj.Horizontal_Tail_Area .* obj.Horizontal_Tail_Lever_Arm ./ ...
                    (obj.Wing_Area .* obj.Mean_Aerodynamic_Chord);
            
        end
        
        function value = get.Vertical_Tail_Volume(obj)
            
            value = obj.Vertical_Tail_Area .* obj.Vertical_Tail_Lever_Arm ./ ...
                    (obj.Wing_Area .* obj.Wing_Span);
            
        end
        
        function value = get.Wing_Loading(obj)
            
            value = obj.Weight ./ obj.Wing_Area;
            
        end
        
        function value = get.Stall_Speed(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            value = sqrt(2 .* obj.Weight ./ ...
                (obj.Air_Density .* obj.Wing_Area .* obj.CL_Max));
            
            value = value .* 0.682; % Convert ft/s to mph
            
        end
        
        function value = get.Dynamic_Pressure(obj)
            
            % The 0.682 converts speed from mph to ft/s
            value = 0.5 .* obj.Air_Density .* (obj.Speed ./ 0.682).^2;
            
        end
        
        function value = get.Lift(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            value = obj.CL .* obj.Dynamic_Pressure .* obj.Wing_Area;
            
        end
        
        function value = get.Takeoff_Distance(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            % FIXME: Check the conversion of power in Watts to
            % foot-pound-force per second via the factor of 0.738. Is this
            % the right thing to do?
            % FIXME: The report has the wrong formula. Replace the report's
            % formula with eq. 7.81 in the 415 textbook
            % FIXME: What is the 1.629 factor out front? Is it related to
            % dimensions?
            value = 1.629 .* obj.Weight.^(5/2) ./ ...
                (obj.Gravitational_Acceleration .* (obj.Air_Density .* obj.Wing_Area .* obj.CL_Max).^(3/2) ...
                .* obj.Propulsion_Power .* 0.738);
            
        end
        
        function value = get.Maximum_Speed(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            % FIXME: This may help: https://www.youtube.com/watch?v=QQONGTE_RBw
            
            K = 0.38; % FIXME: What is this?
            value = sqrt((obj.Total_Thrust./obj.Weight).^2 - 4 .* obj.CD_Zero_Lift .* K);
            value = obj.Total_Thrust ./ obj.Wing_Area + (obj.Weight ./ obj.Wing_Area .* value);
            value = value ./ (obj.Air_Density .* obj.CD_Zero_Lift);
            value = sqrt(value);
            
            value = value .* 0.682; % Convert ft/s to mph
            
        end
        
        function value = get.Reynolds_Number(obj)
            
            value = obj.Speed .* obj.Mean_Aerodynamic_Chord ./ obj.Kinematic_Viscosity;
            
        end
        
        function value = get.Aspect_Ratio(obj)
            
            value = obj.Wing_Span.^2 ./ obj.Wing_Area;
            
        end
        
        function value = get.CL_For_Max_Efficiency(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            value = sqrt(obj.CD_Parasitic .* pi .* obj.Aspect_Ratio .* obj.Inviscid_Efficiency);
            
        end
        
        function value = get.Drag(obj)
            
            % FIXME: Use generalized reference area instead of wing area
            value = obj.CD .* obj.Dynamic_Pressure .* obj.Wing_Area;
            
        end
        
        function value = get.Lift_To_Drag_Ratio(obj)
            
            value = obj.CL ./ obj.CD;
            
        end
        
        function value = get.Range(obj)
            
            % Convert energy density to metric and seconds
            value = 3600 .* obj.Battery_Total_Energy ./ (obj.Battery_Weight .* 4.448);
            value = value ./ (obj.Gravitational_Acceleration .* 0.3048);
            value = value .* obj.Propulsion_Efficiency;
            value = value .* obj.Lift_To_Drag_Ratio;
            value = value .* obj.Battery_Weight ./ obj.Weight;
            
            % convert to miles
            value = value ./ 1609;
            
        end
        
        function value = get.Endurance(obj)
            
            value = obj.Range ./ obj.Speed;
            
        end
        
        function value = get.CL_For_Max_Endurance(obj)
            
            value = sqrt(3 .* obj.CD_Parasitic .* pi .* obj.Aspect_Ratio .* obj.Inviscid_Efficiency);
            
        end
        
        function value = get.Rate_Of_Climb(obj)
            
            value = obj.Speed .* (obj.Total_Thrust - obj.Drag) ./ obj.Weight;
            
            % convert mph to ft/s
            value = value * 1.467;
            
        end
        
        function value = get.Turning_Radius(obj)
            
            value = obj.Speed.^2 / (obj.Gravitational_Acceleration .* tand(obj.Bank_Angle));
            
        end
        
        function value = get.Load_Factor(obj)
            
            value = 1 ./ cosd(obj.Bank_Angle);
            
        end
        
    end
    
end