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

# cuts every digit into a list of 3 strings
def cut_digits(s)
    lines = s.split("\n"); # 3 * 27 chars
    chunks = []
    digits = []
    lines.each {|l| chunks << l.scan(/.{3}/)}
    for i in 0..8 do
        digits << [chunks[0][i], chunks[1][i], chunks[2][i]]
    end
    return digits
end

# reads a digit and returns it (uses "?" when not valid)
def read_digit(s)
    Numbers.each_with_index {|n,i|
        if (s === n)
            return "#{i}"
        end
    }
    return '?'
end

# reads a number and returns it (see `read_digit`)
def read_number(s)
    value = ''
    cut_digits(s).each {|n|
        value += read_digit(n)
    }
    return value
end

# checks the validity of an account number (String) (User Story 2)
def check_validity(s)
    checksum = 0
    s.reverse.split('').each_with_index {|c,i| checksum += c.to_i*(i+1)}
    return (checksum%11 === 0)
end

# see `read_number` and `check_validity` (User Story 3)
def read_and_check(s)
    n = read_number(s)
    if (/\?/ =~ n)
        return n+' ILL'
    end

    if (!check_validity(n))
        return n+' ERR'
    end

    return n
end

# return an array of possible corrections for the given
# numbers string (User Story 4)
def get_corrections(s)
end

# see `read_and_check` and `get_corrections` (User Story 4)
def read_and_correct(s)
    n = read_and_check(s)
    if ((/\d$/ =~ n)) # OK
        return n
    end

    # ILL / ERR

end
