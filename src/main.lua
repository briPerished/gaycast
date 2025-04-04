--[[

:3

]]

--REQUIRES--
local SDL = require("SDL")

--REQUIRES--
local input = require("input.lua")

--BLANK VARIABLE DEFS--
local win = nil
--BLANK VARIABLE DEFS---

ScreenWidth = 640
ScreenHeight = 480
Title = "Gaycast"

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

    running = true
end

local function main()
    while running do
        for e in SDL.pollEvent() do
            if e.type == SDL.event.Quit then
                running = false
            end
        end
    end
end

local function exit()
    SDL.quit()
end

init()
main()
exit()