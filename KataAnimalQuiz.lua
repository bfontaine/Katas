#! /usr/bin/lua

local quiz = {}

local animals = {}

function quiz.init(animal)
    if (type(animal) == 'string') then animals = { animal } end
end

function quiz.getAnimals()
    return animals
end

--[[
    TODO:
        - add a .load() and .dump() functions to load/dump "database" (animals)
          into a file
        - use a tree structure to store animals, e.g.:
                            Q1
                          y/  \n
                          A1   Q2
                             y/ \n
                             A2  A3
          
          with Qx = questions, Ax = animals (y: yes, n: no)
]]

return quiz
