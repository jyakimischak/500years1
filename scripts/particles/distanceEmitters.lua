--####################################
-- distanceEmitters.lua
-- author: Jonas Yakimischak
--
-- This defines the distance particle emitters used in the game.
--####################################

--namespace distanceEmitters


function distanceEmitters.exhaust(layer)
	CONST = MOAIParticleScript.packConst
	
	-----------------------
	-- init script
	-----------------------
	local init = MOAIParticleScript.new()
	
	-----------------------
	-- render script
	-----------------------
	local render = MOAIParticleScript.new()
	render:sprite()
	render:ease(MOAIParticleScript.SPRITE_OPACITY, CONST(1), CONST(0), MOAIEaseType.EASE_OUT)
	
	particlesGfxQuads:setRect(particlesNames["greyDot.png"], -10, -10, 10, 10)
	
	local system = MOAIParticleSystem.new()
	system:reserveParticles(20, 1)
	system:reserveSprites(20)
	system:reserveStates(1)
	system:setDeck(particlesGfxQuads)
	system:setIndex(particlesNames["greyDot.png"])
	system:start()
	layer:insertProp(system)
	
	local state = MOAIParticleState.new()
	state:setTerm(2, 2)
	state:setInitScript(init)
	state:setRenderScript(render)
	system:setState(1, state)
	
	local emitter = MOAIParticleDistanceEmitter.new()
	emitter:setSystem(system)
	emitter:setMagnitude(0.125)
	emitter:setAngle(260, 280)
	emitter:setDistance(50)
	
	return emitter
end