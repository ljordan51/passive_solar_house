function res = ThermalFlows(~,energies)

%ARGUMENT VARIABLES
%~ = time
U_thermal = energies(1);    %current energy of the thermal mass
U_air = energies(2);        %current energy of the air        

%HOUSE VARIABLES 

%HEAT TRANSFER CONSTANTS
h_air = 10;                 %heat transfer coefficient for air convection
solar_irradiance = 1050;    %radiation energy/square meter
k_wall = 1;                 %heat transfer coefficient for walls conduction
ambient_temp = 295;         %Kelvin

%FLOOR 
floor_length = 4;           %meters
floor_width = 4;            %meters
floor_thickness = 0.2032;    %meters
thermal_area = floor_length*floor_width; %area in contact with solar radiation

%WALLS+CEILING (CONDUCTION)
wall_width = 4;             %meters
wall_height = 4;            %meters
number_walls = 4;           %4 walls
wall_thickness = 0.2032;    %8 inches converted to meters
wall_area = wall_width*wall_height*number_walls; %square meters

ceiling_length = 4;         %meters
ceiling_width = 4;          %meters

%ceiling_thickness = 0.2032; %8 inches converted to meters
        %unused for now because ceiling and wall are combined into 1
        %conduction flow with same material/thickenss. Will be used when we
        %separate ceiling conduction from walls conduction.
        
ceiling_area = ceiling_length*ceiling_width; %square meters

area_conduction = ceiling_area + wall_area; %total conductive area

%ENERGY TO TEMPERATURE CONVERSIONS

%AIR

air_volume = floor_length*floor_width*wall_height; %m^3
air_density = 1.225;        %kg/m3
air_mass = air_volume*air_density; %kg
air_spec_heat = 1000;       %J/(kg*K)
air_heat_capacity = air_mass*air_spec_heat; %heat capacity

air_temp = U_air/air_heat_capacity;

%THERMAL MASS

thermal_volume = floor_thickness*floor_length*floor_width;
thermal_density = 2400;     %kilograms per cubic metre
thermal_mass = thermal_volume*thermal_density; %kilograms
thermal_spec_heat = 750;    %J/(kg*K)
thermal_heat_capacity = thermal_mass * thermal_spec_heat; %heat capacity

thermal_temp = U_thermal/thermal_heat_capacity;

%FLOW EQUATIONS (FINALLY)

dU_Thermal = (solar_irradiance*thermal_area) - (h_air*thermal_area*(air_temp-thermal_temp));
%Change in energy of the thermal mass is the incoming energy from sun minus
%convection energy loss from air.

dU_Air = (h_air*thermal_area*(air_temp-thermal_temp))...
- ((k_wall*area_conduction)/(wall_thickness))*(air_temp-ambient_temp);

%Change in energy of the air is the convection energy taken off the surface
%of the thermal mass - the conduction energy loss from the walls. 

res = [dU_Thermal, dU_Air];

end






