# FEMM-FOC-Simulation
FEMM simulation of field oriented control for BLDC motors

FEMM is a free tool for doing magnetic simulations. In this project, BLDC motor control using field-oriented control is simulated using FEMM software. This is done by adjusting the phase current in accordance with the FOC computation using the rotor angle and measuring the torque produced on the rotor.

| ![simulation gif](https://github.com/yoga-cycle/FEMM-FOC-Simulation/blob/main/resources/simulation.gif) |
|:--:| 
|*Animation gif*|

To run the simulation,
- Download the resources folder
- Open FEMM
- Click *file->Open lua script*
- Navigate to the resources folder and Select *FOC_sim.lua*

## stator and rotor design
First step in simulating the motor is to design the stator with windings and rotor with magnets. The stator and rotor design can be saved as a DXF file and imported into FEMM. The DXF files are available in the resources folder.

| ![Stator and rotor DXF](https://github.com/yoga-cycle/FEMM-FOC-Simulation/blob/main/resources/stator_rotor.jpg) |
|:--:| 
|*Stator and rotor DXF files used in the simulation*|

## configure FEMM
FEMM will be used as the "Magnetics Problem" in this investigation. The winding pattern and magnet direction must be entered. It is necessary to choose appropriate materials for the magnets, winding, rotor, and stator. The toy motor's stack length is configured at 10mm. The information is already set up in the .fem file.

| ![FEMM project](https://github.com/yoga-cycle/FEMM-FOC-Simulation/blob/main/resources/femm_project.jpg) |
|:--:| 
|*motor assembly used for simulation. Note that rotor d axis and phase A are initially aligned*| 

## Lua script
Lua scripts can automate FEMM analysis. The current in the windings is adjusted according to the rotor angle and the torque on the rotor is measured. The procedure is then repeated with the rotor slightly rotated to the next angle. The console receives the measured torques and rotor angles.

| ![torque vs rotor angle](https://github.com/yoga-cycle/FEMM-FOC-Simulation/blob/main/resources/plot.png) |
|:--:| 
|*Plot of angle vs torque. Torque measurements and rotor angle are taken from the console after the simulation is complete*|

This [great blog post](https://things-in-motion.blogspot.com/2019/02/how-to-model-bldc-pmsm-motors-kv.html) served as the inspiration and source of ideas for this project.
