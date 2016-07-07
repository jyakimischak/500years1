--####################################
-- francisDead.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when the crew find out that Francis was eaten.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--francisDead
--------------------------------------------------------------------------
function model.cutScenes.francisDead()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The crew gathers together on your ship.")
			screens.cutSceneScreen.captions:add("Jarvis is carrying a tray of sandwiches that he is eating from...")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
