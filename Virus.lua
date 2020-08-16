Virus = Class{}

-- Function that takes care of initializing the virus
function Virus:init(sprite)
    self.sprite = sprite
    self.width = 60
    self.height = 60
end

function Virus:update(dt)
    
    -- Going right
    if self.direction == 1 then
        self.x = self.x + VIRUS_SPEED * dt

        -- If the virus reaches the right side of the screen it should reinitialize
        if self.x > WINDOW_WIDTH + self.width then
            self:newdirection(math.random(1,4))
        end
    end

    -- Going left
    if self.direction == 2 then
        self.x = self.x - VIRUS_SPEED * dt

        -- If the virus reaches the left side of the screen it should reinitialize
        if self.x < 0 - self.width then
            self:newdirection(math.random(1,4))       
        end
    end
    -- Going up
    if self.direction == 3 then
        self.y = self.y - VIRUS_SPEED * dt

        -- If the virus reaches the top side of the screen it should reinitialize
        if self.y < 0 - self.height then
            self:newdirection(math.random(1,4))
        end
    end
    -- Going down
    if self.direction == 4 then
        self.y = self.y + VIRUS_SPEED * dt

        -- If the virus reaches the bottom side of the screen it should reinitialize
        if self.y > WINDOW_HEIGHT then
            self:newdirection(math.random(1,4))
        end
    end
end

-- Assigns direction to the virus
function Virus:newdirection(newdirection) 

    self.direction = newdirection
    -- Going right
    if self.direction == 1 then
        self.x = math.random(-WINDOW_WIDTH, 0 - self.width )        -- Reposition the virus
        self.y = math.random(10, WINDOW_HEIGHT - 10 - self.height)   -- Reposition the virius
    end
    -- Going left
    if self.direction == 2 then
        self.x = math.random(WINDOW_WIDTH, (WINDOW_WIDTH * 2) - self.width)
        self.y = math.random(10, WINDOW_HEIGHT - 10 - self.height)
    end
    -- Going up
    if self.direction == 3 then
        self.x = math.random(10, WINDOW_WIDTH - self.width - 10)
        self.y = math.random(WINDOW_HEIGHT, (WINDOW_HEIGHT * 2) - self.height)
    end
    -- Going down
    if self.direction == 4 then
        self.x = math.random(10, WINDOW_WIDTH - self.width - 10)
        self.y = math.random(0 - self.height, -WINDOW_HEIGHT)
    end
end

-- Render the virus
function Virus:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end