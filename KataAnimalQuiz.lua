#! /usr/bin/lua

-- utils
function yes()
    local resp
    repeat
        resp = io.read()
    until (resp == 'y') or (resp == 'n')
    return (resp == 'y')
end

-- returns 'a' or 'an'
function article(noun)
    if (type(noun) == 'table') then
       noun = noun.value or noun.name 
    end
   if (string.find(noun, '^[aeiouAEIOU]')) then
       return 'an'
   end
   return 'a'
end

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
    print(self.string .. ' (y/n) ')

    if yes() then
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
function Node:make_question(q_string, y_resp, n_resp)
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

function Quiz.create_question(q_string, y_resp, n_resp)
    return Question.create(q_string, y_resp, n_resp)
end

function Quiz:ask()
    return Question.ask(self.current_node.value)
end

function Quiz:answer()
    print("It's a " .. self.current_node.value.name .. ".")
    print("Am I right? (y/n) ")

    if not yes() then
        local old_value = self.current_node.value.name
        print("You win. What were you thinking of? ")
        local good_value = io.read()
        print("Give me a question to distinguish "
              .. article(good_value) .. " " .. good_value
              .. " from " .. article(old_value) .. " " .. old_value .. ".")
        local q_s = io.read()
        print("For " .. article(good_value) .. " " .. good_value
              .. ", what is the answer to your question")

        if (yes()) then
            Node.make_question(self.current_node,
                               Node.create(Animal.create(good_value)),
                               Node.create(Animal.create(old_value)))
        else
            Node.make_question(self.current_node,
                               Node.create(Animal.create(old_value)),
                               Node.create(Animal.create(good_value)))
        end
    end

    print("Play again? (y/n) ")
    if yes() then
        Quiz.start(self)
    end

    return self.current_node.value.name
end

function Quiz:next()
    if (self.current_node.value.is_a == 'Animal') then
        return Quiz.answer(self)
    else -- if self.current_node.value.is_a == 'Question'
        self.current_node = Quiz.ask(self)
    end
end

function Quiz:init()
    self.current_node = self.root
end

function Quiz:start()
    Quiz.init(self)
    print("Think of an animal…\n")
    return Quiz.next(self)
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
