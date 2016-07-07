--####################################
-- antaresShoreLeave.lua
-- author: Jonas Yakimischak
--
-- This holds the cut scene for when you are on shore leave.
--####################################

--namespace model.cutScenes


function model.cutScenes.antaresShoreLeave()
	model.cutScenes.complete = false
	local cutSceneThread = MOAICoroutine.new ()
	cutSceneThread:run (
		function()
			screens.cutSceneScreen.gfxQuads, screens.cutSceneScreen.names = nil, nil
			screens.cutSceneScreen.sceneIndex = nil
			screens.cutSceneScreen.captions = util.getArrayList()
			screens.cutSceneScreen.captions:add("You land at the Antares colony and are met with some celebration.")
			screens.cutSceneScreen.captions:add("You spend two weeks at the colony learning about the people and enjoying yourself.")
			screens.cutSceneScreen.captions:add("It is the first time you've felt safe, surrounded by fellow humans.")
			screens.cutSceneScreen.captions:add("After you're relaxed the Magistrate sees you off on your journey back to Artemis.")
			frontController.dispatch(frontController.CUT_SCENE_SCREEN)
			while not screens.cutSceneScreen.sceneComplete do
				coroutine.yield()
			end

			model.cutScenes.complete = true
		end
	)
end
