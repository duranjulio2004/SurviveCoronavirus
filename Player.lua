Player = Class{}

-- Function that takes care of initializing the player
function Player:init(x, y, sprite)
    self.x = x
    self.y = y
    self.sprite = sprite
    self.dy = 0
    self.dx = 0
    self.height = 54
    self.width = 58
end

-- Function that reinitializes the player
function Player:change(sprite)
    self.sprite = sprite
end

-- Function that takes care of updating the player
function Player:update(dt)

    -- math.max here ensures that we're the greater of 0 or the player's
    -- current calculated Y position when pressing up so that we don't
    -- go into the negatives; the movement calculation is simply our
    -- previously-defined paddle speed scaled by dt
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    
    
    -- similar to before, this time we use math.min to ensure we don't
    -- go any farther than the bottom of the screen minus the paddle's
    -- height (or else it will go partially below, since position is
    -- based on its top left corner)
    elseif self.dy > 0 then
        self.y = math.min(WINDOW_HEIGHT - 54, self.y + self.dy * dt)

    end

    -- math.min ensures that the player's x position is greater than 0
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)

    -- math.max ensures that the player's x position is greater than
    -- the screens width
    elseif self.dx > 0 then
        self.x = math.min(WINDOW_WIDTH - 58, self.x + self.dx *dt)
    end
end

function Player:collides(object)

    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > object.x + 25 or object.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > object.y + 25 or object.y > self.y + self.height then
        return false
    end 

    return true
end

-- Function that takes care of rendering the player
function Player:render()
    love.graphics.draw(self.sprite, self.x, self.y)
end