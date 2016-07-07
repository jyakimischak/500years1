--####################################
-- frontController.lua
-- author: Jonas Yakimischak
--
-- This is the front controller for the game.  Handles dispatching to screens.
--####################################

--namespace frontController


--------------------------------------------------------------------------
--screens
--the values should match the screen namespace names
--------------------------------------------------------------------------
frontController.START_SCREEN = "startScreen"
frontController.CREATE_CHARACTER_SCREEN = "createCharacterScreen"
frontController.STAR_MAP_SCREEN = "starMapScreen"
frontController.SOLAR_SYSTEM_SCREEN = "solarSystemScreen"
frontController.PLANET_SCREEN = "planetScreen"
frontController.OPTIONS_SCREEN = "optionsScreen"
frontController.CREW_LIST_SCREEN = "crewListScreen"
frontController.CREW_DETAILS_SCREEN = "crewDetailsScreen"
frontController.LOADOUT_SCREEN = "loadoutScreen"
frontController.DIALOG_SCREEN = "dialogScreen"
frontController.LOG_SCREEN = "logScreen"
frontController.CUT_SCENE_SCREEN = "cutSceneScreen"
frontController.SAVE_SCREEN = "saveScreen"
frontController.SAVE_CONFIRM_SCREEN = "saveConfirmScreen"
frontController.LOAD_SCREEN = "loadScreen"
frontController.LOAD_CONFIRM_SCREEN = "loadConfirmScreen"
frontController.QUIT_CONFIRM_SCREEN = "quitConfirmScreen"
frontController.PREPARE_BATTLE_SCREEN = "prepareBattleScreen"
if useFakeBattles then
	frontController.BATTLE_SCREEN = "fakeBattleScreen"
else
	frontController.BATTLE_SCREEN = "battleScreen"
end
frontController.DEFEAT_SCREEN = "defeatScreen"
frontController.VICTORY_SCREEN = "victoryScreen"
frontController.SPLASH_SCREEN = "splashScreen"
frontController.CREDITS_SCREEN = "creditsScreen"


--The current screen that we're on...default to the start screen
frontController.currentScreen = frontController.START_SCREEN 


--------------------------------------------------------------------------
-- dispatch
--
-- This will send the user to the given screen and clean up the screen stored in frontController.currentScreen
--------------------------------------------------------------------------
function frontController.dispatch(screen)
	--clean up the current screen
	if windowsBuild then
		xbox.setCallback(nil)
	end
	if MOAIInputMgr.device.pointer then
		MOAIInputMgr.device.pointer:setCallback(nil)
		MOAIInputMgr.device.mouseLeft:setCallback(nil)
	else
		MOAIInputMgr.device.touch:setCallback()
	end
	screens[frontController.currentScreen].destroy()
	MOAISim.forceGarbageCollection()
	
	--set the current screen
	frontController.currentScreen = screen
print("screen "..screen)
	--display the new screen
	screens[screen].display()
end



