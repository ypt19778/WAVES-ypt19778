menu = {}

function menu:init()
         buttons = {
                  -- format for button: {x, y, width, height, tag}
                  {x = (love.graphics.getWidth() / 2) - 50, y = (love.graphics.getHeight() / 2) - 40, width = 150, height = 30, tag = "START", scale = 1},
                  {x = (love.graphics.getWidth() / 2) - 50, y = (love.graphics.getHeight() / 2) + 60, width = 150, height = 30, tag = "EXIT", scale = 1},
                  {x = (love.graphics.getWidth() / 2) - 50, y = (love.graphics.getHeight() / 2) + 10, width = 225, height = 30, tag = "CUSTOMIZE", scale = 1},
         }
end

function menu:draw()
         love.graphics.print(game.title, (love.graphics.getWidth() / 2) - 150, 100, nil, 10)
         for i, v in ipairs(buttons) do
                  love.graphics.rectangle("line", v.x, v.y, v.width * v.scale, v.height * v.scale)
                  love.graphics.print(v.tag, font, v.x + 5, v.y + 5, nil, v.scale * 2)
         end
end

function menu:interact()
         local mx, my = love.mouse.getPosition()

         for i, v in ipairs(buttons) do
                  if mx > v.x and mx < v.x + v.width and my > v.y and my < v.y + v.height then
                           v.scale = 1.2
                           if love.mouse.isDown("1") then
                                    if v.tag == "EXIT" then
                                             love.event.quit()
                                    end
                                    if v.tag == "START" then
                                             game.state = 'running'
                                    end
                                    if v.tag == "CUSTOMIZE" then
                                             print("this will be added in future updates.")
                                    end
                           end
                  else
                           v.scale = 1
                  end
         end         
end