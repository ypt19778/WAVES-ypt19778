player = {}
player.__index = player

function player.new(x, y, speed, health, scale)
         local instance = setmetatable({}, player)
         instance.x = x
         instance.y = y

         instance.defSpeed = speed
         instance.speed = speed
         instance.health = health
         instance.damage = 1

         instance.hitbox = {}
         instance.hitbox.width = 200
         instance.hitbox.height = 100
         instance.hitbox.x = instance.x -- (instance.hitbox.width / 2)
         instance.hitbox.y = instance.y -- (instance.hitbox.height / 2)

         instance.mode = "nil"
         instance.sprite = "(- -)"
         instance.sword_sprite = "(- -)=I=>"
         instance.shield_sprite = "(- -[+]"
         instance.gather_sprite = "(- -)^/^"
         instance.sword_active_sprite = "(> <) \n/\n/////"
         instance.shield_active_sprite = "(> <) \n< # >"
         instance.gather_active_sprite = "(> <)"
         instance.gather_progress = 0
         instance.gather_speed = 1
         instance.gather_limit = 75

         instance.scale = scale

         instance.sword_timer = 0
         return instance
end

function player:move(dt)
         if self.x < 0 then
                  self.x = 0
         elseif self.y < 0 then
                  self.y = 0
         elseif self.x > love.graphics.getWidth() then
                  self.x = love.graphics.getWidth() - 20
         elseif self.y > love.graphics.getHeight() then
                  self.y = love.graphics.getHeight() - 20
         end

         if love.keyboard.isDown("w", "i") then
                  self.y = self.y - self.speed * dt
         elseif love.keyboard.isDown("a", "j") then
                  self.x = self.x - self.speed * dt
         elseif love.keyboard.isDown("s", "k") then
                  self.y = self.y + self.speed * dt
         elseif love.keyboard.isDown("d", "l") then
                  self.x = self.x + self.speed * dt
         end  
         self.hitbox.x = self.x
         self.hitbox.y = self.y

         if self.mode == "sword" then
                  self.sprite = self.sword_sprite
         end
         if self.mode == "shield" then
                  self.sprite = self.shield_sprite
         end
         if self.mode == "pick" then
                  self.sprite = self.gather_sprite
         end

         if love.mouse.isDown("1") or love.keyboard.isDown("x", "space", "m") then
                  --[[
                  THE FOLLOWING CODE NEEDS A REWORK FOR THESE REASONS:
                  IT CAN ONLY CHECK A DAMAGE MARK FOR _ONE_ ENEMY
                  (IT CAN ONLY CHECK FOR ONE)
                  ]]
                  if self.mode == "sword" and self.sword_timer ~= 10 then
                           if self.sword_timer == 1 then
                                    damage_enemy = self:checkCollisions(bob, james)
                                    if damage_enemy == true then
                                             james.health = james.health - self.damage
                                             james.x = james.x - 10
                                    end
                           end
                           self.sword_timer = self.sword_timer + 1
                           self.sprite = self.sword_active_sprite
                  end

                  if self.mode == "shield" then
                           self.speed = self.defSpeed / 2
                           self.sprite = self.shield_active_sprite
                  end    
                  
                  if self.mode == "pick" then
                           self.gather_progress = self.gather_progress + self.gather_speed
                           self.sprite = self.gather_active_sprite
                           if self.gather_progress > self.gather_limit then
                                    self.gather_progress = 0
                                    pickup_orb = self:checkCollisions(bob, neworb)
                                    if pickup_orb == true then
                                             orbs:pickup()
                                    end
                           end
                  end
         else
                  self.speed = self.defSpeed
                  self.sword_timer = 0
                  self.gather_progress = 0
         end
end

function player:draw()
         love.graphics.setColor(1, 1, 1)
         love.graphics.print(self.sprite, font, self.x, self.y)
         if love.keyboard.isDown("tab") then
                  if self.health > 75 then
                           love.graphics.setColor(0, 1, 0)
                  elseif self.health < 75 and self.health > 25 then
                           love.graphics.setColor(245 / 255, 147 / 255, 66 / 255)
                  elseif self.health < 25 then
                           love.graphics.setColor(1, 0, 0)
                  end
                  love.graphics.rectangle("fill", self.x, self.y + 25, self.health, 10)
         end
         love.graphics.setColor(1, 1, 1)
         love.graphics.rectangle("fill", self.x, self.y - 25, self.gather_progress, 10)
         love.graphics.rectangle("line", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
end

function player:keypressed(k)
         if k == "1" then
                  self.mode = "sword"
         elseif k == "2" then
                  self.mode = "shield"
         elseif k == "3" then
                  self.mode = "pick"
         end      
end

function player:checkCollisions(a, b)
         if a.hitbox.x + a.hitbox.width > b.x then
                  if a.hitbox.x < b.x + b.hitbox.width then   
                           if a.hitbox.y + a.hitbox.height > b.y then
                                    if a.hitbox.y < b.y + b.hitbox.height then
                                             return true
                                    end
                           end
                  end
         end
end

function player:devtools()
         tools = {
                  setDamage = function(damage)
                           self.damage = damage
                  end,
                  setSprites = function(sprite, input)
                           self.sprite = input
                  end,
                  setSpeed = function(speed)
                           self.defSpeed = speed
                  end,
                  killall = function(entity)
                           for i, v in ipairs(entity) do
                                    v.state = 'dead'
                           end
                  end
         }   
         return tools 
end