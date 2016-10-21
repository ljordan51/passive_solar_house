function res = Thermal_Flow(t,U_thermal)

%ARGUMENT VARIABLES
%t = time in minutes
%U_thermal = current energy in the thermal mass       

%HOUSE VARIABLES 

%HEAT TRANSFER CONSTANTS
h_air = 10*60;                 %heat transfer coefficient for air convection

if t <= 12*60
    solar_irradiance = 1050;    %radiation energy/square meter
elseif t > 12*60
    solar_irradiance = 0;    
end
    
%k_wall = 1;                %heat transfer coefficient for walls conduction
%ambient_temp = 295;        %Kelvin

%FLOOR 
floor_length = 4;           %meters
floor_width = 4;            %meters
floor_thickness = 0.2032;    %meters
thermal_area = floor_length*floor_width; %area in contact with solar radiation

%WALLS+CEILING (CONDUCTION) (NOT NEEDED FOR THIS FLOW)
%wall_width = 4;             %meters
%wall_height = 4;            %meters
%number_walls = 4;           %4 walls
%wall_thickness = 0.2032;   %8 inches converted to meters
%wall_area = wall_width*wall_height*number_walls; %square meters

%ceiling_length = 4;         %meters
%ceiling_width = 4;          %meters

%ceiling_thickness = 0.2032; %8 inches converted to meters
        %unused for now because ceiling and wall are combined into 1
        %conduction flow with same material/thickenss. Will be used when we
        %separate ceiling conduction from walls conduction.
        
%ceiling_area = ceiling_length*ceiling_width; %square meters

%area_conduction = ceiling_area + wall_area; %total conductive area

%ENERGY TO TEMPERATURE CONVERSIONS

%THERMAL MASS

thermal_volume = floor_thickness*floor_length*floor_width;
thermal_density = 2400;     %kilograms per cubic metre
thermal_mass = thermal_volume*thermal_density; %kilograms
thermal_spec_heat = 750;    %J/(kg*K)
thermal_heat_capacity = thermal_mass * thermal_spec_heat; %heat capacity

thermal_temp = U_thermal/thermal_heat_capacity;

%FLOW EQUATIONS (FINALLY)

air_temp = 295; %temporary placeholder

dU_Thermal = (solar_irradiance*thermal_area) - (h_air*thermal_area*(thermal_temp-air_temp));

%dU_Air = (h_air*thermal_area*(air_temp-thermal_temp))...
%- ((k_wall*area_conduction)/(wall_thickness))*(air_temp-ambient_temp);

res = dU_Thermal;