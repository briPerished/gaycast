local player = {}

local SDL = require("SDL")
local math = require("math")

function player.doMovement(keys, position, direction, cameraPlane, moveSpeed, map)
    if keys[SDL.scancode.W] then
        if map[math.floor(position.y) + 1][1 + math.floor(position.x + direction.x * moveSpeed)] < 1 then
            position.x = position.x + direction.x * moveSpeed
        end
        if map[1 + math.floor(position.y + direction.y * moveSpeed)][math.floor(position.x) + 1] < 1 then
            position.y = position.y + direction.y * moveSpeed
        end
    end

    if keys[SDL.scancode.S] then
        if map[math.floor(position.y) + 1][1 + math.floor(position.x - direction.x * moveSpeed)] < 1 then
            position.x = position.x - direction.x * moveSpeed
        end
        if map[1 + math.floor(position.y - direction.y * moveSpeed)][math.floor(position.x) + 1] < 1 then
            position.y = position.y - direction.y * moveSpeed
        end
    end

    if keys[SDL.scancode.A] then
        if map[math.floor(position.y) + 1][1 + math.floor(position.x - cameraPlane.x * moveSpeed)] < 1 then
            position.x = position.x - cameraPlane.x * moveSpeed
        end
        if map[1 + math.floor(position.y - cameraPlane.y * moveSpeed)][math.floor(position.x) + 1] < 1 then
            position.y = position.y - cameraPlane.y * moveSpeed
        end
    end

    if keys[SDL.scancode.D] then
        if map[math.floor(position.y) + 1][1 + math.floor(position.x + cameraPlane.x * moveSpeed)] < 1 then
            position.x = position.x + cameraPlane.x * moveSpeed
        end
        if map[1 + math.floor(position.y + cameraPlane.y * moveSpeed)][math.floor(position.x) + 1] < 1 then
            position.y = position.y + cameraPlane.y * moveSpeed
        end
    end

    return position
end

function player.doRotation(keys, direction, cameraPlane, rotationSpeed)
    local oldDirectionX = direction.x
    local oldCameraPlaneX = cameraPlane.x

    if keys[SDL.scancode.Right] then
        direction.x = direction.x * math.cos(-rotationSpeed) - direction.y * math.sin(-rotationSpeed)
        direction.y = oldDirectionX * math.sin(-rotationSpeed) + direction.y * math.cos(-rotationSpeed)
        cameraPlane.x = cameraPlane.x * math.cos(-rotationSpeed) - cameraPlane.y * math.sin(-rotationSpeed)
        cameraPlane.y = oldCameraPlaneX * math.sin(-rotationSpeed) + cameraPlane.y * math.cos(-rotationSpeed)
    end

    if keys[SDL.scancode.Left] then
        direction.x = direction.x * math.cos(rotationSpeed) - direction.y * math.sin(rotationSpeed)
        direction.y = oldDirectionX * math.sin(rotationSpeed) + direction.y * math.cos(rotationSpeed)
        cameraPlane.x = cameraPlane.x * math.cos(rotationSpeed) - cameraPlane.y * math.sin(rotationSpeed)
        cameraPlane.y = oldCameraPlaneX * math.sin(rotationSpeed) + cameraPlane.y * math.cos(rotationSpeed)
    end

    return direction, cameraPlane
end

return player