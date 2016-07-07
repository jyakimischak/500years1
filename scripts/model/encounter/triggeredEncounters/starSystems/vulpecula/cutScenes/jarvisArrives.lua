--####################################
-- jarvisArrives.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when Jarvis arrives on your ship.
--####################################

--namespace model.cutScenes


--------------------------------------------------------------------------
--jarvisArrives
--this will be played when Jarvis arrives on the ship
--------------------------------------------------------------------------
function model.cutScenes.jarvisArrives()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("The Takataka ambassador Jarvis arrives on the ship alone.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
