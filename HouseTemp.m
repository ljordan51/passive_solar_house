function res = HouseTemp(time)

[T1,U1] = ode45(@Thermal_Flow, [0,