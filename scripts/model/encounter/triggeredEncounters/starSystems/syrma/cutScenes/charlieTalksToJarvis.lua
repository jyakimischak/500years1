--####################################
-- charlieTalksToJarvis.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when Charlie gets the coordinates from Jarvis.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--charlieTalksToJarvis
--------------------------------------------------------------------------
function model.cutScenes.charlieTalksToJarvis()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("20 minutes later...")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
