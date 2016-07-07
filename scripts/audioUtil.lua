--####################################
-- audioUtil.lua
-- author: Jonas Yakimischak
--
-- Helper functions for audio.
--####################################

--namespace audioUtil

--------------------------------------------------------------------------
--Audio Globals.
--------------------------------------------------------------------------
audioUtil.musicFormat = "ogg"
audioUtil.musicVolume = 1
audioUtil.musicObj = MOAIUntzSound.new()

audioUtil.soundFormat = "wav"
audioUtil.soundVolume = .7


--------------------------------------------------------------------------
-- playSound
--
-- This will play a sound
--------------------------------------------------------------------------
function audioUtil.playSound(sound)
--	local soundThread = MOAICoroutine.new()
--	soundThread:run (
--		function()
			local soundObj = MOAIUntzSound.new()
			soundObj:load("audio/sound/"..sound.."."..audioUtil.soundFormat, true)
			soundObj:setVolume(audioUtil.soundVolume)
			soundObj:setLooping(false)
			soundObj:play()
--		end
--	)
end



--------------------------------------------------------------------------
-- playMusic
--
-- This will change the current music playing.
--------------------------------------------------------------------------
function audioUtil.playMusic(music, loop, volume)
	local loopMusic
	if loop == nil or not loop then
		loopMusic = false
	else
		loopMusic = true
	end
	local musicVolume
	if volume == nil then
		musicVolume = audioUtil.musicVolume
	else
		musicVolume = audioUtil.musicVolume * volume
	end
	audioUtil.musicObj:stop()
	audioUtil.musicObj:load("audio/music/"..music.."."..audioUtil.musicFormat, false)
	audioUtil.musicObj:setVolume(musicVolume)
	audioUtil.musicObj:setLooping(loopMusic)
--	audioUtil.musicObj:setLooping(true)
--	audioUtil.musicObj:play()
end

--------------------------------------------------------------------------
-- stopMusic
--
-- This will stop the music.
--------------------------------------------------------------------------
function audioUtil.stopMusic()
	audioUtil.musicObj:stop()
end


