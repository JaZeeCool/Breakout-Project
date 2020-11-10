--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] = love.graphics.newQuad(
                x * tilewidth,
                y * tileheight,
                tilewidth,
                tileheight,
                atlas:getDimensions()
            )

            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--[[
    Utility function for slicing tables, a la Python.
]]
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

--[[
    This function is specifically made to piece out the bricks from the
    sprite sheet.
]]
function GenerateQuadsBricks(atlas)
    local x = 0
    local y = 0
    local counter = 1
    local quads = {}
    
    -- get all the colored bricks
    for i = 0, 5 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        x = x + 32
        y = 0
        counter = counter + 1
    end
    x = 0
    y = 16

    for i = 0, 5 do 
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        x = x + 32
        counter = counter + 1
    end

    x = 0 
    y = 32

    for i = 0, 5 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        x = x + 32
        counter = counter + 1
    end

    x = 0
    y= 48

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        x = x + 32
        counter = counter + 1
    end

    -- get the locked brick
    x = 160
    quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
    return quads
end


--[[
    This function is specifically made to piece out the paddles from the
    sprite sheet. For this, we have to piece out the paddles a little more
    manually, since they are all different sizes.
]]
function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 8

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- Smallest
        quads[counter] = love.graphics.newQuad(
            x, y, 32, 16, atlas:getDimensions()
        )

        counter = counter + 1

        -- Medium
        quads[counter] = love.graphics.newQuad(
            x + 32, y, 64, 8, atlas:getDimensions()
        )

        counter = counter + 1

        -- Large
        quads[counter] = love.graphics.newQuad(
            x + 96, y, 96, 16, atlas:getDimensions()
        )

        counter = counter + 1

        -- Huge
        quads[counter] = love.graphics.newQuad(
            x, y + 16, 128, 16, atlas:getDimensions()
        )

        counter = counter + 1

        -- Prepare X and Y for the next set of paddles
        x = 0
        y = y + 32
    end

    return quads
end

--[[
    This function is specifically made to piece out the balls from the
    sprite sheet. For this, we have to piece out the balls a little more
    manually, since they are in an awkward part of the sheet and small.
]]
function GenerateQuadsBalls(atlas)
    local x = 0
    local y = 16

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())

        x = x + 8

        counter = counter + 1
    end

    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())

        x = x + 8

        counter = counter + 1
    end

    return quads
end

function GenerateQuadsPowerUps(atlas)
    local x = 0
    local y = 192

    local quads = {}

    local counter = 1

    for i = 0, 9 do
        quads[counter] = love.graphics.newQuad(16 * i, y, 16, 16, atlas:getDimensions())

        counter = counter + 1
    end

    return quads
end