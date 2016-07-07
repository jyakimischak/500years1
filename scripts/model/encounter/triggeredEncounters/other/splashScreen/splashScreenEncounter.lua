--####################################
-- splashScreenEncounter.lua
-- author: Jonas Yakimischak
--
-- This file is the triggered encounter for the splash screens at the start of the game.
--####################################

--namespace model.encounter.triggeredEncounters

--------------------------------------------------------------------------
--splashScreen
--------------------------------------------------------------------------
function model.encounter.triggeredEncounters.splashScreen()
	local encounterThread = MOAICoroutine.new ()
	encounterThread:run (
		function()
			local fadeTime = .5
			local splashMinTime = 2
			local timeBetween = .5
			local timer = MOAITimer.new()
			timer:setMode(MOAITimer.CONTINUE)
			timer:start()

			screens.splashScreen.splashImage = screens.splashScreen.POORWILL
			frontController.dispatch(frontController.SPLASH_SCREEN)
			local startTime = timer:getTime()
			local currentTime = timer:getTime()
			local color = screens.splashScreen.startColor
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = (1 - screens.splashScreen.startColor) * percentChange  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= splashMinTime do
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = 1 - ((1 - screens.splashScreen.startColor) * percentChange)  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			screens.splashScreen.props.splashProp:setVisible(false)
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= timeBetween do
				coroutine.yield()
				currentTime = timer:getTime()
			end
			
			screens.splashScreen.splashImage = screens.splashScreen.MOAI
			frontController.dispatch(frontController.SPLASH_SCREEN)
			startTime = timer:getTime()
			currentTime = timer:getTime()
			local color = screens.splashScreen.startColor
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = (1 - screens.splashScreen.startColor) * percentChange  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= splashMinTime do
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = 1 - ((1 - screens.splashScreen.startColor) * percentChange)  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			screens.splashScreen.props.splashProp:setVisible(false)
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= timeBetween do
				coroutine.yield()
				currentTime = timer:getTime()
			end

			screens.splashScreen.splashImage = screens.splashScreen.DIM_LIGHT
			frontController.dispatch(frontController.SPLASH_SCREEN)
			startTime = timer:getTime()
			currentTime = timer:getTime()
			local color = screens.splashScreen.startColor
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = (1 - screens.splashScreen.startColor) * percentChange  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= splashMinTime do
				coroutine.yield()
				currentTime = timer:getTime()
			end
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= fadeTime do
				local percentChange = (currentTime - startTime) / fadeTime
				color = 1 - ((1 - screens.splashScreen.startColor) * percentChange)  
				screens.splashScreen.props.splashProp:setColor(color, color, color)
				coroutine.yield()
				currentTime = timer:getTime()
			end
			screens.splashScreen.props.splashProp:setVisible(false)
			startTime = timer:getTime()
			currentTime = timer:getTime()
			while currentTime - startTime <= timeBetween do
				coroutine.yield()
				currentTime = timer:getTime()
			end
			
			splashScreenIntroComplete = true
		end
	)
end

