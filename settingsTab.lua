-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------


local storyboard = require("storyboard")
local scene = storyboard.newScene()
local slider = require("slider")
local widget = require("widget")




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

    local scroller = widget.newScrollView{
        width = 768,
        height = 900,
        scrollWidth = 768,
        scrollHeight = 1800
    }

    -- create a white background to fill screen
    local bg = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    bg:setFillColor(255) -- white


    local function onSlider(event)
        local phase = event.phase
        -- update all the sliders
        if "moved" == phase then
            Sliders[event.id].valueLbl.text = tostring(event.value)
        end

        return true
    end


    local function createSliders()
        local trackGraph = "trackHoriz.png"
        local thumbD = "thumbHorizontal1.png"
        local thumbDrag = "thumbHorizontal1.png"

        local nameLblX = 10
        local valueLblX = 250
        local sliderX = 550
        local sliderY = 50

        for i, item in ipairs(Properties) do

            local nameLbl = display.newRetinaText(item.name, 0, 0, native.systemFont, 20)
            nameLbl:setTextColor(0) -- black
            nameLbl:setReferencePoint(display.CenterLeftReferencePoint)
            nameLbl.x = nameLblX
            nameLbl.y = sliderY

            local valueTxt
            if (item.isBoolean) then
                if (item.default == 0) then
                    valueTxt = tostring(false)
                else
                    valueTxt = tostring(true)
                end
            else
                valueTxt = tostring(item.default)
            end
            local valueLbl = display.newRetinaText(valueTxt, 0, 0, native.systemFont, 20)
            valueLbl:setTextColor(0) -- grey
            valueLbl:setReferencePoint(display.CenterLeftReferencePoint)
            valueLbl.x = valueLblX
            valueLbl.y = sliderY

            local descLbl = display.newRetinaText(item.desc, nameLblX, sliderY + 30, 800, 72, native.systemFont, 20)
            descLbl:setTextColor(128) -- black
            descLbl:setReferencePoint(display.TopLeftReferencePoint)
            --            descLbl.x = nameLblX
            --            if i == 1 then
            --            descLbl.y = sliderY + 40 * i
            --            else
            --                descLbl.y = sliderY + 55 * i
            --            end
            descLbl.isVisible = false


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

            sliderY = sliderY + 30

            scroller:insert(nameLbl)
            scroller:insert(descLbl)
            scroller:insert(valueLbl)
            scroller:insert(mySlider)
            scroller:insert(descLbl)
            Sliders[i] = { slider = mySlider, nameLbl = nameLbl, valueLbl = valueLbl, descLbl = descLbl }
        end
    end

    local function descriptionsHandler()

        local descTxt = display.newRetinaText("Show descriptions", 0, 0, native.systemFont, 20)
        descTxt:setTextColor(0) -- black
        descTxt:setReferencePoint(display.CenterLeftReferencePoint)
        descTxt.x = 10
        descTxt.y = 15

        local descStatus = false
        local toggle = display.newImage("icon1.png")
        toggle.x = 200
        toggle.y = 10

        local function toggleTap()
            toggle:removeSelf()
            if not descStatus then
                toggle = display.newImage("icon1-down.png")
                descStatus = true
                for i = 1, #Sliders do
                    local slide = 70 * (i - 1)
                    if i ~= 1 then
                        transition.to(Sliders[i].nameLbl, { time = 500, y = Sliders[i].nameLbl.y + slide })
                        transition.to(Sliders[i].slider, { time = 500, y = Sliders[i].slider.y + slide })
                        local function showDesc()
                            Sliders[i].descLbl.isVisible = true
                            Sliders[i].descLbl.y = Sliders[i].nameLbl.y + 15
                        end
                        transition.to(Sliders[i].valueLbl, { time = 500, y = Sliders[i].valueLbl.y + slide, onComplete = showDesc })
                    end
                    timer.performWithDelay(500, function() Sliders[i].descLbl.isVisible = true end)
                end
            else
                toggle = display.newImage("icon1.png")
                descStatus = false
                for i = 1, #Sliders do
                    local slide = 70 * (i - 1)
                    if i ~= 1 then
                        transition.to(Sliders[i].nameLbl, { time = 500, y = Sliders[i].nameLbl.y - slide })
                        transition.to(Sliders[i].slider, { time = 500, y = Sliders[i].slider.y - slide })
                        transition.to(Sliders[i].valueLbl, { time = 500, y = Sliders[i].valueLbl.y - slide })
                    end
                    Sliders[i].descLbl.isVisible = false
                end
            end
            --            createSliders(descStatus)
            toggle.x = 200
            toggle.y = 10
            scroller:insert(toggle)
            timer.performWithDelay(500, function() toggle:addEventListener("tap", toggleTap) end)
        end

        toggle:addEventListener("tap", toggleTap)
        scroller:insert(descTxt)
        scroller:insert(toggle)
    end


    -- all objects must be added to group (e.g. self.view)
    group:insert(bg)
    group:insert(scroller)
    descriptionsHandler()
    createSliders(false)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
    local group = self.view

    -- do nothing
end

-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = self.view
    print(" ")
    print(" ")
    print("---- CURRENT CONFIGURATION START ----")
    for i = 1, 31 do
        print("DefaultProperties." .. Properties[i].name .. "=" .. tostring(Sliders[i].slider:getValue()))
    end
    print("---- CURRENT CONFIGURATION END ----")
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

