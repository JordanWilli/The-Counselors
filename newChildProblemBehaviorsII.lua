local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function textListener( event )

    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
       
        -- once the user inputs their user name then we can use it.


    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )
    composer.removeScene("newChildProblemBehaviorsI")
    composer.removeScene("newChildConsequencesI")
    local sceneGroup = self.view
    local phase = event.phase
    if (not event.params) then 
        session = "null session"
        print("Session: "..session)
    else
        session = event.params.session_ID
        print("Session: "..session)
    end

    Soptions =
    {
        params = {
            session_ID = session
        }
    } 

    if (event.params) then
        Soptions.params.userName = event.params.userName 
        Soptions.params.Password = event.params.Password
        Soptions.params.behaviors1 = event.params
    end


    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        local function scrollListener( event )

            local phase = event.phase
            if ( phase == "began" ) then print( "Scroll view was touched" )
            elseif ( phase == "moved" ) then print( "Scroll view was moved" )
            elseif ( phase == "ended" ) then print( "Scroll view was released" )
            end

            -- In the event a scroll limit is reached...
            if ( event.limitReached ) then
                if ( event.direction == "up" ) then print( "Reached bottom limit" )
                elseif ( event.direction == "down" ) then print( "Reached top limit" )
                elseif ( event.direction == "left" ) then print( "Reached right limit" )
                elseif ( event.direction == "right" ) then print( "Reached left limit" )
                end
            end

            return true
        end

        if (Soptions.params) then
            Soptions.params.Fbehaviors = {}
        end

        local scrollView = widget.newScrollView(
            {
                --top = 100,
                --left = 10,
                width = display.contentWidth,
                height = 7*(display.contentHeight/8)-50,
                scrollWidth = 600,
                scrollHeight = 2500,
                listener = scrollListener
            }
        )

        sceneGroup:insert(scrollView)

        local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
        background:setFillColor( 0.745098 ,0.745098 ,0.745098)
        sceneGroup:insert(background)
        background:toBack()
        local background2 = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, 5000)
        background2:setFillColor( 0.745098 ,0.745098 ,0.745098)
        sceneGroup:insert(background2)
        scrollView:insert(background2)
        background2:toBack()

        local pickText = display.newText("Child Problem Behaviors II", display.contentWidth/2, display.contentHeight-display.contentHeight + 100, native.systemFont, 50)
        pickText.size = 40
        pickText:setFillColor(0,0,0)
        sceneGroup:insert(pickText)
        scrollView:insert(pickText)

        --print("--------------")
        --print(Soptions.params.behaviors1.behaviors)    
        count = 0
        for k in pairs(Soptions.params.behaviors1.behaviors) do
            --print(Soptions.params.behaviors1.behaviors[k][1])
            local newBehavior = display.newText(Soptions.params.behaviors1.behaviors[k][1].."/"..Soptions.params.behaviors1.behaviors[k][2],display.contentWidth/2,display.contentHeight-display.contentHeight + 150+50*k,native.systemFont,44)
            newBehavior:setFillColor(0,0,0)
            sceneGroup:insert(newBehavior)
            scrollView:insert(newBehavior)
            count = count + 1
            table.insert(Soptions.params.Fbehaviors,{Soptions.params.behaviors1.behaviors[k][1],Soptions.params.behaviors1.behaviors[k][2]})
        end

        local newBehaviorButton = display.newRect(3*(display.contentWidth/4) + 100, 7*(display.contentHeight/8), 75, 75)
        newBehaviorButton:setFillColor(0.372549, 0.619608, 0.627451)
        sceneGroup:insert(newBehaviorButton)


        local newPBehavior = native.newTextField(newBehaviorButton.x-display.contentWidth/2,newBehaviorButton.y,display.contentWidth/2,75)
        sceneGroup:insert(newPBehavior)
        newPBehavior:addEventListener( "userInput", textListener )
        newPBehavior.text = "add problem behavior"

        local newDBehavior = native.newTextField(newBehaviorButton.x-display.contentWidth/2,newBehaviorButton.y+100,display.contentWidth/2,75)
        sceneGroup:insert(newDBehavior)
        newDBehavior:addEventListener( "userInput", textListener )
        newDBehavior.text = "add desired behavior"

        function newBehaviorButton:tap(event)
            print("tap")
            local newBehavior = display.newText(newPBehavior.text.."/"..newDBehavior.text,display.contentWidth/2,display.contentHeight-display.contentHeight + 150+50*(count+1),native.systemFont,44)
            newBehavior:setFillColor(0,0,0)
            sceneGroup:insert(newBehavior)
            scrollView:insert(newBehavior)
            count = count + 1
            table.insert(Soptions.params.Fbehaviors,{newPBehavior.text,newDBehavior.text})
        end

        newBehaviorButton:addEventListener( "tap", newBehaviorButton )
       
        local backButtonNew = widget.newButton(
		    {
		        --width = 500,
		        --heigth = 500,
		        id = "backButtonNew",
		        defaultFile = "backArrow3.png",
		        onEvent = handleButtonEvent
		    }
		)

		backButtonNew.x = display.contentWidth/2 - 320 
		backButtonNew.y = display.contentHeight - display.contentHeight + 100
		sceneGroup:insert(backButtonNew)
        scrollView:insert( backButtonNew )

        local nextButton = display.newRect(display.contentWidth/2 + display.contentWidth/2  - 100, display.contentHeight/2 , 70, 75)
        nextButton:setFillColor(0.372549, 0.619608, 0.627451)
        sceneGroup:insert(nextButton)
        scrollView:insert( nextButton )

        function nextButton:tap(event)
            newPBehavior:removeSelf()
            newDBehavior:removeSelf()
            composer.gotoScene("newChildConsequencesI",Soptions)
        end
        
        nextButton:addEventListener("tap", nextButton)

         function backButtonNew:tap(event)
            newPBehavior:removeSelf()
            newDBehavior:removeSelf()
            composer.gotoScene("newChildProblemBehaviorsII",Soptions)
        
        end

        -- this listens to see if object has been tapped
        backButtonNew:addEventListener("tap", backButtonNew)



    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
