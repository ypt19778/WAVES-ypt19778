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
                  instance.scorevalue = 2
                  instance.health = health
                  instance.speed = speed
                  instance.sprite = "/(-o-/)"
                  instance.scale = scale
                  instance.stagger = true
         elseif type == "tank" then
                  instance.scorevalue = 5
                  instance.health = health * 2
                  instance.speed = speed / 2
                  instance.sprite = "/[-o-/]"
                  instance.scale = scale * 1.2
                  instance.stagger = true
         elseif type == "speed" then
                  instance.scorevalue = 5
                  instance.health = health / 2
                  instance.speed = speed * 2
                  instance.sprite = "/(--/)"
                  instance.scale = scale
                  instance.stagger = true
         elseif type == "boss" then
                  instance.scorevalue = 10
                  instance.health = health
                  instance.speed = speed
                  instance.sprite = "   ^^^\n   I*I\n\n/(- O -/)"
                  instance.scale = scale * 1.5
                  instance.stagger = false
         elseif type == "tst_dummy" then
                  instance.scorevalue = 0
                  instance.health = health ^ 9
                  instance.speed = speed
                  instance.sprite = "/{ # /}"
                  instance.scale = scale 
                  instance.stagger = false
         end

         instance.hitbox = {}
         instance.hitbox.x = instance.x - 10
         instance.hitbox.y = instance.y - 10
         instance.hitbox.width = 80 * instance.scale
         instance.hitbox.height = 15 * scale

         instance.state = 'alive'
         instance.alpha = 100
         
         instance.debug = {
                  showHitBoxes = false
         }
         return instance
end

function enemy:draw()
         love.graphics.setColor(1, 0, 0, self.alpha)
         love.graphics.print(self.sprite, font, self.x, self.y, nil, self.scale)
         for i, v in ipairs(enemy) do
                  if v.health > 0 then
                           love.graphics.rectangle("fill", v.x, v.y - 40, v.health, 20)
                  end
         end
         if self.debug.showHitBoxes == true then
                  love.graphics.rectangle("line", self.x, self.y, self.hitbox.width, self.hitbox.height)
         end
end

function enemy:checkDeath()
         for i, v in ipairs(enemy) do
                  if v.health < 1 then
                           v:despawn(i) 
                  end
         end
end

function enemy:move(dt, gotox, gotoy)
         local angle = math.atan2(gotoy - self.y, gotox - self.x)

         local cos = math.cos(angle)
         local sin = math.sin(angle)

         self.x = self.x + self.speed * cos * dt
         self.y = self.y + self.speed * sin * dt

         self.hitbox.x = self.x
         self.hitbox.y = self.y
end

function enemy:despawn(mark)
         if self.state ~= 'dead' then
                  self.orb = orbs.new(self.x, self.y, self.scorevalue, self.scale)
         end
         table.insert(orbs, self.orb)
         self.alpha = self.alpha - 100
         self.sprite = "(X X)"
         self.stagger = true
         self.speed = 0
         self.health = 0
         table.remove(enemy, mark)
         self.state = 'dead'       
end 