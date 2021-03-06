PaddleSelectState = Class{__includes = BaseState}

function PaddleSelectState:enter(params)
    self.highScores = params.highScores
end

function PaddleSelectState:init()
    -- The paddle we're highlighting, will be passed to the serve state when we press Enter
    self.currentPaddle = 1
end

function PaddleSelectState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.currentPaddle == 1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()

            self.currentPaddle = self.currentPaddle - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.currentPaddle == 4 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()

            self.currentPaddle = self.currentPaddle + 1
        end
    end

    -- Select paddle and move on to the serve state, passing in the selection
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gSounds['confirm']:play()

        gStateMachine:change('serve', {
            paddle = Paddle(self.currentPaddle),
            bricks = LevelMaker.createMap(1),
            health = 3,
            score = 0,
            highScores = self.highScores,
            level = 1,
            recoverPoints = 500
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PaddleSelectState:render()
    -- Instructions
    love.graphics.setFont(gFonts['medium'])

    love.graphics.printf("Select your paddle with left and right!", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])

    love.graphics.printf("(Press Enter to continue!)", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- Left arrow should render normally if we're higher than 1, else
    -- in a shadowy form to let us know we're as far left as we can go
    if self.currentPaddle == 1 then
        -- Tint, give it a dark gray with half opacity
        love.graphics.setColor(40, 40, 40, 128)
    end

    love.graphics.draw(
        gTextures['arrows'],
        gFrames['arrows'][1],
        VIRTUAL_WIDTH / 4 - 24,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )

    -- Reset drawing color to full white for proper rendering
    love.graphics.setColor(255, 255, 255, 255)

    -- Right arrow should render normally if we're less than 4, else
    -- in a shadowy form to let us know we're as far right as we can go
    if self.currentPaddle == 4 then
        -- Tint, give it a dark gray with half opacity
        love.graphics.setColor(40, 40, 40, 128)
    end

    love.graphics.draw(
        gTextures['arrows'],
        gFrames['arrows'][2],
        VIRTUAL_WIDTH - VIRTUAL_WIDTH / 4,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )

    -- Reset drawing color to full white for proper rendering
    love.graphics.setColor(255, 255, 255, 255)

    -- Draw the paddle itself, based on which we have selected
    love.graphics.draw(
        gTextures['main'],
        gFrames['paddles'][2 + 4 * (self.currentPaddle - 1)],
        VIRTUAL_WIDTH / 2 - 32,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )
end
