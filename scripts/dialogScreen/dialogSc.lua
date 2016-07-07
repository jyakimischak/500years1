--####################################
-- dialogSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the dialog screen.
--####################################

--namespace screens.dialogScreen

screens.dialogScreen.pointerX = 0
screens.dialogScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.dialogScreen.pointerCallback(x, y)
	cursorHover = false

	screens.dialogScreen.pointerX, screens.dialogScreen.pointerY = x, y 
	screens.dialogScreen.optionsButtonList:pointer(screens.dialogScreen.layers.layer:wndToWorld(screens.dialogScreen.pointerX, screens.dialogScreen.pointerY))

	if windowsBuild then
		screens.dialogScreen.optionsButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.dialogScreen.pointerX, x, screens.dialogScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.dialogScreen.clickCallback(down)
	local worldX, worldY = screens.dialogScreen.layers.layer:wndToWorld(screens.dialogScreen.pointerX, screens.dialogScreen.pointerY)
	local buttonName = screens.dialogScreen.optionsButtonList:click(worldX, worldY, down)
	if buttonName ~= nil then
		--update the npc response
		local option = screens.dialogScreen.dialog:selectOption(buttonName)
		screens.dialogScreen.props.npcDialogText:setString(option.response)
		--update the options list
		screens.dialogScreen.drawOptions()
		--update the portrait
		local portraitWidth = screens.dialogScreen.portraitWidth
		local deck, names, index = screens.dialogScreen.dialog:getPortrait()
		deck:setRect(names[index], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
		screens.dialogScreen.props.portrait:setDeck(deck)
		screens.dialogScreen.props.portrait:setIndex(names[index])
		--if there is an action function call it now
		if option.actionFunction ~= nil then
			option.actionFunction()
		end
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.dialogScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLY < 0 then
		screens.dialogScreen.optionsButtonList:selectNext()
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLY > 0 then
		screens.dialogScreen.optionsButtonList:selectPrev()
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end

	screens.dialogScreen.optionsButtonList:selectedVisible(true)

	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = screens.dialogScreen.optionsButtonList:getSelected()
		if buttonName ~= nil then
			--update the npc response
			local option = screens.dialogScreen.dialog:selectOption(buttonName)
			screens.dialogScreen.props.npcDialogText:setString(option.response)
			--update the options list
			screens.dialogScreen.drawOptions()
			--update the portrait
			local portraitWidth = screens.dialogScreen.portraitWidth
			local deck, names, index = screens.dialogScreen.dialog:getPortrait()
			deck:setRect(names[index], portraitWidth / 2 * -1, portraitWidth / 2 * -1, portraitWidth / 2, portraitWidth / 2)
			screens.dialogScreen.props.portrait:setDeck(deck)
			screens.dialogScreen.props.portrait:setIndex(names[index])
			--if there is an action function call it now
			if option.actionFunction ~= nil then
				option.actionFunction()
			end
			screens.dialogScreen.optionsButtonList:selectedVisible(false)
		end
	end

end