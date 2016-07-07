--####################################
-- artemisDeserted.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene landing at the deserted artemis colony.
--####################################

--namespace model.cutScenes


function model.cutScenes.artemisDeserted()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.OUTRO)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = outroGfxQuads, outroNames
			screens.cutSceneScreen.sceneIndex = "colonyDeserted.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The ship lands at the Artemis colony.")
			screens.cutSceneScreen.captions:add("You find no one there.")
			screens.cutSceneScreen.captions:add("It looks like everyone left in a hurry.")
			screens.cutSceneScreen.captions:add("Personal items were left behind.")
			screens.cutSceneScreen.captions:add("Doors open, livestock roaming free.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
