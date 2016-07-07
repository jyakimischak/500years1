--####################################
-- scanArtemis.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for Charlie scans the Artemis colony.
--####################################

--namespace model.cutScenes


function model.cutScenes.scanArtemis()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.OUTRO)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = outroGfxQuads, outroNames
			screens.cutSceneScreen.sceneIndex = "noHumansLeft.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Charlie scans the Artemis Colony.")
			screens.cutSceneScreen.captions:add("She finds no human life present.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
