#! /usr/bin/lua

local quiz = {}

local animals = {}

function quiz.init(animal)
    if (type(animal) == 'string') then animals = { animal } end
end

function quiz.getAnimals()
    return animals
end

return quiz
