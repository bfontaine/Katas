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

# tests if the two given digits are differents and if
# the only one difference is a pipe or an undescore
def diff_digits(d1, d2)
    return false if (d1 === d2)
    
    for l in 0..2 do # for each line

        if (d1[l] === d2[l])
            next
        end

        for c in 0..2 do # for each column
            if (d1[l][c] === d2[l][c])
                next
            end
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
    return false
end

# return an array of possible corrections for the
# given number, adding or removing one pipe or undescore
def possible_digit_correction(d)
    corrects = []
    Numbers.each_index {|n|
        corrects << n if (diff_digits(d, Numbers[n]))
    }
    return corrects
end

# return an array of possible corrections for the given
# numbers string (User Story 4)
def get_corrections(s)
    tmp = []
    
    s.each {|d|
        possibs = possible_digit_correction(d)
        d_digit = read_digit(d)
        possibs << d_digit if (d_digit != '?')
        tmp << possibs
    }
    n = (s.map {|e| read_digit(e)}).join

    corrections = []

    tmp.each_index {|i|
        tmp[i].each {|p|
            n2 = n[0,i] + "#{p}" + n[i+1,n.length]
            if (!(/\?/ =~ n2) && check_validity(n2))
                corrections << n2
            end
        }
    }
    return corrections.sort
end

# see `read_and_check` and `get_corrections` (User Story 4)
def read_and_correct(s)
    n = read_and_check(s)
    if ((/\d$/ =~ n)) # no ILL nor ERR : OK
        return n
    end

    n = n[/\d+/]

    # ILL / ERR
    c = get_corrections(cut_digits(s))

    if (c.length === 0)
        return n+' ILL'
    end

    if (c.length === 1)
        return c[0]
    end

    return n+" AMB #{c.inspect}".gsub(/"/,'\'')
end
