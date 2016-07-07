--####################################
-- combatTutorial.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene that teaches you how to play the fights
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--howToNavigate
--------------------------------------------------------------------------
function model.cutScenes.combatTutorial()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.TUTORIAL)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = tutorialGfxQuads, tutorialNames
			screens.cutSceneScreen.sceneIndex = "loadout.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Before a battle begins you have the opportunity to change your ships loadout.")
			screens.cutSceneScreen.captions:add("You should change your loadout to work best against the enemy you are facing.")
			screens.cutSceneScreen.captions:add("All items have 3 levels that take away energy from your pool.")
			screens.cutSceneScreen.captions:add("Balance the items you want based on the amount of energy you currently have.")
			screens.cutSceneScreen.captions:add("Weapons of each level have a long, medium and short range option.")
			screens.cutSceneScreen.captions:add("The long range weapons have a lower firing rate and smaller firing arc.")
			screens.cutSceneScreen.captions:add("Engines determine the speed your ship can move at.")
			screens.cutSceneScreen.captions:add("Computers will change your firing accuracy.")
			screens.cutSceneScreen.captions:add("Computers also change your ships defences, making you harder to hit.")
			screens.cutSceneScreen.captions:add("The shields level will increase the amount of damage that you can take.")
			screens.cutSceneScreen.captions:add("A hard hit can also punch through shields.")
			screens.cutSceneScreen.captions:add("Higher level shields are more difficult to punch through.")
			screens.cutSceneScreen.captions:add("Shields will regenerate after 5 seconds if you are not hit.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "battle.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("You ship appears in the center of the battle screen.")
			screens.cutSceneScreen.captions:add("Your health (red) and shields (blue) are at the top.")
			screens.cutSceneScreen.captions:add("A reticle surrounds your current target, face your target to fire on it.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "move.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The left control changes your direction.")
			screens.cutSceneScreen.captions:add("The right control rotates your ship.")
			screens.cutSceneScreen.captions:add("You will move faster going forward.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "select.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The arrows will cycle through the enemies.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "closest.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The down arrow will target the closest enemy.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "zoom.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The plus sign will change the zoom level.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end


			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
