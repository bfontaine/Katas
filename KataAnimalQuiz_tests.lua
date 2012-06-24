#! /usr/bin/lua

local quiz = require 'KataAnimalQuiz'
local lunit = require 'lunitx'

_ENV = lunit.module('enhanced','seeall')

function setup()
    quiz.init()
end

function test_init_nil()
    local animals = quiz.getAnimals()

    assert_table(animals)
    assert_equal(0, #animals)
end

function test_init_number()
    quiz.init(42)
    local animals = quiz.getAnimals()

    assert_table(animals)
    assert_equal(0, #animals)
end

function test_init_ok()
    quiz.init('dog')
    local animals = quiz.getAnimals()

    assert_table(animals)
    assert_equal('dog', animals[1])
end
