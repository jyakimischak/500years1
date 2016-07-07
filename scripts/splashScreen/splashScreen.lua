--####################################
-- splashScreen.lua
-- author: Jonas Yakimischak
--
-- This is the splash screen for the game.
--####################################

--namespace screens.splashScreen

screens.splashScreen.props = {}
screens.splashScreen.viewports = {}
screens.splashScreen.layers = {}

screens.splashScreen.MOAI = "moaiattribution.png"
screens.splashScreen.POORWILL = "poorWillLogo.png"
screens.splashScreen.DIM_LIGHT = "dimLight"
screens.splashScreen.splashImage = screens.splashScreen.MOAI

screens.splashScreen.startColor = .1 

--------------------------------------------------------------------------
-- display
--------------------------------------------------------------------------
function screens.splashScreen.display()
	--size the image props
	if screens.splashScreen.splashImagesSized == nil or not screens.splashScreen.splashImagesSized then
		local moaiWidth = 500
		local moaiHeight = 450 * moaiWidth / 1024
		splashGfxQuads:setRect(splashNames[screens.splashScreen.MOAI], moaiWidth / 2 * -1, moaiHeight / 2 * -1, moaiWidth / 2, moaiHeight / 2)
		local poorwillWidth = 500
		local poorwillHeight = 555 * poorwillWidth / 1002  
		splashGfxQuads:setRect(splashNames[screens.splashScreen.POORWILL], poorwillWidth / 2 * -1, poorwillHeight / 2 * -1, poorwillWidth / 2, poorwillHeight / 2)
		
	end

	--setup the viewport and layer
	screens.splashScreen.viewports.viewport = MOAIViewport.new()
	screens.splashScreen.viewports.viewport:setSize(SCREEN_X_MIN, SCREEN_Y_MIN, SCREEN_X_MAX, SCREEN_Y_MAX)
	screens.splashScreen.viewports.viewport:setScale(SCREEN_UNITS_X, SCREEN_UNITS_Y)
	screens.splashScreen.layers.layer = MOAILayer2D.new()
	screens.splashScreen.layers.layer:setViewport(screens.splashScreen.viewports.viewport)
	MOAISim.pushRenderPass(screens.splashScreen.layers.layer)

	--setup sprites
	if screens.splashScreen.splashImage == screens.splashScreen.DIM_LIGHT then
		screens.splashScreen.props.splashProp = screenUtil.addTextBox(
			screens.splashScreen.layers.layer,
			0, -- centerX
			0, -- centerY
			SCREEN_UNITS_Y, -- width
			100, -- height
			fonts.grStylusFont,
			MOAITextBox.CENTER_JUSTIFY,
			MOAITextBox.CENTER_JUSTIFY,
			50, -- fontSize
			1, 1, 1, 1, -- color r g b a 
			textLookup.splashScreen.dimLight)
	else
		screens.splashScreen.props.splashProp = MOAIProp2D.new()
		screens.splashScreen.props.splashProp:setDeck(splashGfxQuads)
		screens.splashScreen.props.splashProp:setIndex(splashNames[screens.splashScreen.splashImage])
		screens.splashScreen.props.splashProp:setLoc(0, 0)
		screens.splashScreen.props.splashProp:setColor(screens.splashScreen.startColor, screens.splashScreen.startColor, screens.splashScreen.startColor)
		screens.splashScreen.layers.layer:insertProp(screens.splashScreen.props.splashProp)
	end
end


--------------------------------------------------------------------------
-- destroy
--------------------------------------------------------------------------
function screens.splashScreen.destroy()
	--destroy the props
	for key, value in pairs(screens.splashScreen.props) do
		screens.splashScreen.props[key] = nil
	end
	--destroy the layers
	for key, value in pairs(screens.splashScreen.layers) do
		if screens.splashScreen.layers[key] ~= nil then
			screens.splashScreen.layers[key]:clear()
			screens.splashScreen.layers[key] = nil
		end
	end
	--destroy the viewports
	for key, value in pairs(screens.splashScreen.viewports) do
		screens.splashScreen.viewports[key] = nil
	end
end


