-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local Particles = require("lib_particle_candy")

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--
-- NOTE: Code outside of listener functions (below) will only be executed once,
-- unless storyboard.removeScene() is called.
--
-----------------------------------------------------------------------------------------

local bg

-- Called when the scene's view does not exist:
function scene:createScene(event)
    local group = self.view
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
    local group = self.view


    if BackgroundImageEnabled then

        bg = display.newImage(BackgroundImage)

    else

        bg = display.newRect(0, 0, display.contentWidth, display.contentHeight)
        bg:setFillColor(BackgroundColor[1], BackgroundColor[2], BackgroundColor[3])
    end
    group:insert(bg)

    ParticleCount = display.newText("PARTICLES: 00", 30, 30, native.systemFont, 20)
    ParticleCount:setTextColor(255, 255, 255)
    ParticleCount:setReferencePoint(display.CenterLeftReferencePoint);
    group:insert(ParticleCount)
    ParticleCount:toFront()

    Particles.CreateEmitter("E1", 384, 512, Sliders[36].slider:getValue(), true, true)


    group:insert(Particles.GetEmitter("E1"))


    local ParticleProps = {}

    ParticleProps.lifeTime = Sliders[1].slider:getValue()
    ParticleProps.weight = Sliders[2].slider:getValue()
    ParticleProps.directionVariation = Sliders[3].slider:getValue()
    ParticleProps.velocityStart = Sliders[4].slider:getValue()
    ParticleProps.velocityVariation = Sliders[5].slider:getValue()
    ParticleProps.velocityChange = Sliders[6].slider:getValue()
    ParticleProps.rotationStart = Sliders[7].slider:getValue()
    ParticleProps.rotationVariation = Sliders[8].slider:getValue()
    ParticleProps.rotationChange = Sliders[9].slider:getValue()
    ParticleProps.autoOrientation = Sliders[10].slider:getValue()
    ParticleProps.useEmitterRotation = Sliders[11].slider:getValue()
    ParticleProps.alphaStart = Sliders[12].slider:getValue()
    ParticleProps.alphaVariation = Sliders[13].slider:getValue()
    ParticleProps.fadeInSpeed = Sliders[14].slider:getValue()
    ParticleProps.fadeOutSpeed = Sliders[15].slider:getValue()
    ParticleProps.fadeOutDelay = Sliders[16].slider:getValue()
    ParticleProps.scaleStart = Sliders[17].slider:getValue()
    ParticleProps.scaleVariation = Sliders[18].slider:getValue()
    ParticleProps.scaleInSpeed = Sliders[19].slider:getValue()
    ParticleProps.scaleMax = Sliders[20].slider:getValue()
    ParticleProps.scaleOutDelay = Sliders[21].slider:getValue()
    ParticleProps.scaleOutSpeed = Sliders[22].slider:getValue()
    if (Sliders[23].slider:getValue()) then
        ParticleProps.colorStart = { Sliders[24].slider:getValue(), Sliders[25].slider:getValue(), Sliders[26].slider:getValue() }
        ParticleProps.colorChange = { Sliders[27].slider:getValue(), Sliders[28].slider:getValue(), Sliders[29].slider:getValue() }
    end
    ParticleProps.imagePath = ParticleImage.name
    ParticleProps.imageWidth = ParticleImage.width
    ParticleProps.imageHeight = ParticleImage.height
    ParticleProps.killOutsideScreen = true
    ParticleProps.emissionShape = Sliders[30].slider:getValue()
    ParticleProps.emissionRadius = Sliders[31].slider:getValue()
    ParticleProps.randomMotionMode = Sliders[32].slider:getValue()
    ParticleProps.randomMotionInterval = Sliders[33].slider:getValue()
    ParticleProps.randomMotionAmount = Sliders[34].slider:getValue()

    local name = tostring(ParticleProps)

    Particles.CreateParticleType(name, ParticleProps)

    -- FEED EMITTERS (EMITTER NAME, PARTICLE TYPE NAME, EMISSION RATE, DURATION, DELAY)
    Particles.AttachParticleType("E1", name, Sliders[35].slider:getValue(), 99999, 0)



    -- TRIGGER THE EMITTERS
    Particles.StartEmitter("E1")

    Particles.StartAutoUpdate();

    Runtime:addEventListener("enterFrame", particleCount)
end

-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = self.view

    Particles.StopAutoUpdate()
    Particles.StopEmitter("E1")
    Particles.CleanUp()
    Runtime:removeEventListener("enterFrame", particleCount)
    ParticleCount:removeSelf()
    ParticleCount = nil
    bg:removeSelf()
    bg = nil
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene(event)
    local group = self.view

    -- INSERT code here (e.g. remove listeners, remove widgets, save state variables, etc.)
end


function particleCount()
    ParticleCount.text = "PARTICLES:" .. Particles.CountParticles()
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener("createScene", scene)

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener("enterScene", scene)

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener("exitScene", scene)

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener("destroyScene", scene)

-----------------------------------------------------------------------------------------

return scene
