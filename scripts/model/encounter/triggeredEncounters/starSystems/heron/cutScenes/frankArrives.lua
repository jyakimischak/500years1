--####################################
-- frankArrives.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when Frank arrives on your ship.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--frankArrives
--------------------------------------------------------------------------
function model.cutScenes.frankArrives()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("Frank arrives on the ship and the egg is trembling...")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
