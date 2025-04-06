local SDL = require("SDL")
local render = require("modules/render/render")
local vector = require("modules/other/vector")
local player = require("modules/other/player")

local raycast = render.raycast

ScreenWidth = 640
ScreenHeight = 480
Title = "Gaycast"

local win = nil
local render = nil
local playerMoveSpeed = nil
local playerRotationSpeed = nil

local currentMap = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}
local playerPosition = vector.newVector(5, 7)
local playerDirection = vector.newVector(-1, 0)
local cameraPlane = vector.newVector(0, 0.66) --should be perp to playerDirection
local running = false

local function init()
    assert(SDL.init(SDL.flags.Video, SDL.flags.Audio))
    win = assert(SDL.createWindow{
        title = Title,
        width = ScreenWidth,
        height = ScreenHeight,
        x = 126,
        y = 126
    })
    render = assert(SDL.createRenderer(win, 0, 0))

    running = true
end

local function main()
    while running do
        local startTime = SDL.getTicks()

        for e in SDL.pollEvent() do
            if e.type == SDL.event.Quit then
                running = false
            end
        end
        render:clear()

        raycast.doRaycast(render, playerPosition, playerDirection, cameraPlane, currentMap)
        render:setDrawColor({r = 0, g = 0, b = 0})

        local frameTime = (SDL.getTicks() - startTime) / 1000
        local fps = 1 / frameTime

        playerMoveSpeed = 1.0 * frameTime
        playerRotationSpeed = 3.0 * frameTime

        keys = SDL.getKeyboardState()

        playerPosition = player.doMovement(keys, playerPosition, playerDirection, playerMoveSpeed, currentMap)
        playerDirection, cameraPlane = player.doRotation(keys, playerDirection, cameraPlane, playerRotationSpeed)

        print(fps)
        render:present()
    end
end

local function exit()
    SDL.quit()
end

init()
main()
exit()