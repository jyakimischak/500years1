--####################################
-- encounter.lua
-- author: Jonas Yakimischak
--
-- This file is related to the encounter manager.
--####################################

--namespace model.encounter

model.encounter.triggeredEncounters = {}
require("scripts.model.encounter.triggeredEncounters")
model.encounter.travelEncounters = {}
require("scripts.model.encounter.travelEncounters")

--------------------------------------------------------------------------
--getTriggeredEncounter
--this will get an encounter object for a triggered encounter.  These will happen when
--the player selects an option that triggers an encounter.  This could be selecting
--an option to speak with a crew member, or selecting an option from the
--planet screen.
--------------------------------------------------------------------------
function model.encounter.getTriggeredEncounter(encounter)
	model.encounter.triggeredEncounters[encounter]()
end

--------------------------------------------------------------------------
--getTravelEncounter
--this will get an encounter object for a travel encounter.
--These happens when traveling between star systems.  They can be random
--or can be part of the storyline
--will return true if an encounter is fired
--------------------------------------------------------------------------
function model.encounter.getTravelEncounter()
	for i=1, model.encounter.travelEncounters.encounters.length do
		if model.encounter.travelEncounters.encounters[i]() then
			audioUtil.playMusic("encounter")
			return true
		end
	end
	return false
end




----------------------------------------------------------------------------
----getRandomEncounter
----this will get an encounter object for a random encounter (or potentially nil if no encounter is selected.
----This will be used on the starmap and will take the x,y coords of the ship on the map.  The map location can
----change what types of encounter will happen.
----------------------------------------------------------------------------
--function model.encounter.getRandomEncounter(x, y)
--end
--
----------------------------------------------------------------------------
----getSolarSystemEncounter
----this will get an encounter object for a solar system encounter.  This is an encounter
----that takes place when entering a solar system.
----It will check the game state to see what solar system is approached.
----------------------------------------------------------------------------
--function model.encounter.getSolarSystemEncounter()
--end
--
----------------------------------------------------------------------------
----getPlanetEncounter
----this will get an encounter object for a planet encounter.  This is an encounter
----that takes place when approaching a planet.
----It will check the game state to see what planet is approached.
----------------------------------------------------------------------------
--function model.encounter.getPlanetEncounter()
--end



