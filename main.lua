-- HELLOOWORLD HACKATHON PROJECT
-- SURVIVE CORONAVIRUS



-- GLOBAL VARIABLES

-- The "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods (Useful for making classes/objects)
Class = require 'class'

-- Require the classes
require 'Player'
require 'Virus'


-- Declare the window's size
WINDOW_WIDTH = 720
WINDOW_HEIGHT = 720

-- Player's speed
PLAYER_SPEED = 20000

-- Virus' speed
VIRUS_SPEED = 300


-- Player's starting point
starting_playerx = (WINDOW_WIDTH / 2) - 64
starting_playery = (WINDOW_HEIGHT / 2) - 64

-- Loads up the game in the start
function love.load()

    -- Seed the math function
    math.randomseed(os.time())

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false,
    })

    -- Window title
    love.window.setTitle("Hackathon Surive Coronavirus")

    -- Table that holds all the skins
    skins = {
        ['maskon'] = love.graphics.newImage("skins/maskon.png"),
        ['maskoff'] = love.graphics.newImage("skins/maskoff.png"),
        ['virus'] = love.graphics.newImage("skins/virus.png")
    }


    -- Initialize player
    player = Player(starting_playerx, starting_playery, skins['maskoff'])
    
    -- Create a table that holds all the virus objects
    viruses = {}

    -- Insert virus objects into table
    -- Initializes viruses
    for a=1, 10 do
        table.insert(viruses, Virus(skins['virus']))
    end

    -- Assigns direction to viruses
    for k, virus in pairs(viruses) do
        virus:newdirection(math.random(1,4))
    end

    gameState = "wait"
    timer = 0

    score = 0
end

-- Function that detects key input
function love.keypressed(key)

    -- If user presses escape key, then exit the application
    if key == 'escape' then
        love.event.quit()
    end

end

-- Function that updates the game continously
function love.update(dt)

    -- If the gamestate is play
    if gameState == 'play' then

        -- Update the score
        score = score + dt

        -- Player Control BUG FIXES
        -- If the player isn't trying to move up or down, set vertical movement to 0
        if not love.keyboard.isDown('w') or not love.keyboard.isDown('s') then
            player.dy = 0
        end

        -- If the player isn't trying to move right or left, set horizontal movement to 0
        if not love.keyboard.isDown('a') or not love.keyboard.isDown('d') then
            player.dx = 0
        end

        -- PLAYER CONTROLS
        -- If key "w" is pressed, move player up
        if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
            player.dy = -PLAYER_SPEED * dt
        end
        -- If key "s" is pressed, move player down
        if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
            player.dy = PLAYER_SPEED * dt
        end
        -- If key "a" is pressed, move player to the left 
        if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
            player.dx = - PLAYER_SPEED * dt
        end
        -- If key "d" is pressed, move player to the right
        if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
            player.dx = PLAYER_SPEED * dt
        end


        -- Continously update the player's positionS
        player:update(dt)

        -- Continously update the virus' position
        for k, virus in pairs(viruses) do
            virus:update(dt)
        end

        -- Detects if player collides with anything
        for k, virus in pairs(viruses) do
            if player:collides(virus) then
                intscore = math.floor(score)
                gameState = "scores"
            end
        end
    
    elseif gameState == "wait" then

        -- Initialize timer
        
        timer = timer + dt
        
        if timer > 5 then
            gameState = "play"
        end
    end
end

-- Function that draws to the screen
function love.draw()
    -- Set the background color
    love.graphics.setBackgroundColor(199/255, 199/255, 199/255,1)

    if gameState == "play" then
        love.graphics.setColor(1,1,1,1)
        -- Render the player
        player:render()

        -- Render the virus
        for k, virus in pairs(viruses) do
            virus:render()
        end
        -- Display score
        love.graphics.push()
        love.graphics.scale(2, 2)
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf("".. tostring(math.floor(score)) .. '', -400, 10/3, WINDOW_WIDTH, 'right')
        love.graphics.pop()
    elseif gameState == "scores" then
        -- Display score
        
        love.graphics.push()
        love.graphics.scale(2, 2)
        love.graphics.printf("Score:".. tostring(intscore) .. '', -200, 250 / 2, WINDOW_WIDTH, 'center')
        love.graphics.pop()
    end
end