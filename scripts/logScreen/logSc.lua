--####################################
-- logSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the log screen.
--####################################

--namespace screens.logScreen

screens.logScreen.pointerX = 0
screens.logScreen.pointerY = 0

screens.logScreen.scrollingLogList = false
--screens.logScreen.scrollingLogEntryInitialTouchY = nil
screens.logScreen.scrollingLogEntry = false

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.logScreen.pointerCallback(x, y)
	if windowsBuild then
		xbox.mouseMoved(screens.logScreen.pointerX, x, screens.logScreen.pointerY, y)
	end

	--if we are scrolling then scroll the log entry
	if screens.logScreen.scrollingLogEntry then
		local entryX, entryY = screens.logScreen.props.logEntry:getLoc()
		entryY = entryY - (y - screens.logScreen.pointerY)
		if entryY < 0 then
			entryY = 0
		end
		if entryY > screens.logScreen.logEntryMaxY then
			entryY = screens.logScreen.logEntryMaxY
		end
		screens.logScreen.props.logEntry:setLoc(entryX, entryY)
	end

	--if we are scrolling then scroll the log list
	if screens.logScreen.scrollingLogList then
		for i = 1, screens.logScreen.logListProps.length do
			local listX, listY = screens.logScreen.logListProps[i]:getLoc()
			listY = listY - (y - screens.logScreen.pointerY)
			if listY < 0 then
				listY = 0
			end
			if listY > screens.logScreen.questsMaxY then
				listY = screens.logScreen.questsMaxY
			end
			screens.logScreen.logListProps[i]:setLoc(listX, listY)
		end
		
		
--		local entryX, entryY = screens.logScreen.props.logEntry:getLoc()
--		entryY = entryY - (y - screens.logScreen.pointerY)
--		if entryY < 0 then
--			entryY = 0
--		end
--		if entryY > screens.logScreen.logEntryMaxY then
--			entryY = screens.logScreen.logEntryMaxY
--		end
--		screens.logScreen.props.logEntry:setLoc(entryX, entryY)
	end


	screens.logScreen.pointerX, screens.logScreen.pointerY = x, y 
	screens.logScreen.bannerButtonList:pointer(screens.logScreen.layers.bannerLayer:wndToWorld(screens.logScreen.pointerX, screens.logScreen.pointerY))
	screens.logScreen.screenButtonList:pointer(screens.logScreen.layers.screenLayer:wndToWorld(screens.logScreen.pointerX, screens.logScreen.pointerY))
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.logScreen.clickCallback(down)
	--if it's a touch up then stop scrolling the log entry
	if not down then
		screens.logScreen.scrollingLogEntry = false
		screens.logScreen.scrollingLogList = false
	end

	local bannerWorldX, bannerWorldY = screens.logScreen.layers.bannerLayer:wndToWorld(screens.logScreen.pointerX, screens.logScreen.pointerY)
	local buttonName = screens.logScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		frontController.dispatch(frontController.OPTIONS_SCREEN)
		return
	end

	local screenWorldX, screenWorldY = screens.logScreen.layers.screenLayer:wndToWorld(screens.logScreen.pointerX, screens.logScreen.pointerY)
	local buttonName = screens.logScreen.screenButtonList:click(screenWorldX, screenWorldY, down)
	if buttonName ~= nil then
		local quest = model.quests[buttonName]()
		screens.logScreen.props.logEntry:setString(quest:getLogEntry())
		screens.logScreen.props.logEntry:setLoc(0, 0)
	end

	--scroll the entry
	if down and screens.logScreen.props.logEntry:inside(screenWorldX, screenWorldY) then
		screens.logScreen.scrollingLogEntry = true
	end

	--scroll the list
	if down and screenWorldX < -80 and screenWorldY < 250 then
		screens.logScreen.scrollingLogList = true
	end
end
