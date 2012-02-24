#! /usr/bin/ruby

Numbers = [
    [' _ ', '| |', '|_|'], # 0
    ['   ', '  |', '  |'], # 1
    [' _ ', ' _|', '|_ '], # 2
    [' _ ', ' _|', ' _|'], # 3
    ['   ', '|_|', '  |'], # 4
    [' _ ', '|_ ', ' _|'], # 5
    [' _ ', '|_ ', '|_|'], # 6
    [' _ ', '  |', '  |'], # 7
    [' _ ', '|_|', '|_|'], # 8
    [' _ ', '|_|', ' _|']  # 9
]

# cut every digit into a list of 3 strings
def cut_digits(s)
    lines = s.split("\n"); # 3 * 27 chars
    chunks = []
    digits = []
    lines.each {|l| chunks << l.scan(/.{3}/)}
    for i in 0..9 do
        digits << [chunks[0][i], chunks[1][i], chunks[2][i]]
    end
end

def read_digit(s)
    Numbers.each_with_index {|n,i|
        if (s === n)
            return i
        end
    }
end

def read_number(s)
    value = ''
    cut_digits(s).each {|n|
        value += read_digit(n)
    }
    return value
end
