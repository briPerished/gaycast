local debugMode = {}

local SDL = require("SDL")

local currentCollision = {}

function debugMode.updateCollision(collision)
    currentCollision = collision
end

function debugMode.display(render, map, playerPosition, playerDirection, cameraPlane, fps)
    local width = ScreenWidth / #map[1]
    local height = ScreenHeight / #map


    for mapY, yTable in pairs(map) do
        for mapX, unused in pairs(yTable) do
            if map[mapY][mapX] > 0 then
                render:setDrawColor({r = 255, g = 255, b = 255})
                if map[mapY][mapX] == map[currentCollision[1]][currentCollision[2]] then
                    render:setDrawColor({r = 0, g = 255, b = 0})
                end

                render:drawRect({
                    w = width,
                    h = height,
                    x = ScreenWidth + width * (mapX - 1),
                    y = height * (mapY - 1)
                })
            end
        end
    end

    render:setDrawColor({r = 0, g = 0, b = 255})
    render:drawRect({
        w = 5,
        h = 5,
        x = playerPosition.x * width + ScreenWidth,
        y = playerPosition.y * height
    })
end

return debugMode