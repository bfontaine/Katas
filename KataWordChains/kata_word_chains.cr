# Kata Word Chains
# see http://codekata.com/kata/kata19-word-chains/

# an unordered dictionnary with words of a fixed length
class Dict

  # words set
  getter :words

  # initialize a Dict from a file
  def initialize(lang : String, @len)
    @words = Set.new([] of String)
    File.each_line("dicts/#{lang}.txt") do |word|
      word = word.strip
      @words << word if word.length == len
    end
  end

  def initialize(@words)
  end

  # return a new dictionnary without one word
  def pop(word)
    pop([word])
  end

  def pop(words)
    Dict.new(@words.reject { |w| words.includes?(w) })
  end

  def empty?
    @words.empty?
  end
end

def differ_by_one_letter?(word1, word2)
  return false if word1 == word2
  diff = 0
  # String#each_char_with_index should be available in Crystal 0.4.4
  i, max = 0, word1.length
  while i < max
    c1, c2 = word1[i], word2[i]
    i += 1
    next if c1 == c2
    diff += 1
    return false if diff > 1
  end
  true
end

# return all possible successors for a word (`ref`). Those are words from a
# dictionnary (`dict`) that differ from the reference word by only one letter.
def successors(ref, dict)
  dict.words.select do |word|
    differ_by_one_letter?(ref, word)
  end
end

# return a words chain between word1 and word2
def chain(word1, word2, dict)
  chs = Set.new([[word1]])

  possible = true

  # TODO class Chain, a list of words (the chain) and its current dictionnary
  # since we have to maintain one dictionnary per chain
  while possible
    chs.each do |ch|
      last = ch.last

      return ch if last == word2

      dict = dict.pop(last)
      possible = false
      next if dict.empty?
      possible = true

      chs.delete ch

      successors(last, dict).each do |succ|
        chs << ch.clone.push(succ)
      end
    end
  end

  nil
end

# run the program with both words
def run(word1, word2)
  len = word1.length
  if word2.length != len
    puts "Error: Both words should have the same length."
    return 1
  end
  english = Dict.new("english", len)
  result = chain(word1, word2, english)
  if result
    result.each do |word|
      puts word
    end
  else
    puts "No chain between '#{word1}' and '#{word2}'."
  end
  0
end

unless $TESTS
  if ARGV.length != 2
    # re the executable's name, see:
    # https://groups.google.com/forum/#!topic/crystal-lang/ztgcRSkY__I
    puts "Usage:\n\t./kata_word_chains <word1> <word2>\n"
    exit 1
  end

  word1, word2 = ARGV
  exit run(word1, word2)
end
