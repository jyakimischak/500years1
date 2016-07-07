--####################################
-- planetIsMoved.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when the Ungiri move the Malvar homeworld.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--planetIsMoved
--------------------------------------------------------------------------
function model.cutScenes.planetIsMoved()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The Ungiri move the Malvar homeworld toward its sun.")
			screens.cutSceneScreen.captions:add("Two weeks later the planet is in its resting place and much of the ice has melted.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
