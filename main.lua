require 'menu'
require 'player'
require 'enemy'
require 'orbs'

game = {
         title = "TITLE",
         state = 'menu',
         points = 0
}
function love.load()
         math.randomseed(os.time())
         love.graphics.setDefaultFilter("nearest", "nearest")

         font = love.graphics.newFont('assets/fonts/dogica.ttf')
         score = love.filesystem.read('scoredata.txt', 100)

         menu:init()
         -- format for player : (x, y, speed, health, scale)
         bob = player.new(10, 10, 100, 100, 1)
         table.insert(player, bob)
         dtp = bob:devtools()
         dtp.setSpeed(200)
         dtp.setDamage(100)

         -- format for enemy : (speed, health, type(string), scale)
         james = enemy.new(100, 10, "tst_dummy", 1)
         table.insert(enemy, james)

         -- format for orb : (x, y, points given, size)
         neworb = orbs.new(400, 300, 12, 1)
         table.insert(orbs, neworb)
end

function love.update(dt)
         if game.state == 'menu' then
                  menu:interact()
         end
         if game.state == 'running' then
                  bob:move(dt)
                  james:move(dt, bob.x, bob.y)
                  james:checkDeath()
         end
end

function love.draw()
         if game.state == 'menu' then
                  menu:draw()
         end
         if game.state == 'running' then
                  love.graphics.setColor(1, 1, 1)
                  love.graphics.print("score:"..score, font, love.graphics.getWidth() / 2, 10)
                  bob:draw()
                  love.graphics.setColor(1, 0, 0)
                  james:draw()
                  neworb:draw()
         end
end

function love.keypressed(k)
         if game.state == 'running' then
                  bob:keypressed(k)
         end
         if k == "escape" then
                  love.event.quit()
         end
end