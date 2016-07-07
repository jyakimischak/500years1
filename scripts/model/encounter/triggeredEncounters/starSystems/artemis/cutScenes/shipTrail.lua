--####################################
-- shipTrail.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene when Charlie find a ship trail.
--####################################

--namespace model.cutScenes


function model.cutScenes.shipTrail()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			textureUtil.loadTextures(textureUtil.OUTRO)
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = outroGfxQuads, outroNames
			screens.cutSceneScreen.sceneIndex = "whereEvilHumans1.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Charlie uses the ships computers to scan the surrounding space.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			screens.cutSceneScreen.sceneIndex = "whereEvilHumans2.png"
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("She find a ships engine signatures leading to Antares.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			textureUtil.loadTextures(textureUtil.NON_COMBAT)
			model.cutScenes.complete = true
		end
	)
end
