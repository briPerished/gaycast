local raycast = {}

local SDL = require("SDL")
local math = require("math")
local vector = require("modules/other/vector")

local function getRayDirection(playerDirection, cameraPlane, i)
    local cameraX = 2 * (i / ScreenWidth) - 1
    return vector.addVector(vector.multiplyVectorWithNumber(cameraPlane, cameraX), playerDirection)
end

local function getSideDistance(playerPosition, mapPosition, rayDirection, deltaDistance, step)
    local sideDistance = vector.newVector(0, 0)
    
    if rayDirection.x < 0 then
        step.x = -1
        sideDistance.x = (playerPosition.x - mapPosition.x) * deltaDistance.x
    else
        step.x = 1
        sideDistance.x = (mapPosition.x + 1.0 - playerPosition.x) * deltaDistance.x
    end

    if rayDirection.y < 0 then
        step.y = -1
        sideDistance.y = (playerPosition.y - mapPosition.y) * deltaDistance.y
    else
        step.y = 1
        sideDistance.y = (mapPosition.y + 1.0 - playerPosition.y) * deltaDistance.y
    end

    return sideDistance, step
end

local function getPerpindicularWallDistance(side, sideDistance, deltaDistance)
    if side == 0 then
        return sideDistance.x - deltaDistance.x
    else
        return sideDistance.y - deltaDistance.y
    end
end

local function drawWall(render, perpindicularWallDistance, i, side)
    local wallHeight = math.floor(ScreenHeight / perpindicularWallDistance)
    local wallStart = -wallHeight / 2  + ScreenHeight / 2
    local wallEnd = wallHeight / 2 + ScreenHeight / 2
    local drawColor = {r = 255, g = 0, b = 0}

    if side == 0 then drawColor.r = drawColor.r / 2 end

    if wallStart < 0 then wallStart = 0 end
    if wallEnd >= ScreenHeight then wallEnd = ScreenHeight - 1 end

    local line = {
        x1 = i,
        y1 = wallStart,
        x2 = i,
        y2 = wallEnd
    }

    render:setDrawColor(drawColor)
    render:drawLine(line)
end

function raycast.doRaycast(render, playerPosition, playerDirection, cameraPlane, map)
    for i=1, ScreenWidth, 1 do
        local step = vector.newVector(0, 0)
        local mapPosition = vector.newVector(math.floor(playerPosition.x), math.floor(playerPosition.y))
        local rayDirection = getRayDirection(playerDirection, cameraPlane, i)
        local deltaDistance = vector.newVector(math.abs(1 / rayDirection.x), math.abs(1 / rayDirection.y))
        local sideDistance = getSideDistance(playerPosition, mapPosition, rayDirection, deltaDistance, step)
        local side = nil --NS or EW
        local hit = 0

        --DDA!--
        while hit == 0 do
            if sideDistance.x < sideDistance.y then
                sideDistance.x = sideDistance.x + deltaDistance.x
                mapPosition.x = mapPosition.x + step.x 
                side = 0
            else
                sideDistance.y = sideDistance.y + deltaDistance.y
                mapPosition.y = mapPosition.y + step.y
                side = 1
            end

            if map[mapPosition.y + 1][mapPosition.x + 1] > 0 then
                hit = 1
            end
        end
        --DDA!--

        
        local perpindicularWallDistance = getPerpindicularWallDistance(side, sideDistance, deltaDistance)
        drawWall(render, perpindicularWallDistance, i, side)
    end
end

return raycast