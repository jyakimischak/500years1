--####################################
-- createCharacterScreen.lua
-- author: Jonas Yakimischak
--
-- This screen will let the player create their character.
--####################################

--namespace screens.createCharacterScreen

screens.createCharacterScreen.props = {}
screens.createCharacterScreen.viewports = {}
screens.createCharacterScreen.layers = {}

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.createCharacterScreen.display()
	screens.createCharacterScreen.genderSelected = false
	screens.createCharacterScreen.professionSelected = false
	screens.createCharacterScreen.professionSelected = false
	screens.createCharacterScreen.beginVisible = false

	--setup the viewport and layer
	screens.createCharacterScreen.viewports.viewport = MOAIViewport.new()
	screens.createCharacterScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.createCharacterScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.createCharacterScreen.layers.layer = MOAILayer2D.new()
	screens.createCharacterScreen.layers.layer:setViewport(screens.createCharacterScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.createCharacterScreen.layers.layer)

	--setup sprites
	local checkBoxWidth = 50
	sharedGfxQuads:setRect(sharedNames["checkBoxUnchecked.png"], checkBoxWidth / 2 * -1, checkBoxWidth / 2 * -1, checkBoxWidth / 2, checkBoxWidth / 2)
	sharedGfxQuads:setRect(sharedNames["checkBoxChecked.png"], checkBoxWidth / 2 * -1, checkBoxWidth / 2 * -1, checkBoxWidth / 2, checkBoxWidth / 2)
	
	--setup clickable prop list
	screens.createCharacterScreen.clickablePropList = screenUtil.getClickablePropList()
	--setup button list
	screens.createCharacterScreen.buttonList = screenUtil.getButtonList()
	
	--draw the title
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		0, -- centerX
		SCREEN_UNITS_Y / 2 - 50, -- centerY
		500, -- width
		30, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.title)
	
	--add the back button
	screens.createCharacterScreen.props.backButtonProp = screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 * -1 + 50, -- centerX
		SCREEN_UNITS_Y / 2 - 65, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.general.back)
	screens.createCharacterScreen.props.backButtonPressedProp = screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 * -1 + 50, -- centerX
		SCREEN_UNITS_Y / 2 - 65, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		.6, .6, .6, 1, -- color r g b a 
		textLookup.general.back)
	screens.createCharacterScreen.props.backButtonPressedProp:setVisible(false)
	screens.createCharacterScreen.buttonList:addButton("back", screens.createCharacterScreen.props.backButtonProp, screens.createCharacterScreen.props.backButtonPressedProp)

	--add the begin button
	screens.createCharacterScreen.props.beginButtonProp = screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 - 50, -- centerX
		SCREEN_UNITS_Y / 2 - 65, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.begin)
	screens.createCharacterScreen.props.beginButtonProp:setVisible(false)
	screens.createCharacterScreen.props.beginButtonPressedProp = screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 - 50, -- centerX
		SCREEN_UNITS_Y / 2 - 65, -- centerY
		150, -- width
		80, -- height
		fonts.grStylusFont,
		MOAITextBox.CENTER_JUSTIFY,
		MOAITextBox.LEFT_JUSTIFY,
		30, -- fontSize
		.6, .6, .6, 1, -- color r g b a 
		textLookup.createCharacterScreen.begin)
	screens.createCharacterScreen.props.beginButtonPressedProp:setVisible(false)
--	screens.createCharacterScreen.buttonList:addButton("begin", screens.createCharacterScreen.props.beginButtonProp, screens.createCharacterScreen.props.beginButtonPressedProp)

	--draw the horizontal rule under the title
	local function drawHorizontalRule(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(111/255, 111/255, 111/255)
		MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	end
	local hrDeck = MOAIScriptDeck.new()
	hrDeck:setRect(SCREEN_UNITS_X / 2 * -1, 1, SCREEN_UNITS_X / 2, -2)
	hrDeck:setDrawCallback(drawHorizontalRule)
	local hrProp = MOAIProp2D.new()
	hrProp:setDeck(hrDeck)
	hrProp:setLoc(0,SCREEN_UNITS_Y / 2 - 70)
	screens.createCharacterScreen.layers.layer:insertProp(hrProp)

	local leftX = SCREEN_UNITS_X / 2 * -1 + 60
--	--draw the name field
--	local nameY = SCREEN_UNITS_Y / 2 - 100
--	screenUtil.addTextBox(
--		screens.createCharacterScreen.layers.layer,
--		leftX, -- centerX
--		nameY, -- centerY
--		100, -- width
--		25, -- height
--		fonts.grStylusFont,
--		MOAITextBox.LEFT_JUSTIFY,
--		MOAITextBox.CENTER_JUSTIFY,
--		25, -- fontSize
--		1, 1, 1, 1, -- color r g b a 
--		textLookup.createCharacterScreen.name)
--	--TEXT BOX

	--draw the gender field
	local genderY = SCREEN_UNITS_Y / 2 - 150 
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX, -- centerX
		genderY, -- centerY
		100, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.gender)
	--unchecked
	screens.createCharacterScreen.props.unCheckedMaleProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedMaleProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedMaleProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedMaleProp:setLoc(SCREEN_UNITS_X / 2 * -1 + 130, genderY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedMaleProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.GENDER_MALE, screens.createCharacterScreen.props.unCheckedMaleProp)
	--checked
	screens.createCharacterScreen.props.checkedMaleProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedMaleProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedMaleProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedMaleProp:setLoc(SCREEN_UNITS_X / 2 * -1 + 130, genderY)
	screens.createCharacterScreen.props.checkedMaleProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedMaleProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 * -1 + 205, -- centerX
		genderY, -- centerY
		100, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.male)
	--unchecked
	screens.createCharacterScreen.props.unCheckedFemaleProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedFemaleProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedFemaleProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedFemaleProp:setLoc(SCREEN_UNITS_X / 2 * -1 + 260, genderY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedFemaleProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.GENDER_FEMALE, screens.createCharacterScreen.props.unCheckedFemaleProp)
	--checked
	screens.createCharacterScreen.props.checkedFemaleProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedFemaleProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedFemaleProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedFemaleProp:setLoc(SCREEN_UNITS_X / 2 * -1 + 260, genderY)
	screens.createCharacterScreen.props.checkedFemaleProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedFemaleProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		SCREEN_UNITS_X / 2 * -1 + 335, -- centerX
		genderY, -- centerY
		100, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.female)

--	--draw the ship name field
--	local shipNameY = SCREEN_UNITS_Y / 2 - 200
--	screenUtil.addTextBox(
--		screens.createCharacterScreen.layers.layer,
--		leftX + 25, -- centerX
--		shipNameY, -- centerY
--		150, -- width
--		25, -- height
--		fonts.grStylusFont,
--		MOAITextBox.LEFT_JUSTIFY,
--		MOAITextBox.CENTER_JUSTIFY,
--		25, -- fontSize
--		1, 1, 1, 1, -- color r g b a 
--		textLookup.createCharacterScreen.shipName)
--	--TEXT BOX

	--draw the profession header
	local professionY = SCREEN_UNITS_Y / 2 - 250 
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 15, -- centerX
		professionY, -- centerY
		130, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.profession)

	--draw the diplomat
	local diplomatY = SCREEN_UNITS_Y / 2 - 300 
	--unchecked
	screens.createCharacterScreen.props.unCheckedDiplomatProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedDiplomatProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedDiplomatProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedDiplomatProp:setLoc(leftX-20, diplomatY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedDiplomatProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.PROFESSION_DIPLOMAT, screens.createCharacterScreen.props.unCheckedDiplomatProp)
	--checked
	screens.createCharacterScreen.props.checkedDiplomatProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedDiplomatProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedDiplomatProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedDiplomatProp:setLoc(leftX-20, diplomatY)
	screens.createCharacterScreen.props.checkedDiplomatProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedDiplomatProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 260, -- centerX
		diplomatY, -- centerY
		500, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.diplomat)

	--draw the doctor
	local doctorY = SCREEN_UNITS_Y / 2 - 350 
	--unchecked
	screens.createCharacterScreen.props.unCheckedDoctorProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedDoctorProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedDoctorProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedDoctorProp:setLoc(leftX-20, doctorY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedDoctorProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.PROFESSION_DOCTOR, screens.createCharacterScreen.props.unCheckedDoctorProp)
	--checked
	screens.createCharacterScreen.props.checkedDoctorProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedDoctorProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedDoctorProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedDoctorProp:setLoc(leftX-20, doctorY)
	screens.createCharacterScreen.props.checkedDoctorProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedDoctorProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 460, -- centerX
		doctorY, -- centerY
		900, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.doctor)

	--draw the engineer
	local engineerY = SCREEN_UNITS_Y / 2 - 400 
	--unchecked
	screens.createCharacterScreen.props.unCheckedEngineerProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedEngineerProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedEngineerProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedEngineerProp:setLoc(leftX-20, engineerY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedEngineerProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.PROFESSION_ENGINEER, screens.createCharacterScreen.props.unCheckedEngineerProp)
	--checked
	screens.createCharacterScreen.props.checkedEngineerProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedEngineerProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedEngineerProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedEngineerProp:setLoc(leftX-20, engineerY)
	screens.createCharacterScreen.props.checkedEngineerProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedEngineerProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 260, -- centerX
		engineerY, -- centerY
		500, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.engineer)

	--draw the pilot
	local pilotY = SCREEN_UNITS_Y / 2 - 450 
	--unchecked
	screens.createCharacterScreen.props.unCheckedPilotProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedPilotProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedPilotProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedPilotProp:setLoc(leftX-20, pilotY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedPilotProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.PROFESSION_PILOT, screens.createCharacterScreen.props.unCheckedPilotProp)
	--checked
	screens.createCharacterScreen.props.checkedPilotProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedPilotProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedPilotProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedPilotProp:setLoc(leftX-20, pilotY)
	screens.createCharacterScreen.props.checkedPilotProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedPilotProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 260, -- centerX
		pilotY, -- centerY
		500, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.pilot)

	--draw the soldier
	local soldierY = SCREEN_UNITS_Y / 2 - 500
	--unchecked 
	screens.createCharacterScreen.props.unCheckedSoldierProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.unCheckedSoldierProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.unCheckedSoldierProp:setIndex(sharedNames["checkBoxUnchecked.png"])
	screens.createCharacterScreen.props.unCheckedSoldierProp:setLoc(leftX-20, soldierY)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.unCheckedSoldierProp)
	screens.createCharacterScreen.clickablePropList:addClickableProp(screens.createCharacterScreen.PROFESSION_SOLDIER, screens.createCharacterScreen.props.unCheckedSoldierProp)
	--checked
	screens.createCharacterScreen.props.checkedSoldierProp = MOAIProp2D.new()
	screens.createCharacterScreen.props.checkedSoldierProp:setDeck(sharedGfxQuads)
	screens.createCharacterScreen.props.checkedSoldierProp:setIndex(sharedNames["checkBoxChecked.png"])
	screens.createCharacterScreen.props.checkedSoldierProp:setLoc(leftX-20, soldierY)
	screens.createCharacterScreen.props.checkedSoldierProp:setVisible(false)
	screens.createCharacterScreen.layers.layer:insertProp(screens.createCharacterScreen.props.checkedSoldierProp)
	screenUtil.addTextBox(
		screens.createCharacterScreen.layers.layer,
		leftX + 260, -- centerX
		soldierY, -- centerY
		500, -- width
		25, -- height
		fonts.grStylusFont,
		MOAITextBox.LEFT_JUSTIFY,
		MOAITextBox.CENTER_JUSTIFY,
		25, -- fontSize
		1, 1, 1, 1, -- color r g b a 
		textLookup.createCharacterScreen.soldier)


	--setup the controller callbacks
	if MOAIInputMgr.device.pointer then
		-- mouse input
		MOAIInputMgr.device.pointer:setCallback(screens.createCharacterScreen.pointerCallback)
		MOAIInputMgr.device.mouseLeft:setCallback(screens.createCharacterScreen.clickCallback)
	else
		-- touch input
		MOAIInputMgr.device.touch:setCallback ( 
			function(eventType, idx, x, y, tapCount)
				screens.createCharacterScreen.pointerCallback(x, y)
				if eventType == MOAITouchSensor.TOUCH_DOWN then
					screens.createCharacterScreen.clickCallback(true)
				elseif eventType == MOAITouchSensor.TOUCH_UP then
					screens.createCharacterScreen.clickCallback(false)
				end
			end
		)
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.createCharacterScreen.destroy()
	screens.createCharacterScreen.clickablePropList = nil
	screens.createCharacterScreen.buttonList = nil
	--destroy the props
	for key, value in pairs(screens.createCharacterScreen.props) do
		screens.createCharacterScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.createCharacterScreen.layers) do
		if screens.createCharacterScreen.layers[key] ~= nil then
			screens.createCharacterScreen.layers[key]:clear()
			screens.createCharacterScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.createCharacterScreen.viewports) do
		screens.createCharacterScreen.viewports[key] = nil
	end
end

