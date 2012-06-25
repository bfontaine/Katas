#! /usr/bin/lua

local Quiz = require 'KataAnimalQuiz'
local lunit = require 'lunitx'

_ENV = lunit.module('enhanced','seeall')

local quiz

function setup()
    -- quiz = Quiz.create('...')
end

function test_init_nil()
    assert_nil(Quiz.create())
end

function test_init_number()
    assert_nil(Quiz.create(42))
end

function test_init_ok()
    quiz = Quiz.create('dog')

    assert_table(quiz)
    assert_table(quiz.root)
    assert_table(quiz.root.value)
    assert_equal('dog', quiz.root.value.name)
    assert_equal('Animal', quiz.root.value.is_a)
end
