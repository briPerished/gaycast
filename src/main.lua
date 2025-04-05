local SDL = require("SDL")
local render = require("modules/render/render")
local vector = require("modules/other/vector")

local raycast = render.raycast

ScreenWidth = 640
ScreenHeight = 480
Title = "Gaycast"

local win = nil
local render = nil

local currentMap = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 1, 1, 1, 0, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
}
local playerPosition = vector.newVector(5, 5)
local playerDirection = vector.newVector(0, 0)
local cameraPlane = vector.newVector(0, 0) --should be perp to playerDirection
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
    render:setDrawColor({255, 0, 0})

    running = true
end

local function main()
    while running do
        for e in SDL.pollEvent() do
            if e.type == SDL.event.Quit then
                running = false
            end
        end
        render:clear()
        raycast.doRaycast(render, playerPosition, playerDirection, cameraPlane, currentMap)
    end
end

local function exit()
    SDL.quit()
end

init()
main()
exit()