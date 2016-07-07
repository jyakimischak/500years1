--####################################
-- loadoutScreen.lua
-- author: Jonas Yakimischak
--
-- This is the ship loadout screen for the game.
--####################################

--namespace screens.loadoutScreen

screens.loadoutScreen.props = {}
screens.loadoutScreen.viewports = {}
screens.loadoutScreen.layers = {}
screens.loadoutScreen.callingScreen = ""

--y offset due to re-jigging the banner
screens.loadoutScreen.yOffset = 30

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.loadoutScreen.display()
	--setup prop namespaces
	screens.loadoutScreen.props.mainMenu = {}
	screens.loadoutScreen.props.pcWeapons = {}
	screens.loadoutScreen.props.pcEngines = {}
	screens.loadoutScreen.props.pcComputer = {}
	screens.loadoutScreen.props.pcShields = {}

	--no menu has been selected
	screens.loadoutScreen.selectedMenu = nil

	--setup the viewports and layers
	--screen
	screens.loadoutScreen.viewports.screenViewport = MOAIViewport.new()
	screens.loadoutScreen.viewports.screenViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadoutScreen.viewports.screenViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadoutScreen.layers.screenLayer = MOAILayer2D.new()
	screens.loadoutScreen.layers.screenLayer:setViewport(screens.loadoutScreen.viewports.screenViewport)
	MOAISim.pushRenderPass(screens.loadoutScreen.layers.screenLayer)
	--banner
	screens.loadoutScreen.viewports.bannerViewport = MOAIViewport.new()
	screens.loadoutScreen.viewports.bannerViewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.loadoutScreen.viewports.bannerViewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.loadoutScreen.layers.bannerLayer = MOAILayer2D.new()
	screens.loadoutScreen.layers.bannerLayer:setViewport(screens.loadoutScreen.viewports.bannerViewport)
	MOAISim.pushRenderPass(screens.loadoutScreen.layers.bannerLayer)

	--setup sprites
	local pcShipWidth = 125
	local pcShipHeight = pcShipWidth * 512 / 256 
	shipsGfxQuads:setRect(shipsNames["pcShipNoOutline.png"], pcShipWidth / 2 * -1, pcShipHeight / 2 * -1, pcShipWidth / 2, pcShipHeight / 2)

	--setup the button selected prop
	if windowsBuild then
		local selectedArrowWidth = 30
		local selectedArrowHeight = selectedArrowWidth * 110 / 100
		sharedGfxQuads:setRect(sharedNames["selectArrow.png"], selectedArrowWidth / 2 * -1, selectedArrowHeight / 2 * -1, selectedArrowWidth / 2, selectedArrowHeight / 2)
		screens.loadoutScreen.props.selectedArrowMenuProp = MOAIProp2D.new()
		screens.loadoutScreen.props.selectedArrowMenuProp:setDeck(sharedGfxQuads)
		screens.loadoutScreen.props.selectedArrowMenuProp:setIndex(sharedNames["selectArrow.png"])
		screens.loadoutScreen.props.selectedArrowMenuProp:setVisible(false)
		screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.selectedArrowMenuProp)
		screens.loadoutScreen.props.selectedArrowWeaponsProp = MOAIProp2D.new()
		screens.loadoutScreen.props.selectedArrowWeaponsProp:setDeck(sharedGfxQuads)
		screens.loadoutScreen.props.selectedArrowWeaponsProp:setIndex(sharedNames["selectArrow.png"])
		screens.loadoutScreen.props.selectedArrowWeaponsProp:setVisible(false)
		screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.selectedArrowWeaponsProp)
		screens.loadoutScreen.props.selectedArrowEnginesProp = MOAIProp2D.new()
		screens.loadoutScreen.props.selectedArrowEnginesProp:setDeck(sharedGfxQuads)
		screens.loadoutScreen.props.selectedArrowEnginesProp:setIndex(sharedNames["selectArrow.png"])
		screens.loadoutScreen.props.selectedArrowEnginesProp:setVisible(false)
		screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.selectedArrowEnginesProp)
		screens.loadoutScreen.props.selectedArrowComputersProp = MOAIProp2D.new()
		screens.loadoutScreen.props.selectedArrowComputersProp:setDeck(sharedGfxQuads)
		screens.loadoutScreen.props.selectedArrowComputersProp:setIndex(sharedNames["selectArrow.png"])
		screens.loadoutScreen.props.selectedArrowComputersProp:setVisible(false)
		screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.selectedArrowComputersProp)
		screens.loadoutScreen.props.selectedArrowShieldsProp = MOAIProp2D.new()
		screens.loadoutScreen.props.selectedArrowShieldsProp:setDeck(sharedGfxQuads)
		screens.loadoutScreen.props.selectedArrowShieldsProp:setIndex(sharedNames["selectArrow.png"])
		screens.loadoutScreen.props.selectedArrowShieldsProp:setVisible(false)
		screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.selectedArrowShieldsProp)
	end
	--setup button lists
	screens.loadoutScreen.bannerButtonList = screenUtil.getButtonList()
	screens.loadoutScreen.menuButtonList = screenUtil.getButtonList(screens.loadoutScreen.props.selectedArrowMenuProp, -220, 0)
	screens.loadoutScreen.pcWeaponsButtonList = screenUtil.getButtonList(screens.loadoutScreen.props.selectedArrowWeaponsProp, -220, 0)
	screens.loadoutScreen.pcEnginesButtonList = screenUtil.getButtonList(screens.loadoutScreen.props.selectedArrowEnginesProp, -220, 0)
	screens.loadoutScreen.pcComputerButtonList = screenUtil.getButtonList(screens.loadoutScreen.props.selectedArrowComputersProp, -220, 0)
	screens.loadoutScreen.pcShieldsButtonList = screenUtil.getButtonList(screens.loadoutScreen.props.selectedArrowShieldsProp, -220, 0)
	if windowsBuild then
		screens.loadoutScreen.menuButtonList:selectedVisible(not xbox.cursorVisible)
	end

	--get the equipment objects
	local weapon = model.pcEquipment[gameState.pcShipEquippedWeapon]()  
	local engines = model.pcEquipment[gameState.pcShipEquippedEngines]()  
	local computer = model.pcEquipment[gameState.pcShipEquippedComputer]()  
	local shields = model.pcEquipment[gameState.pcShipEquippedShields]()  

	--draw the banner background
	screens.loadoutScreen.props.bannerBackgroundProp = MOAIProp2D.new()
	screens.loadoutScreen.props.bannerBackgroundProp:setDeck(sharedGfxQuads)
	screens.loadoutScreen.props.bannerBackgroundProp:setIndex(sharedNames["bannerBackground.png"])
	screens.loadoutScreen.props.bannerBackgroundProp:setLoc(0, SCREEN_UNITS_Y / 2 - 35)
	screens.loadoutScreen.layers.bannerLayer:insertProp(screens.loadoutScreen.props.bannerBackgroundProp)
	
	--draw the title
	screenUtil.addTextBox(
		screens.loadoutScreen.layers.bannerLayer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		500, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		titleColorR, titleColorG, titleColorB, titleColorAlpha, -- color r g b a 
		textLookup.loadoutScreen.title)
		
	--add the back button
	screens.loadoutScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.loadoutScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonColorR, bannerButtonColorG, bannerButtonColorB, bannerButtonColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.loadoutScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.loadoutScreen.layers.bannerLayer,
		SCREEN_UNITS_X / 2 * -1 + 70, -- centerX
		SCREEN_UNITS_Y / 2 - 60, -- centerY
		150, -- width
		70, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		bannerButtonPressedColorR, bannerButtonPressedColorG, bannerButtonPressedColorB, bannerButtonPressedColorAlpha, -- color r g b a 
		textLookup.general.back)
	screens.loadoutScreen.props.backButtonPressedProp:setVisible(false)
	screens.loadoutScreen.bannerButtonList:addButton("back", screens.loadoutScreen.props.backButtonProp, screens.loadoutScreen.props.backButtonPressedProp)
	
	--draw the horizontal rule under the title
	local function drawHorizontalRule(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(bannerHRColorR, bannerHRColorG, bannerHRColorB)
		MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	end
	local hrDeck = MOAIScriptDeck.new()
	hrDeck:setRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	hrDeck:setDrawCallback(drawHorizontalRule)
	local hrProp = MOAIProp2D.new()
	hrProp:setDeck(hrDeck)
	hrProp:setLoc(0, SCREEN_UNITS_Y / 2 - 67)
	screens.loadoutScreen.layers.bannerLayer:insertProp(hrProp)

	
	--draw the ship
	screens.loadoutScreen.props.pcShip = MOAIProp2D.new()
	screens.loadoutScreen.props.pcShip:setDeck(shipsGfxQuads) 
	screens.loadoutScreen.props.pcShip:setIndex(shipsNames["pcShipNoOutline.png"])
	screens.loadoutScreen.props.pcShip:setLoc(-425, 100 - screens.loadoutScreen.yOffset)
	screens.loadoutScreen.layers.screenLayer:insertProp(screens.loadoutScreen.props.pcShip)
	
	--draw the armor playing label
	screenUtil.addTextBox(
		screens.loadoutScreen.layers.screenLayer,
		-425, -- centerX
		-70 - screens.loadoutScreen.yOffset, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		20, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.loadoutScreen.armorPlating.."\n"..gameState.shipTotalArmor)

	--draw the available energy label
	screens.loadoutScreen.availableEnergy =  gameState.shipTotalEnergy - weapon.energy - engines.energy -  computer.energy - shields.energy
	screenUtil.addTextBox(
		screens.loadoutScreen.layers.screenLayer,
		-425, -- centerX
		-135 - screens.loadoutScreen.yOffset, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		20, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.loadoutScreen.availableEnergy.."\n"..screens.loadoutScreen.availableEnergy.."/"..gameState.shipTotalEnergy)


	--draw the equipment menu items
	--weapon
	screens.loadoutScreen.drawMenuItem(
		"weapon", --name
		"mainMenu", --namespace
		220 - screens.loadoutScreen.yOffset, --y
		textLookup.loadoutScreen.weaponMenu.." "..weapon.name --text
		)
	--engines
	screens.loadoutScreen.drawMenuItem(
		"engines", --name
		"mainMenu", --namespace
		150 - screens.loadoutScreen.yOffset, --y
		textLookup.loadoutScreen.enginesMenu.." "..engines.name --text
		)
	--computer
	screens.loadoutScreen.drawMenuItem(
		"computer", --name
		"mainMenu", --namespace
		80 - screens.loadoutScreen.yOffset, --y
		textLookup.loadoutScreen.computerMenu.." "..computer.name --text
		)
	--shields
	screens.loadoutScreen.drawMenuItem(
		"shields", --name
		"mainMenu", --namespace
		10 - screens.loadoutScreen.yOffset, --y
		textLookup.loadoutScreen.shieldsMenu.." "..shields.name --text
		)


	local equipmentMenuStartY = 220 - screens.loadoutScreen.yOffset
	local equipmentMenuSpaceBetween = 50
	--weapons menu
	--nuclear torpedoes
	local nuclearTorpedoesObject = model.pcEquipment.nuclearTorpedoes()
	screens.loadoutScreen.drawSubMenuItem(
		nuclearTorpedoesObject, --equipmentObject
		equipmentMenuStartY --y
		)
	--laser beam
	local laserBeamObject = model.pcEquipment.laserBeam()
	screens.loadoutScreen.drawSubMenuItem(
		laserBeamObject, --equipmentObject
		equipmentMenuStartY - equipmentMenuSpaceBetween --y
		)
	--mini gun
	local miniGunObject = model.pcEquipment.miniGun()
	screens.loadoutScreen.drawSubMenuItem(
		miniGunObject, --equipmentObject
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 2) --y
		)
	--fission torpedoes
	local fissionTorpedoesObject = model.pcEquipment.fissionTorpedoes()
	screens.loadoutScreen.drawSubMenuItem(
		fissionTorpedoesObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 3) --y
		)
	--ion beam
	local ionBeamObject = model.pcEquipment.ionBeam()
	screens.loadoutScreen.drawSubMenuItem(
		ionBeamObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 4) --y
		)
	--mass driver
	local massDriverObject = model.pcEquipment.massDriver()
	screens.loadoutScreen.drawSubMenuItem(
		massDriverObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 5) --y
		)
	--anti-matter torpedoes
	local antiMatterTorpedoesObject = model.pcEquipment.antiMatterTorpedoes()
	screens.loadoutScreen.drawSubMenuItem(
		antiMatterTorpedoesObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 6) --y
		)
	--plasma cannon
	local plasmaCannonObject = model.pcEquipment.plasmaCannon()
	screens.loadoutScreen.drawSubMenuItem(
		plasmaCannonObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 7) --y
		)
	--coil gun
	local coilGunObject = model.pcEquipment.coilGun()
	screens.loadoutScreen.drawSubMenuItem(
		coilGunObject,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 8) --y
		)


	--engines menu
	--engines level 1
	local enginesLevel1Object = model.pcEquipment.enginesLevel1()
	screens.loadoutScreen.drawSubMenuItem(
		enginesLevel1Object,
		equipmentMenuStartY --y
		)
	--engines level 2
	local enginesLevel2Object = model.pcEquipment.enginesLevel2()
	screens.loadoutScreen.drawSubMenuItem(
		enginesLevel2Object,
		equipmentMenuStartY - equipmentMenuSpaceBetween --y
		)
	--engines level 3
	local enginesLevel3Object = model.pcEquipment.enginesLevel3()
	screens.loadoutScreen.drawSubMenuItem(
		enginesLevel3Object,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 2) --y
		)

	--computer menu
	--computer level 1
	local computerLevel1Object = model.pcEquipment.computerLevel1()
	screens.loadoutScreen.drawSubMenuItem(
		computerLevel1Object,
		equipmentMenuStartY --y
		)
	--computer level 2
	local computerLevel2Object = model.pcEquipment.computerLevel2()
	screens.loadoutScreen.drawSubMenuItem(
		computerLevel2Object,
		equipmentMenuStartY - equipmentMenuSpaceBetween --y
		)
	--computer level 3
	local computerLevel3Object = model.pcEquipment.computerLevel3()
	screens.loadoutScreen.drawSubMenuItem(
		computerLevel3Object,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 2) --y
		)

	--shields menu
	--shields level 1
	local shieldsLevel1Object = model.pcEquipment.shieldsLevel1()
	screens.loadoutScreen.drawSubMenuItem(
		shieldsLevel1Object,
		equipmentMenuStartY --y
		)
	--shields level 2
	local shieldsLevel2Object = model.pcEquipment.shieldsLevel2()
	screens.loadoutScreen.drawSubMenuItem(
		shieldsLevel2Object,
		equipmentMenuStartY - equipmentMenuSpaceBetween --y
		)
	--shields level 3
	local shieldsLevel3Object = model.pcEquipment.shieldsLevel3()
	screens.loadoutScreen.drawSubMenuItem(
		shieldsLevel3Object,
		equipmentMenuStartY - (equipmentMenuSpaceBetween * 2) --y
		)


	--setup the controller callbacks
	if windowsBuild then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.loadoutScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.loadoutScreen.clickCallback)
		--xbox controller input
		xbox.setCallback(screens.loadoutScreen.xboxCallback)
	else
		if MOAIInputMgr.device.pointer then
			-- mouse input
			MOAIInputMgr.device.pointer:setCallback(screens.loadoutScreen.pointerCallback)
			MOAIInputMgr.device.mouseLeft:setCallback(screens.loadoutScreen.clickCallback)
		else
			-- touch input
			MOAIInputMgr.device.touch:setCallback ( 
				function(eventType, idx, x, y, tapCount)
					screens.loadoutScreen.pointerCallback(x, y)
					if eventType == MOAITouchSensor.TOUCH_DOWN then
						screens.loadoutScreen.clickCallback(true)
					elseif eventType == MOAITouchSensor.TOUCH_UP then
						screens.loadoutScreen.clickCallback(false)
					end
				end
			)
		end
	end
end


--------------------------------------------------------------------------
-- drawMenuItem
--------------------------------------------------------------------------
function screens.loadoutScreen.drawMenuItem(name, namespace, y, text)
	local x = -100
	screens.loadoutScreen.props[namespace][name] = screenUtil.addTextBox(
		screens.loadoutScreen.layers.screenLayer,
		x, -- centerX
		y, -- centerY
		400, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		text)
	screens.loadoutScreen.props[namespace][name.."Pressed"] = screenUtil.addTextBox(
		screens.loadoutScreen.layers.screenLayer,
		x, -- centerX
		y, -- centerY
		400, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		.6, .6, .6, 1, -- color r g b a 
		text)
	screens.loadoutScreen.props[namespace][name.."Pressed"]:setVisible(false)
	screens.loadoutScreen.props[namespace][name.."GreyOut"] = screenUtil.addTextBox(
		screens.loadoutScreen.layers.screenLayer,
		x, -- centerX
		y, -- centerY
		400, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		.1, .1, .1, 1, -- color r g b a 
		text)
	screens.loadoutScreen.props[namespace][name.."GreyOut"]:setVisible(false)
	screens.loadoutScreen.menuButtonList:addButton(name, screens.loadoutScreen.props[namespace][name], screens.loadoutScreen.props[namespace][name.."Pressed"], x, y)
end

--------------------------------------------------------------------------
-- drawSubMenuItem
--------------------------------------------------------------------------
function screens.loadoutScreen.drawSubMenuItem(equipmentObject, y)
	--if the player doesn't have the equipment then don't add it to the menu
	if not gameState[equipmentObject.gsNamespace][equipmentObject.gsName] then
		return
	end

	local name = equipmentObject.functionName
	local text = equipmentObject.name.." ("..equipmentObject.energy..")"
	local x = 350
	local namespace = equipmentObject.gsNamespace
	local buttonList = equipmentObject.gsNamespace.."ButtonList"
--print(name)
--print(namespace)
--print(x)
--print(y)
--print(text)
--print(buttonList)

	local weapon = model.pcEquipment[gameState.pcShipEquippedWeapon]()  
	local engines = model.pcEquipment[gameState.pcShipEquippedEngines]()  
	local computer = model.pcEquipment[gameState.pcShipEquippedComputer]()  
	local shields = model.pcEquipment[gameState.pcShipEquippedShields]()  
	
	--check if there is enough energy for them to select this
	local availableEnergy
	if namespace == "pcWeapons" then
		availableEnergy = gameState.shipTotalEnergy - engines.energy - computer.energy - shields.energy
	elseif namespace == "pcEngines" then
		availableEnergy = gameState.shipTotalEnergy - weapon.energy - computer.energy - shields.energy
	elseif namespace == "pcComputer" then
		availableEnergy = gameState.shipTotalEnergy - weapon.energy - engines.energy - shields.energy
	elseif namespace == "pcShields" then
		availableEnergy = gameState.shipTotalEnergy - weapon.energy - engines.energy - computer.energy
	end
--print(availableEnergy)
	if equipmentObject.energy > availableEnergy then
		screens.loadoutScreen.props[namespace][name] = screenUtil.addTextBox(
			screens.loadoutScreen.layers.screenLayer,
			x, -- centerX
			y, -- centerY
			400, -- width
			30, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			30, -- fontSize
			.4, .4, .4, 1, -- color r g b a 
			text)
		screens.loadoutScreen.props[namespace][name]:setVisible(false)
	else
		screens.loadoutScreen.props[namespace][name] = screenUtil.addTextBox(
			screens.loadoutScreen.layers.screenLayer,
			x, -- centerX
			y, -- centerY
			400, -- width
			30, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			30, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			text)
		screens.loadoutScreen.props[namespace][name]:setVisible(false)
		screens.loadoutScreen.props[namespace][name.."Pressed"] = screenUtil.addTextBox(
			screens.loadoutScreen.layers.screenLayer,
			x, -- centerX
			y, -- centerY
			400, -- width
			30, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			30, -- fontSize
			.6, .6, .6, 1, -- color r g b a 
			text)
		screens.loadoutScreen.props[namespace][name.."Pressed"]:setVisible(false)
		screens.loadoutScreen.props[namespace][name.."GreyOut"] = screenUtil.addTextBox(
			screens.loadoutScreen.layers.screenLayer,
			x, -- centerX
			y, -- centerY
			400, -- width
			30, -- height
			fonts.grStylusFont,
			MOAITextBox.LEFT_JUSTIFY,
			MOAITextBox.LEFT_JUSTIFY,
			30, -- fontSize
			.1, .1, .1, 1, -- color r g b a 
			text)
		screens.loadoutScreen.props[namespace][name.."GreyOut"]:setVisible(false)
		screens.loadoutScreen[buttonList]:addButton(name, screens.loadoutScreen.props[namespace][name], screens.loadoutScreen.props[namespace][name.."Pressed"], x, y)
	end
end

--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.loadoutScreen.destroy()
	screens.loadoutScreen.clickablePropList = nil
	screens.loadoutScreen.bannerButtonList = nil
	screens.loadoutScreen.screenButtonList = nil
	--destroy the props
	for key, value in pairs(screens.loadoutScreen.props.mainMenu) do
		screens.loadoutScreen.props.mainMenu[key] = nil
	end
	screens.loadoutScreen.props.mainMenu = nil
	for key, value in pairs(screens.loadoutScreen.props.pcWeapons) do
		screens.loadoutScreen.props.pcWeapons[key] = nil
	end
	screens.loadoutScreen.props.pcWeapons = nil
	for key, value in pairs(screens.loadoutScreen.props.pcEngines) do
		screens.loadoutScreen.props.pcEngines[key] = nil
	end
	screens.loadoutScreen.props.pcEngines = nil
	for key, value in pairs(screens.loadoutScreen.props.pcComputer) do
		screens.loadoutScreen.props.pcComputer[key] = nil
	end
	screens.loadoutScreen.props.pcComputer = nil
	for key, value in pairs(screens.loadoutScreen.props.pcShields) do
		screens.loadoutScreen.props.pcShields[key] = nil
	end
	screens.loadoutScreen.props.pcShields = nil
	for key, value in pairs(screens.loadoutScreen.props) do
		screens.loadoutScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.loadoutScreen.layers) do
		if screens.loadoutScreen.layers[key] ~= nil then
			screens.loadoutScreen.layers[key]:clear()
			screens.loadoutScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.loadoutScreen.viewports) do
		screens.loadoutScreen.viewports[key] = nil
	end
end

	