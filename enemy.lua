enemy = {}
enemy.__index = enemy

function enemy.new(speed, health, type, scale)
         local instance = setmetatable({}, enemy)
         local dice = math.random(1, 4)
         if dice == 1 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = 0
         elseif dice == 2 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = love.graphics.getHeight()
         elseif dice == 3 then
                  instance.x = 0
                  instance.y = love.graphics.getHeight() / 2
         elseif dice == 4 then
                  instance.x = love.graphics.getWidth()
                  instance.y = love.graphics.getHeight() / 2
         end
         if type == "def" then
                  instance.health = health
                  instance.speed = speed
                  instance.sprite = "/(-o-/)"
                  instance.scale = scale
         elseif type == "tank" then
                  instance.health = health * 2
                  instance.speed = speed / 2
                  instance.sprite = "/[-o-/]"
                  instance.scale = scale * 1.2
         elseif type == "speed" then
                  instance.health = health / 2
                  instance.speed = speed * 2
                  instance.sprite = "/(--/)"
                  instance.scale = scale * 1
         elseif type == "boss" then
                  instance.health = health
                  instance.speed = speed
                  instance.sprite = "   ^^^\n   I*I\n\n/(- O -/)"
                  instance.scale = scale * 1.5
         elseif type == "tst_dummy" then
                  instance.health = health ^ 9
                  instance.speed = speed - speed
                  instance.sprite = "   !!!\n/{+ # +/}"
                  instance.scale = scale 
         end

         instance.hitbox = {}
         instance.hitbox.width = 100
         instance.hitbox.height = 50
         
         return instance
end

function enemy:draw()
         love.graphics.print(self.sprite, font, self.x, self.y, nil, self.scale)
         love.graphics.rectangle("fill", self.x, self.y - 40, self.health, 20)
end

function enemy:checkDeath()
         if self.health < 0 then
                  enemy:despawn()
                  score = score + 1
         end
end

function enemy:move(dt, gotox, gotoy)
         local angle = math.atan2(gotoy - self.y, gotox - self.x)

         local cos = math.cos(angle)
         local sin = math.sin(angle)

         self.x = self.x + self.speed * cos * dt
         self.y = self.y + self.speed * sin * dt
end

function enemy:despawn()
         print("dead")
end
--[[
tank_enemies = {}
tank_enemies.__index = tank_enemies
setmetatable(tank_enemies, enemies)

function tank_enemies.new(health, speed, scale)
         local instance = setmetatable({}, enemy)
         local dice = math.random(1, 4)
         if dice == 1 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = 0
         elseif dice == 2 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = love.graphics.getHeight()
         elseif dice == 3 then
                  instance.x = 0
                  instance.y = love.graphics.getHeight() / 2
         elseif dice == 4 then
                  instance.x = love.graphics.getWidth()
                  instance.y = love.graphics.getHeight() / 2
         end
         instance.health = health
         instance.speed = speed
         instance.sprite = "/[-o-/]"
         instance.scale = scale
         return instance
end


speed_enemies = {}
speed_enemies.__index = speed_enemies
setmetatable(speed_enemies, enemies)

function speed_enemies.new(health, speed, scale)
         local instance = setmetatable({}, enemy)
         local dice = math.random(1, 4)
         if dice == 1 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = 0
         elseif dice == 2 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = love.graphics.getHeight()
         elseif dice == 3 then
                  instance.x = 0
                  instance.y = love.graphics.getHeight() / 2
         elseif dice == 4 then
                  instance.x = love.graphics.getWidth()
                  instance.y = love.graphics.getHeight() / 2
         end
         instance.health = health
         instance.speed = speed
         instance.sprite = "/(--/)"
         instance.scale = scale
         return instance
end

boss_enemy = {}
boss_enemy.__index = boss_enemy
setmetatable(boss_enemy, enemies)

function boss_enemy.new(health, speed, scale)
         local instance = setmetatable({}, enemy)
         local dice = math.random(1, 4)
         if dice == 1 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = 0
         elseif dice == 2 then
                  instance.x = love.graphics.getWidth() / 2
                  instance.y = love.graphics.getHeight()
         elseif dice == 3 then
                  instance.x = 0
                  instance.y = love.graphics.getHeight() / 2
         elseif dice == 4 then
                  instance.x = love.graphics.getWidth()
                  instance.y = love.graphics.getHeight() / 2
         end
         instance.health = health
         instance.speed = speed
         instance.sprite = "   ^^^\n   I*I\n\n/(- O -/)"
         instance.scale = scale
         return instance
end
]]