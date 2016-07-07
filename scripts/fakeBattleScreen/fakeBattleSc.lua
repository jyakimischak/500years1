--####################################
-- fakeBattleSc.lua
-- author: Jonas Yakimischak
--
-- This is the screen controller for a battle.
--####################################

--namespace screens.fakeBattleScreen

screens.fakeBattleScreen.pointerX = 0
screens.fakeBattleScreen.pointerY = 0

--------------------------------------------------------------------------
-- pointerCallback
--
-- Callback function for the pointer
--------------------------------------------------------------------------
function screens.fakeBattleScreen.pointerCallback(x, y)
	if windowsBuild then
		xbox.mouseMoved(screens.fakeBattleScreen.pointerX, x, screens.fakeBattleScreen.pointerY, y)
	end

	screens.fakeBattleScreen.pointerX, screens.fakeBattleScreen.pointerY = x, y 
end


--------------------------------------------------------------------------
-- clickCallback
--
-- Callback function for a click
--------------------------------------------------------------------------
function screens.fakeBattleScreen.clickCallback(down)
	if not down then
		--for now just set the battle to be a victory if they player touches the screen.
		battle.currentBattle.complete = true
	end
end
