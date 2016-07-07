--####################################
-- travelEncounters.lua
-- author: Jonas Yakimischak
--
-- This file is contains a list of the travel encounters as well as requiring the files.
--####################################

--namespace model.encounter.travelEncounters

--require the encounters
require("scripts.model.encounter.travelEncounters.firstPirateEncounter")
require("scripts.model.encounter.travelEncounters.llaxonAttackArtemis")
require("scripts.model.encounter.travelEncounters.leavingArtemisWithoutKillingLlaxon")
require("scripts.model.encounter.travelEncounters.pirateDestroyerEncounter")
require("scripts.model.encounter.travelEncounters.antsAttackTheGrove")
require("scripts.model.encounter.travelEncounters.leavingTheGroveBeforeKillingAnts")
require("scripts.model.encounter.travelEncounters.leaveTheGroveWithoutRepairs")
require("scripts.model.encounter.travelEncounters.leavingArtemisAtEnd")
require("scripts.model.encounter.travelEncounters.randomEncounters")


--the encounters in order of precedence
model.encounter.travelEncounters.encounters = util.getArrayList()
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.firstPirateEncounter)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.llaxonAttackArtemis)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.pirateDestroyerEncounter)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.leavingArtemisWithoutKillingLlaxon)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.antsAttackTheGrove)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.leavingTheGroveBeforeKillingAnts)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.leaveTheGroveWithoutRepairs)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.leavingArtemisAtEnd)
model.encounter.travelEncounters.encounters:add(model.encounter.travelEncounters.randomEncounter)


function model.encounter.travelEncounters.shakeStarMap()
	--shake the screen a few times
	local shakeTimer = MOAITimer.new()
	shakeTimer:setMode(MOAITimer.CONTINUE)
	shakeTimer:start()
	local timeBetweenShakes = .02
	local shakeTime
	for i=1, 40 do
		shakeTime = shakeTimer:getTime()
		local shakeX = math.random(-20, 20)
		local shakeY = math.random(-20, 20)
		screens.starMapScreen.starMapFitter:setFitLoc(gameState.travelingX + shakeX, gameState.travelingY + shakeY)
		while shakeTimer:getTime() - shakeTime <= timeBetweenShakes do
			coroutine.yield()
		end
	end
	shakeTimer:stop()
	--now fade the map screen
	local fadeAlpha = 0
	local function drawFade(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(0, 0, 0, fadeAlpha)
		MOAIDraw.fillRect(screens.starMapScreen.width / 2 * -1, screens.starMapScreen.height / 2 * -1, screens.starMapScreen.width / 2, screens.starMapScreen.height / 2)
	end
	local fadeDeck = MOAIScriptDeck.new()
	fadeDeck:setRect(screens.starMapScreen.width / 2 * -1, screens.starMapScreen.height / 2 * -1, screens.starMapScreen.width / 2, screens.starMapScreen.height / 2)
	fadeDeck:setDrawCallback(drawFade)
	local fadeProp = MOAIProp2D.new()
	fadeProp:setDeck(fadeDeck)
	fadeProp:setLoc(0, 0)
	fadeProp:setPriority(10000)
	screens.starMapScreen.layers.mapLayer:insertProp(fadeProp)
	local fadeTimer = MOAITimer.new()
	fadeTimer:setMode(MOAITimer.CONTINUE)
	fadeTimer:start()
	local prevTime = fadeTimer:getTime()
	local currTime = nil
	while fadeAlpha < 1 do
		coroutine.yield()
		currTime = fadeTimer:getTime()
		local delta = (currTime - prevTime) * .05
		if fadeAlpha + delta > 1 then
			fadeAlpha = 1
		else
			fadeAlpha = fadeAlpha + delta
		end
	end
	fadeTimer:stop()		
end

