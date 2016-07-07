--####################################
-- util.lua
-- author: Jonas Yakimischak
--
-- This script will have convenience methods/objects
--####################################

--namespace util

--------------------------------------------------------------------------
-- getArrayList
--
-- This will return an arrayList object that has an add method and a length associated.
-- NOTE: items cannot be removed from the list
-- NOTE: 1 indexed arrays
--------------------------------------------------------------------------
function util.getArrayList()
	local arrayList = {}
	
	arrayList.length = 0
	function arrayList:add(obj)
		self[self.length+1] = obj
		self.length = self.length + 1
	end
	
	return arrayList
end


--------------------------------------------------------------------------
-- getLinkedList
--
-- This will return a link list object
--------------------------------------------------------------------------
function util.getLinkedList()
	local linkedList = {}
	
	linkedList.length = 0

	--------------------------------------------------------------------------
	-- add
	--
	-- This will add an object to the end of the linked list
	--------------------------------------------------------------------------
	function linkedList:add(obj)
		local node = {}
		node.list = self
		node.first = nil
		node.last = nil

		--------------------------------------------------------------------------
		-- remove
		--
		-- This will remove the node from the linked list
		--------------------------------------------------------------------------
		function node:remove()
			if self.list.length > 1 then
				if self.prev == nil then
					self.list.first = self.next
					self.next.prev = nil
				else
					self.prev.next = self.next
				end
				if self.next == nil then
					self.list.last = self.prev 
					self.prev.next = nil
				else
					self.next.prev = self.prev
				end
				self.list.length = self.list.length - 1
			elseif self.list.length == 1 then
				self.list.first = nil
				self.list.last = nil
				self.list.length = 0
			end
		end
		
		node.value = obj
		if self.length == 0 then
			self.first = node
			self.last = node
		else
			self.last.next = node
			node.prev = self.last
			self.last = node
		end
		self.length = self.length + 1
	end

	return linkedList
end


--------------------------------------------------------------------------
-- loadTexturePack
--
--This will load the specified texture pack into a deck.
--returns deck, names
--------------------------------------------------------------------------
function util.loadTexturePack(lua, png)
    local frames = dofile ( lua ).frames

    local tex = MOAITexture.new ()
    tex:load ( png )
    local xtex, ytex = tex:getSize ()

    -- Annotate the frame array with uv quads and geometry rects
    for i, frame in ipairs ( frames ) do
        -- convert frame.uvRect to frame.uvQuad to handle rotation
        local uv = frame.uvRect
        local q = {}
        if not frame.textureRotated then
            -- From Moai docs: "Vertex order is clockwise from upper left (xMin, yMax)"
            q.x0, q.y0 = uv.u0, uv.v0
            q.x1, q.y1 = uv.u1, uv.v0
            q.x2, q.y2 = uv.u1, uv.v1
            q.x3, q.y3 = uv.u0, uv.v1
        else
            -- Sprite data is rotated 90 degrees CW on the texture
            -- u0v0 is still the upper-left
            q.x3, q.y3 = uv.u0, uv.v0
            q.x0, q.y0 = uv.u1, uv.v0
            q.x1, q.y1 = uv.u1, uv.v1
            q.x2, q.y2 = uv.u0, uv.v1
        end
        frame.uvQuad = q

        -- convert frame.spriteColorRect and frame.spriteSourceSize
        -- to frame.geomRect.  Origin is at x0,y0 of original sprite
        local cr = frame.spriteColorRect
        local r = {}
        r.x0 = cr.x
        r.y0 = cr.y
        r.x1 = cr.x + cr.width
        r.y1 = cr.y + cr.height
        frame.geomRect = r
    end

    -- Construct the deck
    local deck = MOAIGfxQuadDeck2D.new ()
    deck:setTexture ( tex )
    deck:reserve ( #frames )
    local names = {}
    for i, frame in ipairs ( frames ) do
        local q = frame.uvQuad
        local r = frame.geomRect
        names[frame.name] = i
        deck:setUVQuad ( i, q.x0,q.y0, q.x1,q.y1, q.x2,q.y2, q.x3,q.y3 )
        deck:setRect ( i, r.x0,r.y0, r.x1,r.y1 )
    end

    return deck, names, tex
end


--------------------------------------------------------------------------
-- addVector
--
--This will add a length/angle vector to and x,y vector...used for moving ships a given distance.
--This will return the resultant x,y vector
--------------------------------------------------------------------------
function util.addVector(x, y, distance, angle)
	local degrees = math.deg(angle)
	local moveDistanceX
	local moveDistanceY
	local resultantVectorX
	local resultantVectorY

	moveDistanceX = math.abs(math.sin(angle) * distance)
	moveDistanceY = math.abs(math.cos(angle) * distance)
	
	if degrees % 360 > 0 and degrees % 360 <= 90 then
		resultantVectorX = x - moveDistanceX
		resultantVectorY = y + moveDistanceY
	elseif degrees % 360 > 90 and degrees % 360 <= 180 then
		resultantVectorX = x - moveDistanceX
		resultantVectorY = y - moveDistanceY
	elseif degrees % 360 > 180 and degrees % 360 <= 270 then
		resultantVectorX = x + moveDistanceX
		resultantVectorY = y - moveDistanceY
	else
		resultantVectorX = x + moveDistanceX
		resultantVectorY = y + moveDistanceY
	end

	return resultantVectorX, resultantVectorY
end


--------------------------------------------------------------------------
-- angleBetweenTwoNormalVectors
--
--This will find the angle between 2 normalized vectors (with r = 1)
--this will return the angle in degrees 
--------------------------------------------------------------------------
function util.angleBetweenTwoNormalVectors(beginAngle, endAngle)
	local resultantAngle

	--beginAngle and endAngle are 2 1-length vectors, convert these to cartesian coordinates
	--note, for these vectors r = 1
	--the general formulas are:
	--x = rcos(theta)
	--y = rsin(theta)
	--v1
	local x1 = math.cos(math.rad(beginAngle))
	local y1 = math.sin(math.rad(beginAngle))
	--v2
	local x2 = math.cos(math.rad(endAngle))
	local y2 = math.sin(math.rad(endAngle))
	
	local v1DotV2 = util.dotProduct(x1, y1, x2, y2)
	
	--compute the vector magnitudes
	local v1Magnitude = math.sqrt(x1*x1+y1*y1)
	local v2Magnitude = math.sqrt(x2*x2+y2*y2)

	--now compute the angle between the 2 vectors
	--the formual is
	-- theta = acos(v1.v2 / |v1||v2|)
	local angleBetween = math.deg(math.acos(v1DotV2 / v1Magnitude * v2Magnitude))
	
	return angleBetween
end


--------------------------------------------------------------------------
-- addAngle
--
--This will add degrees to beginAngle in the direction of endAngle
--This will return the resultant angle
--------------------------------------------------------------------------
function util.addAngle(beginAngle, endAngle, degrees)
	--beginAngle and endAngle are 2 1-length vectors, convert these to cartesian coordinates
	--note, for these vectors r = 1
	--the general formulas are:
	--x = rcos(theta)
	--y = rsin(theta)
	--v1
	local x1 = math.cos(math.rad(beginAngle))
	local y1 = math.sin(math.rad(beginAngle))
	--v2
	local x2 = math.cos(math.rad(endAngle))
	local y2 = math.sin(math.rad(endAngle))
	
	local v1CrossV2 = util.crossProduct(x1, y1, x2, y2)
	if v1CrossV2 > 0 then
		return beginAngle + degrees
	elseif v1CrossV2 < 0 then
		return beginAngle - degrees
	else
		return beginAngle
	end
end


--------------------------------------------------------------------------
-- distanceBetweenPoints
--
--This will find the distance between 2 points
--------------------------------------------------------------------------
function util.distanceBetweenPoints(x1, y1, x2, y2)
	local diffX = x2-x1
	local diffY = y2 - y1 

	return math.sqrt(diffX*diffX + diffY*diffY)
end


--------------------------------------------------------------------------
-- rotatePoint
--
--Rotate a point by the given angle in degrees
--------------------------------------------------------------------------
function util.rotatePoint(x, y, angle)
	local xPrime
	local yPrime
	local radAngle = math.rad(angle)
	local cosAngle = math.cos(radAngle)
	local sinAngle = math.sin(radAngle)
	
	xPrime = x*cosAngle - y*sinAngle
	yPrime = x*sinAngle + y*cosAngle
	
	return xPrime, yPrime
end


--------------------------------------------------------------------------
-- normalizeAngle
--
--Normalize the given angle between 0 and 359 degrees
--------------------------------------------------------------------------
function util.normalizeAngle(angle)
	return ((angle % 360) + 360) % 360
end


--------------------------------------------------------------------------
-- dotProduct
--
--Calculate the dot product of 2 vectors
--------------------------------------------------------------------------
function util.dotProduct(x1, y1, x2, y2)
	return x1 * x2 + y1 * y2
end


--------------------------------------------------------------------------
-- crossProduct
--
--Calculate the cross product of 2 vectors
--
--if the cross product is positive then v1 is right of v2
--if the cross product is negative then v1 is left of v2
--if the cross product is 0 then the points are collinear
--------------------------------------------------------------------------
function util.crossProduct(x1, y1, x2, y2)
	return x1 * y2 - x2 * y1
end


--------------------------------------------------------------------------
-- polarToCartesian
--
--convert the polar coordinate to a cartesian coordinate
--angle in degrees....this will add 90 to the angles so that they face upward like they do for the props
--------------------------------------------------------------------------
function util.polarToCartesian(r, angle)
	--add 90 to the angle to rotate it to the top, and normalize it
	local normalizedAngle = util.normalizeAngle(angle+90)
	local radAngle = math.rad((normalizedAngle))
	
	--x = rcos(theta)
	--y = rsin(theta)
	local x = r*math.cos(radAngle)
	local y = r*math.sin(radAngle)
	
	return x, y
end


--------------------------------------------------------------------------
-- cartesianToPolar
--
--convert the cartesian coordinate to a polar coordinate
--returns r, angle
--with angle in degrees
--------------------------------------------------------------------------
function util.cartesianToPolar(x, y)
	--r = sqrt(x^2 + y^2)
	--angle = atan(y/x)
	local r = math.sqrt(x*x + y*y)
	local angle = util.normalizeAngle(math.deg(math.atan2(y, x))-90)
	
	return r, angle
end


--------------------------------------------------------------------------
-- reflectAngle
--
-- Get the reflection off of the given side of the screen
-- side can be one of, left, right, top, bottom
--------------------------------------------------------------------------
function util.reflectAngle(moveAngle, side)
	--get a normal vector for the move angle of the ship
	local moveX, moveY = util.polarToCartesian(1, moveAngle)
	if side == "left" then
		if moveX < 0 then
			moveX = moveX * -1
		end
	elseif side == "right" then
		if moveX > 0 then
			moveX = moveX * -1
		end
	elseif side == "top" then
		if moveY > 0 then
			moveY = moveY * -1
		end
	elseif side == "bottom" then
		if moveY < 0 then
			moveY = moveY * -1
		end
	else
		return moveAngle
	end
	local newR, newAngle = util.cartesianToPolar(moveX, moveY)
	return newAngle
end


--------------------------------------------------------------------------
-- isPointInCone
--
--This will find if a point is in a cone.
--
--pointX - the point
--pointY
--coneX - the point where the cone starts
--coneY
--coneLength - the length of the cone
--coneCenterAngle - the angle that the center of the cone is pointing toward
--coneArcStart - the start and end arc for the cone, assuming the coneCenterAngle is at 0 degrees
--coneArcEnd
--------------------------------------------------------------------------
function util.isPointInCone(pointX, pointY, coneX, coneY, coneLength, coneCenterAngle, coneArcStart, coneArcEnd)
	--first, check if the distance between the point and the cone start is less than the cone length
	local distance = util.distanceBetweenPoints(pointX, pointY, coneX, coneY)
	if distance > coneLength then
		return false
	end

	--now translate the point to the cone origin
	local transPointX = pointX - coneX
	local transPointY = pointY - coneY
	local pointR
	local pointAngle
	pointR, pointAngle = util.cartesianToPolar(transPointX, transPointY)
	--translate coneArcStart and coneArcEnd as if coneCentreAnle was at 0 degrees
	local transConeArcStart = util.normalizeAngle(coneArcStart + coneCenterAngle)
	local transConeArcEnd = util.normalizeAngle(coneArcEnd + coneCenterAngle)
	--check if pointAngle is between coneArcStart and coneArcEnd
	if transConeArcStart < transConeArcEnd then
		return transConeArcStart <= pointAngle and pointAngle <= transConeArcEnd
	end
	return transConeArcStart <= pointAngle or pointAngle <= transConeArcEnd
end


--------------------------------------------------------------------------
-- rollDice
--
-- roll the "dice" with with given number of sides and given modifier
--------------------------------------------------------------------------
function util.rollDice(sides, modifier)
	local roll = math.random(1 + modifier, sides + modifier)
	return roll
end


--------------------------------------------------------------------------
-- fuzzyCompare
--
-- compare 2 numbers with a margin of error...defaults to .1
--------------------------------------------------------------------------
function util.fuzzyCompare(num1, num2, marginOfError)
	local margin = .1
	if marginOfError ~= nil then
		margin = marginOfError
	end
	return math.abs(num1 - num2) <= margin
end

--------------------------------------------------------------------------
-- doesFileExist
--
-- return true if the given file name exists.
--------------------------------------------------------------------------
function util.doesFileExist(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end