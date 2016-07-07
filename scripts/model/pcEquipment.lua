--####################################
-- pcEquipment.lua
-- author: Jonas Yakimischak
--
-- This holds objects for information on the pc ship weapons.
--####################################

--namespace model.pcEquipment

--------------------------------------------------------------------------
--pcWeapon
--the following functions will return the pcWeapon object.
--------------------------------------------------------------------------

--level 1 weapons
function model.pcEquipment.nuclearTorpedoes()
	local pcWeapon = {}
	pcWeapon.functionName = "nuclearTorpedoes"
	pcWeapon.name = "Nuclear Torpedoes"
	pcWeapon.energy = 1
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "nuclearTorpedoes"
	return pcWeapon
end

function model.pcEquipment.laserBeam()
	local pcWeapon = {}
	pcWeapon.functionName = "laserBeam"
	pcWeapon.name = "Laser Beam"
	pcWeapon.energy = 1
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "laserBeam"
	return pcWeapon
end

function model.pcEquipment.miniGun()
	local pcWeapon = {}
	pcWeapon.functionName = "miniGun"
	pcWeapon.name = "Mini Gun"
	pcWeapon.energy = 1
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "miniGun"
	return pcWeapon
end

--level 2 weapons
function model.pcEquipment.fissionTorpedoes()
	local pcWeapon = {}
	pcWeapon.functionName = "fissionTorpedoes"
	pcWeapon.name = "Fission Torpedoes"
	pcWeapon.energy = 2
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "fissionTorpedoes"
	return pcWeapon
end

function model.pcEquipment.ionBeam()
	local pcWeapon = {}
	pcWeapon.functionName = "ionBeam"
	pcWeapon.name = "Ion Beam"
	pcWeapon.energy = 2
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "ionBeam"
	return pcWeapon
end

function model.pcEquipment.massDriver()
	local pcWeapon = {}
	pcWeapon.functionName = "massDriver"
	pcWeapon.name = "Mass Driver"
	pcWeapon.energy = 2
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "massDriver"
	return pcWeapon
end

--level 3 weapons
function model.pcEquipment.antiMatterTorpedoes()
	local pcWeapon = {}
	pcWeapon.functionName = "antiMatterTorpedoes"
	pcWeapon.name = "Anti-Matter Torpedoes"
	pcWeapon.energy = 3
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "antiMatterTorpedoes"
	return pcWeapon
end

function model.pcEquipment.plasmaCannon()
	local pcWeapon = {}
	pcWeapon.functionName = "plasmaCannon"
	pcWeapon.name = "Plasma Cannon"
	pcWeapon.energy = 3
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "plasmaCannon"
	return pcWeapon
end

function model.pcEquipment.coilGun()
	local pcWeapon = {}
	pcWeapon.functionName = "coilGun"
	pcWeapon.name = "Coil Gun"
	pcWeapon.energy = 3
	pcWeapon.gsNamespace = "pcWeapons"
	pcWeapon.gsName = "coilGun"
	return pcWeapon
end

--------------------------------------------------------------------------
--pcengines
--the following functions will return the pcengines object.
--------------------------------------------------------------------------

function model.pcEquipment.enginesLevel1()
	local pcengines = {}
	pcengines.functionName = "enginesLevel1"
	pcengines.name = "Engines Level 1"
	pcengines.energy = 1
	pcengines.gsNamespace = "pcEngines"
	pcengines.gsName = "level1"
	return pcengines 
end

function model.pcEquipment.enginesLevel2()
	local pcengines = {}
	pcengines.functionName = "enginesLevel2"
	pcengines.name = "Engines Level 2"
	pcengines.energy = 2
	pcengines.gsNamespace = "pcEngines"
	pcengines.gsName = "level2"
	return pcengines 
end

function model.pcEquipment.enginesLevel3()
	local pcengines = {}
	pcengines.functionName = "enginesLevel3"
	pcengines.name = "Engines Level 3"
	pcengines.energy = 3
	pcengines.gsNamespace = "pcEngines"
	pcengines.gsName = "level3"
	return pcengines 
end


--------------------------------------------------------------------------
--pcComputer
--the following functions will return the pcComputer object.
--------------------------------------------------------------------------

function model.pcEquipment.computerLevel1()
	local pcComputer = {}
	pcComputer.functionName = "computerLevel1"
	pcComputer.name = "Computer Level 1"
	pcComputer.energy = 1
	pcComputer.gsNamespace = "pcComputer"
	pcComputer.gsName = "level1"
	return pcComputer 
end

function model.pcEquipment.computerLevel2()
	local pcComputer = {}
	pcComputer.functionName = "computerLevel2"
	pcComputer.name = "Computer Level 2"
	pcComputer.energy = 2
	pcComputer.gsNamespace = "pcComputer"
	pcComputer.gsName = "level2"
	return pcComputer 
end

function model.pcEquipment.computerLevel3()
	local pcComputer = {}
	pcComputer.functionName = "computerLevel3"
	pcComputer.name = "Computer Level 3"
	pcComputer.energy = 3
	pcComputer.gsNamespace = "pcComputer"
	pcComputer.gsName = "level3"
	return pcComputer 
end


--------------------------------------------------------------------------
--pcSheilds
--the following functions will return the pcShields object.
--------------------------------------------------------------------------

function model.pcEquipment.shieldsLevel1()
	local pcShields = {}
	pcShields.functionName = "shieldsLevel1"
	pcShields.name = "Shields Level 1"
	pcShields.energy = 1
	pcShields.gsNamespace = "pcShields"
	pcShields.gsName = "level1"
	return pcShields 
end

function model.pcEquipment.shieldsLevel2()
	local pcShields = {}
	pcShields.functionName = "shieldsLevel2"
	pcShields.name = "Shields Level 2"
	pcShields.energy = 2
	pcShields.gsNamespace = "pcShields"
	pcShields.gsName = "level2"
	return pcShields 
end

function model.pcEquipment.shieldsLevel3()
	local pcShields = {}
	pcShields.functionName = "shieldsLevel3"
	pcShields.name = "Shields Level 3"
	pcShields.energy = 3
	pcShields.gsNamespace = "pcShields"
	pcShields.gsName = "level3"
	return pcShields 
end




