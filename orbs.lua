orbs = {}
orbs.__index = orbs

function orbs.new(x, y, pointValue, size)
         local instance = setmetatable({}, orbs)
         instance.x = x
         instance.y = y
         instance.width = 20 * size
         instance.height = 20 * size

         instance.hitbox = {}
         instance.hitbox.x = instance.x
         instance.hitbox.y = instance.y
         instance.hitbox.width = instance.width
         instance.hitbox.height = instance.height
         
         instance.pointValue = pointValue
         instance.alpha = 100
         return instance
end

function orbs:pickup()
         game.points = game.points + self.pointValue
         self.hitbox.x, self.hitbox.y = -600, -600
         self.alpha = 0
end

function orbs:draw()
         for i, v in ipairs(orbs) do
                  love.graphics.setColor(0, 0, 1, v.alpha)
                  love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
         end
end