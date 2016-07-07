--####################################
-- howToNavigate.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene that teaches you how to play the game
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--howToNavigate
--------------------------------------------------------------------------
function model.cutScenes.howToNavigate()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.TUTORIAL)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = tutorialGfxQuads, tutorialNames
			screens.cutSceneScreen.sceneIndex = "navigation.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The star map screen allows you to move your ship between star systems.")
			screens.cutSceneScreen.captions:add("As you find the coordinates for new systems they will appear on your star map.")
			screens.cutSceneScreen.captions:add("Your ship will appear beside your current location.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "pinchTutorial.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Pinching the star map will cause it to zoom.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "goToStar.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Touch a star to visit the system.  ")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "goToMenu.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The top right button will take you to the game's menu.")
			screens.cutSceneScreen.captions:add("From the menu you can:")
			screens.cutSceneScreen.captions:add("Change your ships loadout for combat.")
			screens.cutSceneScreen.captions:add("Get information on your crew and speak with them.")
			screens.cutSceneScreen.captions:add("Save and load your game.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
