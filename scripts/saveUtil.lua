--####################################
-- saveUtil.lua
-- author: Jonas Yakimischak
--
-- This contains functions for saving the gamestate to file and loading it from file.
--####################################

--namespace saveUtil

--------------------------------------------------------------------------
--saveGame
--This will save the game to 1 of the 4 save slots
--------------------------------------------------------------------------
function saveUtil.saveGame(slot)
	local serializer = MOAISerializer.new()
	--set the date/time into the gameState
	gameState.saveDate = os.date("%b %d, %Y at %X") 
	serializer:serialize(gameState)
	serializer:exportToFile(documentsDirectory.."/save"..slot)
end

--------------------------------------------------------------------------
--loadGame
--This will load the game to 1 of the 4 save slots
--------------------------------------------------------------------------
function saveUtil.loadGame(slot)
	local saveGameState = dofile(documentsDirectory.."/save"..slot)
	--the serialization does not keep member functions...so we need to fix up the visible star map locations arraylist
	local savedStarMapLocations = saveGameState.visibleStarMapLocations
	local newStarMapLocations = util.getArrayList()
	for i = 1, savedStarMapLocations.length do
		newStarMapLocations:add(savedStarMapLocations[i])
	end
	saveGameState.visibleStarMapLocations = newStarMapLocations 
	gameState = saveGameState 
end

