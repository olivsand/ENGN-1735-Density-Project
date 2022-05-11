%a script for calculating the equivalent density of the material of an
%empty tube so that it has the same mass as a less dense tube filled with
%fluid.
rho_water = 1000; %kg/m^3
rho_ethanol = 789;
rho_saltwater = 1024;

%densities for empty tubes for total weight = full tube
equiv_water = get_density(rho_water) %kg/m^3
equiv_ethanol = get_density(rho_ethanol)
equiv_saltwater = get_density(rho_saltwater)

function density = get_density(rho_fluid)
rho_tube = 2180;%density of tube, kg/m^3, borosilicate glass
v_tube = 8.85E-6;%volume of tube, m^3, taken from cad model for 8" tube, 6 mm OD, 3 mm
v_fluid = 1.18E-5;%volume of fluid, m^3, taken from cad model for 8" tube
density = (rho_fluid*v_fluid)/v_tube + rho_tube;
end