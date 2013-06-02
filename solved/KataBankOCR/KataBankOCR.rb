#! /usr/bin/ruby

NUMBERS = [
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
    digits
end

# reads a digit and returns it (uses "?" when not valid)
def read_digit(s)
    d = NUMBERS.index s
    d ? d.to_s : '?'
end

# reads a number and returns it (see `read_digit`)
def read_number(s)
    cut_digits(s).inject('') do |d, n|
        d << read_digit(n)
    end
end

# checks the validity of an account number (String) (User Story 2)
def check_validity(s)
    checksum = 0
    s.reverse.split('').each_with_index {|c,i| checksum += c.to_i*(i+1)}
    return (checksum % 11 === 0)
end

# see `read_number` and `check_validity` (User Story 3)
def read_and_check(s)
    n = read_number(s)
    return n + ' ILL' if /\?/ =~ n
    return n + ' ERR' if !check_validity(n)
    n
end

# tests if the two given digits are differents and if
# the only one difference is a pipe or an undescore
def diff_digits(d1, d2)
    return false if d1 === d2
    
    for l in 0..2 do # for each line

        next if d1[l] === d2[l]

        for c in 0..2 do # for each column
            next if d1[l][c] === d2[l][c]
            d = Marshal.load(Marshal.dump(d1)) # clone the array
            if (d[l][c] === ' ') # toggle the character between '|'/'_' and ' '
                if (c === 1) # if its the middle character
                    d[l][c] = '_'
                elsif (l != 0)
                    d[l][c] = '|'
                end
            else
                d[l][c] = ' '
            end
            return true if (d === d2) # check if ok
        end
    end
    false
end

# return an array of possible corrections for the
# given number, adding or removing one pipe or undescore
def possible_digit_correction(d)
    corrects = []
    NUMBERS.each_index do |n|
        corrects << n if (diff_digits(d, NUMBERS[n]))
    end
    corrects
end

# return an array of possible corrections for the given
# numbers string (User Story 4)
def get_corrections(s)
    tmp = []
    
    s.each do |d|
        possibs = possible_digit_correction(d)
        d_digit = read_digit(d)
        possibs << d_digit if d_digit != '?'
        tmp << possibs
    end
    n = (s.map {|e| read_digit(e)}).join

    corrections = []

    tmp.each_index do |i|
        tmp[i].each do |p|
            n2 = n[0,i] + "#{p}" + n[i+1,n.length]
            corrections << n2 if /\?/ !~ n2 && check_validity(n2)
        end
    end
    corrections.sort
end

# see `read_and_check` and `get_corrections` (User Story 4)
def read_and_correct(s)
    n = read_and_check(s)
    return n if /\d$/ =~ n # no ILL nor ERR : OK

    n = n[/\d+/]

    # ILL / ERR
    c = get_corrections(cut_digits(s))

    return n + ' ILL' if (c.length === 0)
    return c[0] if (c.length === 1)

    n +' AMB ' + c.inspect.gsub(/"/,'\'')
end
