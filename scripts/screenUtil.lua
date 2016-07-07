--####################################
-- screenUtil.lua
-- author: Jonas Yakimischak
--
-- Helper functions for screens.
--####################################

--namespace screenUtil



--------------------------------------------------------------------------
-- addTextBox
--
-- This will add a text box to the screen.
-- This returns the textbox prop in case it's needed.
--------------------------------------------------------------------------
function screenUtil.addTextBox(layer, centerX, centerY, width, height, font, alignmentH, alignmentV, textSize, r, g, b, a, text)
	local style = MOAITextStyle.new()
	style:setSize(textSize)
	style:setColor(r, g, b, a)
	style:setFont(font)
	local textBox = MOAITextBox.new()
	textBox:setStyle(style)
	textBox:setString(text)
	textBox:setRect(centerX - width / 2, centerY - height / 2, centerX + width / 2, centerY + height / 2)
	textBox:setAlignment(alignmentH, alignmentV)
	textBox:setYFlip(true)
	layer:insertProp(textBox)
	return textBox
end


--------------------------------------------------------------------------
-- getClickablePropList
--
-- This will return a clickablePropList object.
--------------------------------------------------------------------------
function screenUtil.getClickablePropList(selectedProp)
	local clickablePropList = util.getArrayList()
	clickablePropList.selectedProp = selectedProp
	
	--------------------------------------------------------------------------
	-- addClickableProp
	--
	-- This will add a prop to the clickablePropList
	--------------------------------------------------------------------------
	function clickablePropList:addClickableProp(name, prop, selectedXOffset, selectedYOffset)
		local clickableProp = {}
		clickableProp.name = name
		clickableProp.prop = prop
		clickableProp.down = false
		if selectedXOffset then
			clickableProp.selectedXOffset = selectedXOffset
		else
			clickableProp.selectedXOffset = 0
		end
		if selectedYOffset then
			clickableProp.selectedYOffset = selectedYOffset
		else
			clickableProp.selectedYOffset = 0
		end
		if clickablePropList.length == 0 then
			clickableProp.selected = true
		else
			clickableProp.selected = false
		end
 		self:add(clickableProp)
	end


	--------------------------------------------------------------------------
	-- click
	--
	-- This will handle a click on the prop..if a prop was click it will return the prop's name.
	--------------------------------------------------------------------------
	function clickablePropList:click(x, y, down)
		if self.length > 0 then
			for i = 1, self.length do
				if down then
					if self[i].prop:inside(x, y) and not self[i].down then
						self[i].down = true
					end
				else
					if self[i].down then
						self[i].down = false
						if self[i].prop:inside(x, y) then
--							audioUtil.playSound("click")
							return self[i].name
						end
					end
				end
			end
		end
	end
	
	--------------------------------------------------------------------------
	-- pointer
	--
	-- This will handle the pointer callback operations for the clickablePropList.
	--------------------------------------------------------------------------
	function clickablePropList:pointer(x, y)
		if not windowsBuild then
			return
		end
		if not xbox.cursorVisible then
			return
		end
		if self.length > 0 then
			for i = 1, self.length do
				if self[i].prop:inside(x, y) then
					cursorHover = true
					break
				end
			end
		end 
	end

	
	--------------------------------------------------------------------------
	-- This will return the name of the selected prop
	--------------------------------------------------------------------------
	function clickablePropList:getSelected()
		for i = 1, self.length do
			if self[i].selected then
				return self[i].name
			end
		end
		return ""
	end
	
	--------------------------------------------------------------------------
	-- show or hide the selected prop
	--------------------------------------------------------------------------
	function clickablePropList:selectedVisible(isVisible)
		if self.selectedProp ~= nil then
			for i = 1, self.length do
				if self[i].selected then
					local x, y = self[i].prop:getLoc()
					self.selectedProp:setLoc(x + self[i].selectedXOffset, y + self[i].selectedYOffset)
					self.selectedProp:setVisible(isVisible)
					break
				end
			end
		end
	end
	
	--------------------------------------------------------------------------
	-- select the next prop in the list, if we are at the end of the list then stay put
	--------------------------------------------------------------------------
	function clickablePropList:selectNext()
		for i = 1, self.length do
			if self[i].selected then
				if i < self.length then
					self[i].selected = false
					self[i+1].selected = true
					break
				end
			end
		end
	end

	--------------------------------------------------------------------------
	-- select the previous prop in the list, if we are at the start of the list then stay put
	--------------------------------------------------------------------------
	function clickablePropList:selectPrev()
		for i = 1, self.length do
			if self[i].selected then
				if i > 1 then
					self[i].selected = false
					self[i-1].selected = true
					break
				end
			end
		end
	end

	--------------------------------------------------------------------------
	-- Sets the selected prop based on the name
	--------------------------------------------------------------------------
	function clickablePropList:setSelected(name)
		for i = 1, self.length do
			if self[i].name == name then
				self[i].selected = true
			else
				self[i].selected = false
			end
		end
	end
	
	return clickablePropList;
end


--------------------------------------------------------------------------
-- getButtonList
--
-- This will return a buttonList object.
--------------------------------------------------------------------------
function screenUtil.getButtonList(selectedProp, selectedXOffset, selectedYOffset)
	local buttonList = util.getArrayList()
	buttonList.selectedProp = selectedProp
	if selectedXOffset == nil then
		buttonList.selectedXOffset = 0
	else
		buttonList.selectedXOffset = selectedXOffset
	end
	if selectedYOffset == nil then
		buttonList.selectedYOffset = 0
	else
		buttonList.selectedYOffset = selectedYOffset
	end
	
	--------------------------------------------------------------------------
	-- addButton
	--
	-- This will add a button to the buttonList
	--------------------------------------------------------------------------
	function buttonList:addButton(name, prop, pressedProp, x, y)
		local button = {}
		button.name = name
		button.prop = prop
		button.pressedProp = pressedProp
		button.down = false
		if buttonList.length == 0 then
			button.selected = true
		else
			button.selected = false
		end
		if x ~= nil then
			button.x = x
			button.y = y
		end
 		self:add(button)
	end


	--------------------------------------------------------------------------
	-- click
	--
	-- This will handle a click on the button..if a button was click it will return the buttons name.
	--------------------------------------------------------------------------
	function buttonList:click(x, y, down)
		if self.length > 0 then
			for i = 1, self.length do
				if down then
					if self[i].prop:inside(x, y) and not self[i].down then
						self[i].prop:setVisible(false)
						self[i].pressedProp:setVisible(true)
						self[i].down = true
					end
				else
					if self[i].down then
						self[i].down = false
						self[i].prop:setVisible(true)
						self[i].pressedProp:setVisible(false)
						if self[i].prop:inside(x, y) then
--							audioUtil.playSound("click")
							return self[i].name
						end
					end
				end
			end
		end
	end


	--------------------------------------------------------------------------
	-- pointer
	--
	-- This will handle the pointer callback operations for the buttonList.
	--------------------------------------------------------------------------
	function buttonList:pointer(x, y)
		if self.length > 0 then
			for i = 1, self.length do
				if windowsBuild then
					if self[i].prop:inside(x, y) then
						cursorHover = true
					end
				end
				if self[i].down then
					if self[i].prop:inside(x, y) then
						self[i].prop:setVisible(false)
						self[i].pressedProp:setVisible(true)
					else
						self[i].prop:setVisible(true)
						self[i].pressedProp:setVisible(false)
					end
				end
			end
		end 
	end
	
	--------------------------------------------------------------------------
	-- This will return the name of the selected button
	--------------------------------------------------------------------------
	function buttonList:getSelected()
		for i = 1, self.length do
			if self[i].selected then
				return self[i].name
			end
		end
		return ""
	end
	
	--------------------------------------------------------------------------
	-- show or hide the selected prop
	--------------------------------------------------------------------------
	function buttonList:selectedVisible(isVisible)
		if self.selectedProp ~= nil then
			for i = 1, self.length do
				if self[i].selected then
					local selectedX, selectedY
					if self[i].x == nil then
						selectedX, selectedY = self[i].prop:getLoc()
					else
						selectedX, selectedY = self[i].x, self[i].y
					end
					self.selectedProp:setLoc(selectedX + self.selectedXOffset, selectedY + self.selectedYOffset)
					self.selectedProp:setVisible(isVisible)
					break
				end
			end
		end
	end
	
	--------------------------------------------------------------------------
	-- select the next button in the list, if we are at the end of the list then stay put
	--------------------------------------------------------------------------
	function buttonList:selectNext()
		for i = 1, self.length do
			if self[i].selected then
				if i < self.length then
					self[i].selected = false
					self[i+1].selected = true
					break
				end
			end
		end
	end

	--------------------------------------------------------------------------
	-- select the previous button in the list, if we are at the start of the list then stay put
	--------------------------------------------------------------------------
	function buttonList:selectPrev()
		for i = 1, self.length do
			if self[i].selected then
				if i > 1 then
					self[i].selected = false
					self[i-1].selected = true
					break
				end
			end
		end
	end

	--------------------------------------------------------------------------
	-- Sets the selected button based on the name
	--------------------------------------------------------------------------
	function buttonList:setSelected(name)
		for i = 1, self.length do
			if self[i].name == name then
				self[i].selected = true
			else
				self[i].selected = false
			end
		end
	end
	
	return buttonList;
end


--------------------------------------------------------------------------
-- loadStarTextures
-- load up the decks for all of the star textures
--------------------------------------------------------------------------
function screenUtil.loadStarTextures()
	starTileSize = 500
	starsGfxQuads, starsNames = util.loadTexturePack("texturePacks/stars/starsPack.lua", "texturePacks/stars/starsPack.png")
	for key, value in pairs(starsNames) do
		starsGfxQuads:setRect(value, starTileSize / 2 * -1, starTileSize / 2 * -1, starTileSize / 2, starTileSize / 2)
	end
end

--------------------------------------------------------------------------
-- wait
-- wait for the given number of seconds
--------------------------------------------------------------------------
function screenUtil.wait(waitTime)
	local waitTimer = MOAITimer.new()
	waitTimer:setMode(MOAITimer.CONTINUE)
	waitTimer:start()
	local prevTime = waitTimer:getTime()
	local currTime = waitTimer:getTime()
	while currTime - prevTime < waitTime do
		coroutine.yield()
		currTime = waitTimer:getTime()
	end
	waitTimer:stop()		
end


--------------------------------------------------------------------------
-- fadeScreen
-- fade the screen over the given number of seconds
--------------------------------------------------------------------------
function screenUtil.fadeScreen(layer, fadeTime)
	local fadeAlpha = 0
	local function drawFade(index, xOff, yOff, xFlip, yFlip)
		MOAIGfxDevice.setPenColor(0, 0, 0, fadeAlpha)
		MOAIDraw.fillRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
	end
	local fadeDeck = MOAIScriptDeck.new()
	fadeDeck:setRect(SCREEN_UNITS_X / 2 * -1, SCREEN_UNITS_Y / 2 * -1, SCREEN_UNITS_X / 2, SCREEN_UNITS_Y / 2)
	fadeDeck:setDrawCallback(drawFade)
	local fadeProp = MOAIProp2D.new()
	fadeProp:setDeck(fadeDeck)
	fadeProp:setLoc(0, 0)
	fadeProp:setPriority(10000)
	layer:insertProp(fadeProp)
	local fadeTimer = MOAITimer.new()
	fadeTimer:setMode(MOAITimer.CONTINUE)
	fadeTimer:start()
	local prevTime = fadeTimer:getTime()
	local currTime = nil
	while fadeAlpha < 1 do
		coroutine.yield()
		currTime = fadeTimer:getTime()
		local delta = (currTime - prevTime) * 1
		if fadeAlpha + delta > 1 then
			fadeAlpha = 1
		else
			fadeAlpha = fadeAlpha + delta
		end
	end
	fadeTimer:stop()
end		















----------------------------------------------------------------------------
---- getTouchList
---- DEPRICATED
----
---- This will return a touchList object.
----------------------------------------------------------------------------
--function screenUtil.getTouchList()
--	local touchList = {}
--	touchList.count = 0
--	for i = 0, 9 do
--		touchList[i] = {}
--		touchList[i].down = false
--		touchList[i].x = 0
--		touchList[i].y = 0
--	end
--	
--	--------------------------------------------------------------------------
--	-- setDown
--	--
--	-- This will set a touch to down.
--	--------------------------------------------------------------------------
--	function touchList:setDown(idx)
--		self[idx].down = true
--		self.count = self.count + 1
--	end
--
--	--------------------------------------------------------------------------
--	-- setUp
--	--
--	-- This will set a touch to up.
--	--------------------------------------------------------------------------
--	function touchList:setUp(idx)
--		self[idx].down = false
--		self.count = self.count - 1
--	end
--
--	--------------------------------------------------------------------------
--	-- setLoc
--	--
--	-- This will set the touch location.
--	--------------------------------------------------------------------------
--	function touchList:setLoc(x, y, idx)
--		self[idx].x = x
--		self[idx].y = y
--	end
--
--	--------------------------------------------------------------------------
--	-- getTouches
--	--
--	-- This will get the set of touches that are down in index order.
--	--------------------------------------------------------------------------
--	function touchList:getTouches()
--		local touches = {}
--		local touchCount = 0
--		for i = 0, 9 do
--			if self[i].down then
--				touches[touchCount] = self[i]
--				touchCount = touchCount + 1
--			end
--		end
--		return touches
--	end
--	
--	return touchList
--end



