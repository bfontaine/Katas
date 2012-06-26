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
