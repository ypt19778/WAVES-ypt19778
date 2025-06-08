audio = {}

function audio:init()
         sounds = {
                  hit = {
                           one = love.audio.newSource('assets/audio/hit_1.mp3', 'static'),
                           two = love.audio.newSource('assets/audio/hit_2.mp3', 'static'),
                           three = love.audio.newSource('assets/audio/hit_3.mp3', 'static')
                  },
                  death = {
                           enemy = {
                                    one = love.audio.newSource('assets/audio/die_1.mp3', 'static'),
                                    two = love.audio.newSource('assets/audio/die_2.mp3', 'static'),
                                    three = love.audio.newSource('assets/audio/die[enemy].mp3', 'static')
                           },
                           player = {
                                    one = love.audio.newSource('assets/audio/die[player].mp3')
                           },
                  },
         }
end