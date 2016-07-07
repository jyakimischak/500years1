--####################################
-- loadoutSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for the ship loadout screen.
--####################################

--namespace screens.loadoutScreen

screens.loadoutScreen.pointerX = 0
screens.loadoutScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.loadoutScreen.pointerCallback(x, y)
	cursorHover = false

	screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY = x, y 
	screens.loadoutScreen.bannerButtonList:pointer(screens.loadoutScreen.layers.bannerLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	if screens.loadoutScreen.selectedMenu == "weapons" then
		screens.loadoutScreen.pcWeaponsButtonList:pointer(screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	elseif screens.loadoutScreen.selectedMenu == "engines" then
		screens.loadoutScreen.pcEnginesButtonList:pointer(screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	elseif screens.loadoutScreen.selectedMenu == "computers" then
		screens.loadoutScreen.pcComputerButtonList:pointer(screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	elseif screens.loadoutScreen.selectedMenu == "shields" then
		screens.loadoutScreen.pcShieldsButtonList:pointer(screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	else
		screens.loadoutScreen.menuButtonList:pointer(screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY))
	end

	if windowsBuild then
		screens.loadoutScreen.menuButtonList:selectedVisible(false)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(false)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(false)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(false)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(false)
		xbox.mouseMoved(screens.loadoutScreen.pointerX, x, screens.loadoutScreen.pointerY, y)
	end
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.loadoutScreen.clickCallback(down)
	local bannerWorldX, bannerWorldY = screens.loadoutScreen.layers.bannerLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY)
	local buttonName = screens.loadoutScreen.bannerButtonList:click(bannerWorldX, bannerWorldY, down)
	if buttonName == "back" then
		if screens.loadoutScreen.callingScreen == "optionsScreen" then
			frontController.dispatch(frontController.OPTIONS_SCREEN)
		else
			frontController.dispatch(frontController.PREPARE_BATTLE_SCREEN)
		end
		return
	end

	local screenWorldX, screenWorldY = screens.loadoutScreen.layers.screenLayer:wndToWorld(screens.loadoutScreen.pointerX, screens.loadoutScreen.pointerY)
	local buttonName = nil
	if screens.loadoutScreen.selectedMenu == "weapons" then
		buttonName = screens.loadoutScreen.pcWeaponsButtonList:click(screenWorldX, screenWorldY, down)
		if buttonName ~= nil then
			gameState.pcShipEquippedWeapon = buttonName
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		end
	elseif screens.loadoutScreen.selectedMenu == "engines" then
		buttonName = screens.loadoutScreen.pcEnginesButtonList:click(screenWorldX, screenWorldY, down)
		if buttonName ~= nil then
			gameState.pcShipEquippedEngines = buttonName
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		end
	elseif screens.loadoutScreen.selectedMenu == "computers" then
		buttonName = screens.loadoutScreen.pcComputerButtonList:click(screenWorldX, screenWorldY, down)
		if buttonName ~= nil then
			gameState.pcShipEquippedComputer = buttonName
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		end
	elseif screens.loadoutScreen.selectedMenu == "shields" then
		buttonName = screens.loadoutScreen.pcShieldsButtonList:click(screenWorldX, screenWorldY, down)
		if buttonName ~= nil then
			gameState.pcShipEquippedShields = buttonName
			frontController.dispatch(frontController.LOADOUT_SCREEN)
			return
		end
	else
		buttonName = screens.loadoutScreen.menuButtonList:click(screenWorldX, screenWorldY, down)
		if buttonName == "weapon" then
			screens.loadoutScreen.selectedMenu = "weapons"
			--gray out the options on the menu items
			screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
			--show weapons options
			for key, value in pairs(screens.loadoutScreen.props.pcWeapons) do
				if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
					screens.loadoutScreen.props.pcWeapons[key]:setVisible(true)
				end
			end
		elseif buttonName == "engines" then
			screens.loadoutScreen.selectedMenu = "engines"
			--gray out the options on the menu items
			screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
			--show the engines options
			for key, value in pairs(screens.loadoutScreen.props.pcEngines) do
				if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
					screens.loadoutScreen.props.pcEngines[key]:setVisible(true)
				end
			end
		elseif buttonName == "computer" then
			screens.loadoutScreen.selectedMenu = "computers"
			--gray out the options on the menu items
			screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
			--show the computer options
			for key, value in pairs(screens.loadoutScreen.props.pcComputer) do
				if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
					screens.loadoutScreen.props.pcComputer[key]:setVisible(true)
				end
			end
		elseif buttonName == "shields" then
			screens.loadoutScreen.selectedMenu = "shields"
			--gray out the options on the menu items
			screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
			screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
			screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
			--show the shields options
			for key, value in pairs(screens.loadoutScreen.props.pcShields) do
				if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
					screens.loadoutScreen.props.pcShields[key]:setVisible(true)
				end
			end
		end
	end
end

--------------------------------------------------------------------------
-- Callback function for an xbox controller
--------------------------------------------------------------------------
function screens.loadoutScreen.xboxCallback(buttons, leftTrigger, rightTrigger, thumbLX, thumbLY, thumbRX, thumbRY)
	if not xbox.leftThumbMoved and thumbLY < 0 then
		if screens.loadoutScreen.selectedMenu == nil then
			screens.loadoutScreen.menuButtonList:selectNext()
		elseif screens.loadoutScreen.selectedMenu == "weapons" then
			screens.loadoutScreen.pcWeaponsButtonList:selectNext()
		elseif screens.loadoutScreen.selectedMenu == "engines" then
			screens.loadoutScreen.pcEnginesButtonList:selectNext()
		elseif screens.loadoutScreen.selectedMenu == "computers" then
			screens.loadoutScreen.pcComputerButtonList:selectNext()
		elseif screens.loadoutScreen.selectedMenu == "shields" then
			screens.loadoutScreen.pcShieldsButtonList:selectNext()
		end
		xbox.leftThumbMoved = true
	elseif not xbox.leftThumbMoved and thumbLY > 0 then
		if screens.loadoutScreen.selectedMenu == nil then
			screens.loadoutScreen.menuButtonList:selectPrev()
		elseif screens.loadoutScreen.selectedMenu == "weapons" then
			screens.loadoutScreen.pcWeaponsButtonList:selectPrev()
		elseif screens.loadoutScreen.selectedMenu == "engines" then
			screens.loadoutScreen.pcEnginesButtonList:selectPrev()
		elseif screens.loadoutScreen.selectedMenu == "computers" then
			screens.loadoutScreen.pcComputerButtonList:selectPrev()
		elseif screens.loadoutScreen.selectedMenu == "shields" then
			screens.loadoutScreen.pcShieldsButtonList:selectPrev()
		end
		xbox.leftThumbMoved = true
	elseif xbox.leftThumbMoved and thumbLY == 0 then
		xbox.leftThumbMoved = false
	end


	if screens.loadoutScreen.selectedMenu == nil then
		screens.loadoutScreen.menuButtonList:selectedVisible(true)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(false)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(false)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(false)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(false)
	elseif screens.loadoutScreen.selectedMenu == "weapons" then
		screens.loadoutScreen.menuButtonList:selectedVisible(false)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(true)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(false)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(false)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(false)
	elseif screens.loadoutScreen.selectedMenu == "engines" then
		screens.loadoutScreen.menuButtonList:selectedVisible(false)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(false)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(true)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(false)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(false)
	elseif screens.loadoutScreen.selectedMenu == "computers" then
		screens.loadoutScreen.menuButtonList:selectedVisible(false)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(false)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(false)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(true)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(false)
	elseif screens.loadoutScreen.selectedMenu == "shields" then
		screens.loadoutScreen.menuButtonList:selectedVisible(false)
		screens.loadoutScreen.pcWeaponsButtonList:selectedVisible(false)
		screens.loadoutScreen.pcEnginesButtonList:selectedVisible(false)
		screens.loadoutScreen.pcComputerButtonList:selectedVisible(false)
		screens.loadoutScreen.pcShieldsButtonList:selectedVisible(true)
	end

	if xbox.controller:isButtonDown(MOAIXboxController.B, buttons) then
		if screens.loadoutScreen.callingScreen == "optionsScreen" then
			frontController.dispatch(frontController.OPTIONS_SCREEN)
		else
			frontController.dispatch(frontController.PREPARE_BATTLE_SCREEN)
		end
		return
	end
	
	if xbox.controller:isButtonDown(MOAIXboxController.A, buttons) then
		local buttonName = nil
		if screens.loadoutScreen.selectedMenu == "weapons" then
			buttonName = screens.loadoutScreen.pcWeaponsButtonList:getSelected()
			if buttonName ~= nil then
				gameState.pcShipEquippedWeapon = buttonName
				frontController.dispatch(frontController.LOADOUT_SCREEN)
				return
			end
		elseif screens.loadoutScreen.selectedMenu == "engines" then
			buttonName = screens.loadoutScreen.pcEnginesButtonList:getSelected()
			if buttonName ~= nil then
				gameState.pcShipEquippedEngines = buttonName
				frontController.dispatch(frontController.LOADOUT_SCREEN)
				return
			end
		elseif screens.loadoutScreen.selectedMenu == "computers" then
			buttonName = screens.loadoutScreen.pcComputerButtonList:getSelected()
			if buttonName ~= nil then
				gameState.pcShipEquippedComputer = buttonName
				frontController.dispatch(frontController.LOADOUT_SCREEN)
				return
			end
		elseif screens.loadoutScreen.selectedMenu == "shields" then
			buttonName = screens.loadoutScreen.pcShieldsButtonList:getSelected()
			if buttonName ~= nil then
				gameState.pcShipEquippedShields = buttonName
				frontController.dispatch(frontController.LOADOUT_SCREEN)
				return
			end
		else
			buttonName = screens.loadoutScreen.menuButtonList:getSelected()
			if buttonName == "weapon" then
				screens.loadoutScreen.selectedMenu = "weapons"
				--gray out the options on the menu items
				screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
				--show weapons options
				for key, value in pairs(screens.loadoutScreen.props.pcWeapons) do
					if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
						screens.loadoutScreen.props.pcWeapons[key]:setVisible(true)
					end
				end
			elseif buttonName == "engines" then
				screens.loadoutScreen.selectedMenu = "engines"
				--gray out the options on the menu items
				screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
				--show the engines options
				for key, value in pairs(screens.loadoutScreen.props.pcEngines) do
					if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
						screens.loadoutScreen.props.pcEngines[key]:setVisible(true)
					end
				end
			elseif buttonName == "computer" then
				screens.loadoutScreen.selectedMenu = "computers"
				--gray out the options on the menu items
				screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.shields:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.shieldsGreyOut:setVisible(true)
				--show the computer options
				for key, value in pairs(screens.loadoutScreen.props.pcComputer) do
					if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
						screens.loadoutScreen.props.pcComputer[key]:setVisible(true)
					end
				end
			elseif buttonName == "shields" then
				screens.loadoutScreen.selectedMenu = "shields"
				--gray out the options on the menu items
				screens.loadoutScreen.props.mainMenu.weapon:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.weaponGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.engines:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.enginesGreyOut:setVisible(true)
				screens.loadoutScreen.props.mainMenu.computer:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerPressed:setVisible(false)
				screens.loadoutScreen.props.mainMenu.computerGreyOut:setVisible(true)
				--show the shields options
				for key, value in pairs(screens.loadoutScreen.props.pcShields) do
					if not string.find(key, "Pressed") and not string.find(key, "GreyOut") then
						screens.loadoutScreen.props.pcShields[key]:setVisible(true)
					end
				end
			end
		end
	end

end
