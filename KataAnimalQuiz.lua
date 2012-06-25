#! /usr/bin/lua

-- Animal ---------------------

local Animal = {}
Animal.__index = Animal

function Animal.create(name)
    local a = {}
    setmetatable(a, Animal)
    a.name = name
    a.is_a = 'Animal'
    return a
end

-------------------------------
-- Question -------------------

local Question = {}
Question.__index = Question

function Question.create(s, y_resp, n_resp)
    local q = {}
    setmetatable(q, Question)
    q.string = s
    q.y_resp = y_resp
    q.n_resp = n_resp
    q.is_a = 'Question'
    return q
end

function Question:ask()
    local resp
    print(self.string .. '? (y/n) ')
    repeat
       resp = io.read() 
    until (resp == 'y') or (resp == 'n')

    if (resp == 'y') then
        return self.y_resp
    end
    return self.n_resp
end

-------------------------------
-- Node -----------------------

local Node = {}
Node.__index = Node

function Node.create(value)
    local n = {}
    setmetatable(n, Node)
    n.value = value
    return n
end

-- change current value into a question
function Node:Make_question(q_string, y_resp, n_resp)
   self.value = Question.create(q_string, y_resp, n_resp) 
end

-------------------------------
-- Quiz -----------------------

local Quiz = {}
Quiz.__index = Quiz

function Quiz.create(root)
    local q = {}
    local n
    setmetatable(q, Quiz)
    if (type(root) == 'string') then
        n = Node.create(Animal.create(root))
    else if (type(root_node) == 'table') then
            n = Node.create(root)
         else
             return nil
         end
    end
    q.root = n
    q.current_node = n
    return q
end

function Quiz.create_animal(name)
    return Animal.create(name)
end

function Quiz:ask()
    return self.current_node.ask()
end

function Quiz:answer()
    print("It's a " .. self.current_node.value.name)
    -- TODO ask if it's the good answer
end

function Quiz:next()
    if (self.current_node.value.is_a == 'Animal') then
        self.answer()
    else -- if self.current_node.value.is_a == 'Question'
        self.current_node = self.ask()
    end
end

function Quiz:run()
    self.next()
end

-------------------------------

--[[
    TODO:
        - add a .load() and .dump() functions to load/dump "database" (animals)
          into a file (just for fun)
        - use a tree structure to store animals, e.g.:
                            Q1
                          y/  \n
                          A1   Q2
                             y/ \n
                             A2  A3
          
          with Qx = questions, Ax = animals (y: yes, n: no)
]]

return Quiz
