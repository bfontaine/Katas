#! /usr/bin/lua

local Quiz = require 'KataAnimalQuiz'
local lunit = require 'lunitx'

_ENV = lunit.module('enhanced','seeall')

local quiz

local _io_read = io.read
local _print = print

-- mock

function noprint()
    print = function() end
end

function say(resps)
    local next_resps = {}
    local index = 0

    if (type(resps) == 'table' and #resps > 0) then
        next_resps = resps

        io.read = function()
            index = index + 1
            if (index <= #next_resps) then
                print(next_resps[index])
                return next_resps[index]
            else
                return _io_read()
            end
        end
    end
end

-- setup

function setup()
    quiz = Quiz.create('dog')
    -- noprint()
end

-- creation

function test_create_nil()
    assert_nil(Quiz.create())
end

function test_create_number()
    assert_nil(Quiz.create(42))
end

function test_create_ok()
    assert_table(quiz)
    assert_table(quiz.root)
    assert_table(quiz.root.value)
    assert_equal('dog', quiz.root.value.name)
    assert_equal('Animal', quiz.root.value.is_a)
end

-- initialization

function test_init()
    Quiz.init(quiz)
    assert_table(quiz.current_node)
    assert_table(quiz.current_node.value)
    assert_equal('dog', quiz.root.value.name)
    assert_equal('dog', quiz.current_node.value.name)
end

-- asking

function test_ask_root_yes()
    say({ 'y', 'n' }) -- yes it's a dog, no I don't want to play again
    assert_equal('dog', Quiz.start(quiz))
end

function test_ask_root_yes_replay()
    -- yes it's a dog, yes I want to play again, yes it's still a dog, and no
    -- I don't want to play again
    say({ 'y', 'y', 'y', 'n' })
    assert_equal('dog', Quiz.start(quiz))
end

function test_ask_root_no()
    -- no it's not a dog, it's a pig and I don't want to play again
    say({ 'n', 'pig', 'is it pink?', 'y', 'n' })
    assert_equal(false, Quiz.start(quiz))
end

function test_ask_root_no_replay()
    -- no it's not a dog, it's a pig, yes I want to play again,
    -- yes it's pink, yes it's a pig, no I don't want to play again
    say({ 'n', 'pig', 'is it pink?', 'y', 'y', 'y', 'y', 'n' })
    assert_equal('pig', Quiz.start(quiz))
end

function test_5_animals()
    -- 1) it's not a dog, it's pink     -> a pig (play again)
    -- 2) it's not pink, it eats mouses -> a cat (play again)
    -- 3) it's not pink nor eats mouses, it's grey -> an elephant (play again)
    -- 4) it's not pink nor eats mouses, it's grey -> it's an elephant
    say({           'n', 'pig', 'is it pink?',         'y', 'y',
               'n', 'n', 'cat', 'does it eat mouses?', 'y', 'y',
          'n', 'n', 'n', 'elephant', 'is it grey?',    'y', 'y',
     'n', 'n', 'y', 'y', 'n'})
    assert_equal('elephant', Quiz.start(quiz))
end
