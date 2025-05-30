require 'menu'
require 'player'
require 'enemy'

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
         -- format for player : (x, y, speed, health, scale)dwda
         bob = player.new(10, 10, 100, 100, 1)

         -- format for enemy : (speed, health, type(string), scale)
         james = enemy.new(100, 1, "def", 1)
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