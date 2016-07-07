--####################################
-- main.lua
-- author: Jonas Yakimischak
--
-- This main script for the 500 years game.
--####################################

--MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_CELLS, 2, 1, 1, 1 )
--MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_PADDED_CELLS, 1, 0.5, 0.5, 0.5 )
--MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75 )

--set this to true if you would like to play with "fake" battles
useFakeBattles = false

showSplash = false

--default build is android
iosBuild = false

windowsBuild = true
fullScreen = false

--setup the namespaces
gameState = {}
frontController = {}
fonts = {}
screenUtil = {}
textLookup = {}
util = {}
audioUtil = {}
saveUtil = {}
model = {}
model.starMapLocations = {}
model.crew = {}
model.pcEquipment = {}
model.quests = {}
model.dialog = {}
model.encounter = {}
model.cutScenes = {}
screens = {}
screens.startScreen = {}
screens.createCharacterScreen = {}
screens.starMapScreen = {}
screens.solarSystemScreen = {}
screens.planetScreen = {}
screens.optionsScreen = {}
screens.crewListScreen = {}
screens.crewDetailsScreen = {}
screens.loadoutScreen = {}
screens.dialogScreen = {}
screens.logScreen = {}
screens.cutSceneScreen = {}
screens.battleScreen = {}
screens.fakeBattleScreen = {}
screens.saveScreen = {}
screens.saveConfirmScreen = {}
screens.loadScreen = {}
screens.loadConfirmScreen = {}
screens.quitConfirmScreen = {}
screens.creditsScreen = {}
screens.prepareBattleScreen = {}
screens.defeatScreen = {}
screens.victoryScreen = {}
screens.splashScreen = {}
battle = {}
ships = {}
distanceEmitters = {}
textureUtil = {}
xbox = {}

--import the scripts
require("scripts.fonts")
require("scripts.screenUtil")
require("scripts.textLookup.textLookup")
require("scripts.util")
require("scripts.audioUtil")
require("scripts.saveUtil")
require("scripts.gameState")
require("scripts.model.starMapLocations")
require("scripts.model.crew")
require("scripts.model.pcEquipment")
require("scripts.model.quests")
require("scripts.model.dialog")
require("scripts.model.encounter")
require("scripts.model.cutScenes")
require("scripts.frontController")
require("scripts.startScreen.startScreen")
require("scripts.startScreen.startSc")
require("scripts.createCharacterScreen.createCharacterScreen")
require("scripts.createCharacterScreen.createCharacterSc")
require("scripts.starMapScreen.starMapScreen")
require("scripts.starMapScreen.starMapSc")
require("scripts.solarSystemScreen.solarSystemScreen")
require("scripts.solarSystemScreen.solarSystemSc")
require("scripts.planetScreen.planetScreen")
require("scripts.planetScreen.planetSc")
require("scripts.optionsScreen.optionsScreen")
require("scripts.optionsScreen.optionsSc")
require("scripts.crewListScreen.crewListScreen")
require("scripts.crewListScreen.crewListSc")
require("scripts.crewDetailsScreen.crewDetailsScreen")
require("scripts.crewDetailsScreen.crewDetailsSc")
require("scripts.loadoutScreen.loadoutScreen")
require("scripts.loadoutScreen.loadoutSc")
require("scripts.dialogScreen.dialogScreen")
require("scripts.dialogScreen.dialogSc")
require("scripts.logScreen.logScreen")
require("scripts.logScreen.logSc")
require("scripts.cutSceneScreen.cutSceneScreen")
require("scripts.cutSceneScreen.cutSceneSc")
require("scripts.battleScreen.battleScreen")
require("scripts.battleScreen.battleSc")
require("scripts.fakeBattleScreen.fakeBattleScreen")
require("scripts.fakeBattleScreen.fakeBattleSc")
require("scripts.saveScreen.saveScreen")
require("scripts.saveScreen.saveSc")
require("scripts.saveConfirmScreen.saveConfirmScreen")
require("scripts.saveConfirmScreen.saveConfirmSc")
require("scripts.loadScreen.loadScreen")
require("scripts.loadScreen.loadSc")
require("scripts.loadConfirmScreen.loadConfirmScreen")
require("scripts.loadConfirmScreen.loadConfirmSc")
require("scripts.quitConfirmScreen.quitConfirmScreen")
require("scripts.quitConfirmScreen.quitConfirmSc")
require("scripts.creditsScreen.creditsScreen")
require("scripts.creditsScreen.creditsSc")
require("scripts.prepareBattleScreen.prepareBattleScreen")
require("scripts.prepareBattleScreen.prepareBattleSc")
require("scripts.defeatScreen.defeatScreen")
require("scripts.defeatScreen.defeatSc")
require("scripts.victoryScreen.victoryScreen")
require("scripts.splashScreen.splashScreen")
require("scripts.battle.battle")
require("scripts.battle.ships")
require("scripts.particles.distanceEmitters")
require("scripts.textureUtil")
require("scripts.xboxController")


------------------------------------------------------------------------------------------------------
--CONFIGURATION CONSTANTS
------------------------------------------------------------------------------------------------------
APP_NAME = "500 Years Act 1"

--setup the screen
if iosBuild then
	SCREEN_UNITS_X = 1024
	SCREEN_UNITS_Y = 768
	SCREEN_X_OFFSET = 0
	SCREEN_Y_OFFSET = 0
	DEVICE_WIDTH = MOAIEnvironment.horizontalResolution
	DEVICE_HEIGHT = MOAIEnvironment.verticalResolution
elseif windowsBuild then
	xbox.startController()
	SCREEN_UNITS_X = 1024
	SCREEN_UNITS_Y = 576
	SCREEN_X_OFFSET = 0
	SCREEN_Y_OFFSET = 0
	MOAISim.openWindow(APP_NAME, SCREEN_UNITS_X, SCREEN_UNITS_Y)
	if fullScreen then
		MOAISim.enterFullscreenMode()
		DEVICE_WIDTH = MOAIEnvironment.horizontalResolution
		DEVICE_HEIGHT = MOAIEnvironment.verticalResolution
	else
		DEVICE_WIDTH = SCREEN_UNITS_X
		DEVICE_HEIGHT = SCREEN_UNITS_Y
	end
	glut = MOAIGlut.new()
else
	SCREEN_UNITS_X = 1024
	SCREEN_UNITS_Y = 600
	SCREEN_X_OFFSET = 0
	SCREEN_Y_OFFSET = 0
	DEVICE_WIDTH = MOAIEnvironment.horizontalResolution
	DEVICE_HEIGHT = MOAIEnvironment.verticalResolution
end





if DEVICE_HEIGHT > DEVICE_WIDTH then
	tempDevice = DEVICE_HEIGHT
	DEVICE_HEIGHT = DEVICE_WIDTH
	DEVICE_WIDTH = tempDevice  
end

local gameAspect = SCREEN_UNITS_Y / SCREEN_UNITS_X
local realAspect = DEVICE_HEIGHT / DEVICE_WIDTH

	 if realAspect > gameAspect then
		SCREEN_WIDTH = DEVICE_WIDTH
		SCREEN_HEIGHT = DEVICE_WIDTH * gameAspect
	 else
		SCREEN_WIDTH = DEVICE_HEIGHT / gameAspect
		SCREEN_HEIGHT = DEVICE_HEIGHT
	 end
 
	 if SCREEN_WIDTH < DEVICE_WIDTH then
		SCREEN_X_OFFSET = ( DEVICE_WIDTH - SCREEN_WIDTH ) * 0.5
	 end
 
	 if SCREEN_HEIGHT < DEVICE_HEIGHT then
		SCREEN_Y_OFFSET = ( DEVICE_HEIGHT - SCREEN_HEIGHT ) * 0.5
	 end
SCREEN_X_MIN = SCREEN_X_OFFSET
SCREEN_X_MAX = SCREEN_X_OFFSET + SCREEN_WIDTH
SCREEN_Y_MIN = SCREEN_Y_OFFSET
SCREEN_Y_MAX = SCREEN_Y_OFFSET + SCREEN_HEIGHT

--print(SCREEN_X_MIN, SCREEN_X_MAX, SCREEN_Y_MIN, SCREEN_Y_MAX)
--SCREEN_X_MIN = 0
--SCREEN_X_MAX = 768
--SCREEN_Y_MIN = 112
--SCREEN_Y_MAX = 912

---------------------------------------------------------------------
--seed the random number generator
---------------------------------------------------------------------
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))

---------------------------------------------------------------------
--initialize the language to English
---------------------------------------------------------------------
textLookup.selectedLanguage = textLookup.ENGLISH
textLookup.initializeLanguage()

---------------------------------------------------------------------
--initialize the sound system
---------------------------------------------------------------------
MOAIUntzSystem.initialize(44100, 1000)

---------------------------------------------------------------------
--initialize the base directory
---------------------------------------------------------------------
if MOAIEnvironment.documentDirectory == nil then
	documentsDirectory = "."
else
	documentsDirectory = MOAIEnvironment.documentDirectory
end
print(documentsDirectory)


---------------------------------------------------------------------
--show the splash screens in an encounter
---------------------------------------------------------------------
--splashGfxQuads, splashNames = util.loadTexturePack("texturePacks/splash/splashPack.lua", "texturePacks/splash/splashPack.png")
textureUtil.loadPermTextures()
textureUtil.loadTextures(textureUtil.START)

if showSplash then
	splashScreenIntroComplete = false
	model.encounter.getTriggeredEncounter("splashScreen")
else
	splashScreenIntroComplete = true
end

---------------------------------------------------------------------
--load the textures
--NOW HANDLED BY textureUtil
---------------------------------------------------------------------
--sharedGfxQuads, sharedNames = util.loadTexturePack("texturePacks/shared/sharedPack.lua", "texturePacks/shared/sharedPack.png")
--sharedGfxQuads:setRect(sharedNames["bannerBackground.png"], -550, -35, 550, 35)
----sharedGfxQuads:setRect(sharedNames["starBackground.png"], -512, -300, 512, 300)
--sharedGfxQuads:setRect(sharedNames["starBackground.png"], -657, -385, 657, 385)
--model.starMapLocations.loadTextures()
--screenUtil.loadStarTextures()
--crewGfxQuads, crewNames = util.loadTexturePack("texturePacks/crew/crewPack.lua", "texturePacks/crew/crewPack.png")
--charactersGfxQuads, charactersNames = util.loadTexturePack("texturePacks/characters/charactersPack.lua", "texturePacks/characters/charactersPack.png")
--particlesGfxQuads, particlesNames = util.loadTexturePack("texturePacks/particles/particlesPack.lua", "texturePacks/particles/particlesPack.png")
--starMapGfxQuads, starMapNames = util.loadTexturePack("texturePacks/starMap/starMapPack.lua", "texturePacks/starMap/starMapPack.png")
--weaponsGfxQuads, weaponsNames = util.loadTexturePack("texturePacks/weapons/weaponsPack.lua", "texturePacks/weapons/weaponsPack.png")
--shipsGfxQuads, shipsNames = util.loadTexturePack("texturePacks/ships/shipsPack.lua", "texturePacks/ships/shipsPack.png")
--llaxonFighterGfxQuads, llaxonFighterNames = util.loadTexturePack("texturePacks/ships/llaxon/llaxonFighterPack.lua", "texturePacks/ships/llaxon/llaxonFighterPack.png")
--llaxonDestroyerGfxQuads, llaxonDestroyerNames = util.loadTexturePack("texturePacks/ships/llaxon/llaxonDestroyerPack.lua", "texturePacks/ships/llaxon/llaxonDestroyerPack.png")
--pirateGfxQuads, pirateNames = util.loadTexturePack("texturePacks/ships/pirate/piratePack.lua", "texturePacks/ships/pirate/piratePack.png")
--pirateDestroyerGfxQuads, pirateDestroyerNames = util.loadTexturePack("texturePacks/ships/pirate/pirateDestroyerPack.lua", "texturePacks/ships/pirate/pirateDestroyerPack.png")
--takatakaGfxQuads, takatakaNames = util.loadTexturePack("texturePacks/ships/takataka/takatakaPack.lua", "texturePacks/ships/takataka/takatakaPack.png")
--antHiveGfxQuads, antHiveNames = util.loadTexturePack("texturePacks/ships/ant/antHivePack.lua", "texturePacks/ships/ant/antHivePack.png")
--humanDestroyerGfxQuads, humanDestroyerNames = util.loadTexturePack("texturePacks/ships/human/humanDestroyerPack.lua", "texturePacks/ships/human/humanDestroyerPack.png")
--battleFields1GfxQuads, battleFields1Names = util.loadTexturePack("texturePacks/battleFields/battleFieldsPack1.lua", "texturePacks/battleFields/battleFieldsPack1.png")
--battleFields2GfxQuads, battleFields2Names = util.loadTexturePack("texturePacks/battleFields/battleFieldsPack2.lua", "texturePacks/battleFields/battleFieldsPack2.png")
--tutorialGfxQuads, tutorialNames = util.loadTexturePack("texturePacks/cutScenes/tutorial/tutorialPack.lua", "texturePacks/cutScenes/tutorial/tutorialPack.png")
--outroGfxQuads, outroNames = util.loadTexturePack("texturePacks/cutScenes/outro/outroPack.lua", "texturePacks/cutScenes/outro/outroPack.png")


---------------------------------------------------------------------
--Setup the Colors
---------------------------------------------------------------------
titleColorR = 150/255 
titleColorG = 150/255
titleColorB = 200/255
titleColorAlpha = 1

bannerButtonColorR = 150/255 
bannerButtonColorG = 150/255
bannerButtonColorB = 200/255
bannerButtonColorAlpha = 1
bannerButtonPressedColorR = 50/255
bannerButtonPressedColorG = 50/255
bannerButtonPressedColorB = 100/255
bannerButtonPressedColorAlpha = 1

bannerHRColorR = 0/255 
bannerHRColorG = 0/255
bannerHRColorB = 100/255

cursorHover = false

--------------------------------------------------------
-- Use to monitor memory usage
--local encounterThread = MOAICoroutine.new ()
--encounterThread:run (
--	function()
--		while(true) do
--			print("memory: ", MOAISim.getMemoryUsage().total/1024/1024)
--			coroutine.yield()
--		end
--	end
--);



--START THE GAME (assuming the splash screens are done)
model.encounter.getTriggeredEncounter("startGame")

--newGameState()
--gameState.shipTotalArmor = 1000000
--model.encounter.getTriggeredEncounter("llaxonTest")
