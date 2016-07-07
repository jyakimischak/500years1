--####################################
-- restartBattleEncounter.lua
-- author: Jonas Yakimischak
--
-- This file contains an encounter for restarting a battle.  We need to start the battle in an encounter because
-- if it is started in a callback directly then we will get an "attempt to yield across metamethod/C-call boundary" error.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--restartBattle
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.restartBattle()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			battle.restartBattle()
		end
	)
end

