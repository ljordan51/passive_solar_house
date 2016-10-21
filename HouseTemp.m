function res = HouseTemp(time)

hold on

air_heat_capacity = 78400;
initial_temp = 295;
air_energy0 = air_heat_capacity*initial_temp;

thermal_heat_capacity = 5852160;                            %thermal_mass*thermal_heat_cap
initial_temp = 295;                                         %outside ambient temp in Kelvin
thermal_energy0 = thermal_heat_capacity*initial_temp;       %initial energy of thermal mass
initials = [thermal_energy0, air_energy0]; 

[T,U] = ode45(@Thermal_Flows, [0,time], initials);       %ODE for thermal mass

Ut = U(:,1);
Ua = U(:,2);

Tt = Ut./thermal_heat_capacity;                             %convert thermal mass energy vector to temperature
Ta = Ua./air_heat_capacity;                                 %convert air energy to air to temperature

plot(T,Tt,'r-')                                             %plot temp of thermal mass
plot(T,Ta,'b-')                                             %plot temp of air

res = Ta(end);                                              %final temperature of thermal mass