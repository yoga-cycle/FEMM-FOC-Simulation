-- simple script to simulate FOC on BLDC motor

-- display console to print torque estimation and simulation progress
showconsole()
clearconsole()

-- open the fem file
mydir="./"
open(mydir .. "FOC_sim.fem")

-- save the fem file to another temporary file
-- the script will modify the rotor positions and winding currents during the simulation.  
mi_saveas(mydir .. "temp.fem")

-- set to edit mode to "group" so the rotor components can rotate as a "group".
-- refer to the femm user guide. 
mi_seteditmode("group")

-- motor is 14 pole motor. So 1 mechanical degree is 7 electrical degree
-- In each simulation step, rotor is rotated by 2 electrical degrees, i.e, 2/7 mechanical degrees 
-- 90 steps X 2 electrical degrees = 180 electrical degrees. so simulation rotates the rotor for 180 electrical degrees
step=90
rotation=0.2857

-- loop
for n=0,step do
	rotor_angle = n*rotation; -- current rotor angle, mechanical
	rotor_axis_electrical_angle = rotor_angle*7; -- get electrical angle 
	
	-- this section simulates FOC. 
	-- The d-axis is aligned with alpha-axis
	-- Implements the inverse park transform. Id is set to 0, Iq is set to 20A.
	i_alpha = -20*sin(rotor_axis_electrical_angle*3.14/180.0)
	i_beta = 20*cos(rotor_axis_electrical_angle*3.14/180.0)
	-- inverse clarke transform.
	i_a = i_alpha
	i_b = -0.5*i_alpha + 0.8660*i_beta
	i_c = -0.5*i_alpha - 0.8660*i_beta	
	
	-- update the current in phase as per FOC calculation
	mi_modifycircprop("A",1,i_a)
	mi_modifycircprop("B",1,i_b)
	mi_modifycircprop("C",1,i_c)

	-- run the solver, minimize window. 
    mi_analyze(1)
	-- After the solver is done, loads the solution 
    mi_loadsolution()
	
	-- adjsut screensize to get plots
	mo_resize(1200,1000)
	mo_zoom(-35,-35,35,35)
	
	-- show contour and density plots
    mo_showcontourplot(-1)
    mo_showdensityplot(1,0,2,0,"bmag")
	
	-- hide the plots after viewing. This makes the program more responsive
	mo_hidedensityplot()
    mo_hidecontourplot()
	
	-- select the rotor
    mo_groupselectblock(1)
	
	-- calculate the torque on the rotor
    torque=mo_blockintegral(22)
    print(rotor_angle,torque)
	
	-- select the rotor
	mi_selectgroup(1)
	
	-- rotate rotor to next location
	mi_moverotate(0,0,rotation)
end
mo_close()
mi_close()