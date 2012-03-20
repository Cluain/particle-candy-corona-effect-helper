-----------------------------------------------------------------------------------------
--
-- view3.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local slider = require("slider")


-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--
-- NOTE: Code outside of listener functions (below) will only be executed once,
-- unless storyboard.removeScene() is called.
--
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene(event)
    local group = self.view
    local bg = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    bg:setFillColor(255) -- white
    group:insert(bg)


    local function onSlider(event)
        local phase = event.phase
        -- update all the sliders
        if "moved" == phase then
            BackgroundSliders[event.id].valueLbl.text = tostring(event.value)
            for i = 1, 3 do
                BackgroundColor[i] = BackgroundSliders[i].slider:getValue()
            end
            BackgroundImageEnabled = BackgroundSliders[4].slider:getValue()
        end

        return true
    end


    local function createSliders()
        local trackGraph = "trackHoriz.png"
        local thumbD = "thumbHorizontal1.png"
        local thumbDrag = "thumbHorizontal1.png"

        local nameLblX = 10
        local valueLblX = 200
        local sliderX = 550
        local sliderY = 40

        for i, item in ipairs(BackgroundProperties) do

            local nameLbl = display.newRetinaText(item.name, 0, 0, native.systemFont, 20)
            nameLbl:setTextColor(0) -- black
            nameLbl:setReferencePoint(display.CenterLeftReferencePoint)
            nameLbl.x = nameLblX
            nameLbl.y = sliderY

            local valueTxt
            if (item.isBoolean) then
                valueTxt = tostring(item.default)
            else
                valueTxt = tostring(item.default)
            end
            local valueLbl = display.newRetinaText(valueTxt, 0, 0, native.systemFont, 20)
            valueLbl:setTextColor(0) -- black
            valueLbl:setReferencePoint(display.CenterLeftReferencePoint)
            valueLbl.x = valueLblX
            valueLbl.y = sliderY

            local mySlider = slider.newSlider({
                track = trackGraph,
                thumbDefault = thumbD,
                thumbOver = thumbDrag,
                isVertical = false,
                isInteger = item.isInteger,
                isBoolean = item.isBoolean,
                onEvent = onSlider,
                minValue = item.min,
                maxValue = item.max,
                value = item.default,
                id = i,
            })
            mySlider.x = sliderX
            mySlider.y = sliderY

            sliderY = sliderY + 31

            group:insert(nameLbl)
            group:insert(valueLbl)
            group:insert(mySlider)
            BackgroundSliders[i] = { slider = mySlider, nameLbl = nameLbl, valueLbl = valueLbl }
        end
    end

    createSliders()
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
end

-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    print(" ")
    print(" ")
    print("---- CURRENT BACKGROUND CONFIGURATION START ----")
    print("BackgroundColor = { " .. BackgroundColor[1] .. ", " .. BackgroundColor[2] .. ", " .. BackgroundColor[3] .. " }")
    print("---- CURRENT BACKGROUND CONFIGURATION END ----")
    print(" ")
    print(" ")
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene(event)
    local group = self.view

    -- INSERT code here (e.g. remove listeners, remove widgets, save state variables, etc.)
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