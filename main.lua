display.setStatusBar( display.HiddenStatusBar )

_W = display.contentWidth
_H = display.contentHeight

ch1Stream = audio.loadStream("BGM.mp3")
audio.play( ch1Stream, {loops=-1 } )

soundID = audio.loadSound( "bomb.mp3" )

local playBeep = function()
 print("beep")
 audio.play( soundID )
end
local dominonum = 0

local physics = require( "physics" )
physics.start()
--physics.setDrawMode( "hybrid" )
--physics.setDrawMode( "debug" )

local gameUI = require("gameUI")

local dispObj_1 = display.newImageRect( "sky.jpg", 1000, 480 )
dispObj_1.x = 400
dispObj_1.y = 240

local dispObj_2 = display.newImageRect( "grass.png", 1000, 60 )
dispObj_2.x = 400
dispObj_2.y = 457
physics.addBody( dispObj_2, "static", { density=1, friction=1.0, bounce=0.1 } )

local dispObj_3 = display.newImageRect( "pile.png", 30, 800 )
dispObj_3.x = 0
dispObj_3.y = 412
dispObj_3.rotation = -90
physics.addBody( dispObj_3, "static", { density=1, friction=0.3, bounce=0.1 } )

local dispObj_4 = display.newImageRect( "pile.png", 30, 700 )
dispObj_4.x = 0
dispObj_4.y = 382
dispObj_4.rotation = -90
physics.addBody( dispObj_4, "static", { density=1, friction=0.3, bounce=0.1 } )

local dispObj_5 = display.newImageRect( "pile.png", 30, 600 )
dispObj_5.x = 0
dispObj_5.y = 352
dispObj_5.rotation = -90
physics.addBody( dispObj_5, "static", { density=1, friction=0.3, bounce=0.1 } )

local dispObj_6 = display.newImageRect( "pile.png", 30, 500 )
dispObj_6.x = 0
dispObj_6.y = 322
dispObj_6.rotation = -90
physics.addBody( dispObj_6, "static", { density=1, friction=0.3, bounce=0.1 } )

local rock = display.newImageRect( "rock.png", 90, 60 )
rock.x = 86
rock.y = 275

local runbutton = display.newImageRect("run.png",90,60)
runbutton.x = _W-20
runbutton.y = 32local resetbutton = display.newImageRect("reset.png",90,60)
resetbutton.x = _W-110
resetbutton.y = 32

local function localDrag(e)
	if e.phase == "began" then
		e.target:toFront()
	end
	gameUI.dragBody(e)
	return true
end

local rockCollitionFilter = {categoryBit = 1, maskBits =1}
local rockBody = { density=1, friction=0.3, bounce=0.2, radius=30, filter=rockCollitionFilter}
physics.addBody(rock, rockBody)
rock.angularDamping = 0.3
rock.linearDamping = 0.3
rock:addEventListener("touch",localDrag)
local function touchListener(e)
--	print("TAP")
	runbutton.bodyType="dynamic"
	rock:applyForce(500,-400,rock.x,rock.y)
	playBeep()

endlocal function touchListener2(e)
--	print("TAP")
	resetbutton.bodyType="dynamic"	physics.removeBody(rock)	physics.addBody(rock, rockBody)
	rock.x = 86
	rock.y = 275		
	playBeep()

end

runbutton:addEventListener("tap", touchListener)resetbutton:addEventListener("tap", touchListener2)
local onTouch = function( event )
	if event.x > _W-160 and event.y < 63 then
		
	elseif event.phase =="began" then
		local domino = display.newRect( event.x, event.y,8, 60 )
		domino:setStrokeColor(math.random(255), math.random(255), math.random(255))
		domino.strokeWidth = 10
		domino:setFillColor(0, 0, 0, 0)

		physics.addBody ( domino, "dynamic", {density=2.0, friction=0.10, bounce=0.1 })		
		
		return true
	end
end
Runtime:addEventListener ( "touch", onTouch )

