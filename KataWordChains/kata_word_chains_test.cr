require "./tests"
require "./kata_word_chains"

ts = TestsSuite.new "KataWordChains"

ts.run do |tr|
  include KataWordChains

  empty_dict = Dict.new([] of String)

  english_dict = Dict.new(["cat", "cog", "cag", "dog"])

  # Dict class

  tr.test("dict: initialize with a set of words") do |t|
    words = Set.new(["foo", "bar"])
    d = Dict.new(words)

    t.assert_equal(words, d.words)
  end

  tr.test(".pop -- one word") do |t|
    words = Set.new(["foo", "bar"])
    d = Dict.new(words)

    t.assert_equal(Dict.new(["foo"]).words, d.pop("bar").words)
    t.assert_equal(Dict.new(["bar"]).words, d.pop("foo").words)

    t.assert_equal(Dict.new([] of String).words, d.pop("foo").pop("bar").words)
  end

  tr.test(".pop -- multiple words") do |t|
    words = Set.new(["foo", "bar", "qux"])
    d = Dict.new(words)

    t.assert_equal(Dict.new(["foo"]).words, d.pop(["bar", "qux"]).words)
    t.assert_equal(Dict.new(["bar"]).words, d.pop(["foo", "qux"]).words)
  end

  tr.test(".empty -- false") do |t|
    t.assert_false(Dict.new(["foo"]).empty?)
  end

  tr.test(".empty -- true") do |t|
    t.assert_true(Dict.new([] of String).empty?)
  end

  # Chain class

  tr.test("Chain.new -- one word") do |t|
    t.assert_equal(["foo"], Chain.new("foo", empty_dict).words)
  end

  tr.test("Chain#successors -- none, empty dict") do |t|
    t.assert_equal([] of Chain, Chain.new("foo", empty_dict).successors)
  end

  tr.test("Chain#successors -- none") do |t|
    t.assert_equal([] of Chain, Chain.new("foo", english_dict).successors)
  end

  tr.test("Chain#successors") do |t|
    ch = Chain.new("dog", english_dict)
    ch2 = Chain.new(["dog", "cog"], english_dict.pop("dog"))

    t.assert_equal([ch2], ch.successors)
  end

  # KataWordChains module

  tr.test("differ_by_one_letter? -- empty words") do |t|
    t.assert_false(differ_by_one_letter?("", ""))
  end

  tr.test("differ_by_one_letter? -- same word") do |t|
    word = "foobarqux"
    t.assert_false(differ_by_one_letter?(word, word))
  end

  tr.test("differ_by_one_letter? -- false") do |t|
    t.assert_false(differ_by_one_letter?("foobar1", "moobar2"))
  end

  tr.test("differ_by_one_letter? -- true") do |t|
    t.assert_true(differ_by_one_letter?("a", "b"))
    t.assert_true(differ_by_one_letter?("ab", "bb"))
    t.assert_true(differ_by_one_letter?("cab", "cbb"))
    t.assert_true(differ_by_one_letter?("ca", "cb"))
  end


  tr.test("successors -- none, empty dict") do |t|
    t.assert_equal([] of String, successors("foo", empty_dict))
  end

  tr.test("successors -- none") do |t|
    t.assert_equal([] of String, successors("foo", english_dict))
  end

  tr.test("successors") do |t|
    t.assert_equal(["cag", "dog"], successors("cog", english_dict))
  end


  tr.test("chain -- direct") do |t|
    t.assert_equal(["cat", "cag"], chain("cat", "cag", english_dict))
  end

  tr.test("chain -- no result") do |t|
    t.assert_nil(chain("cat", "dig", english_dict))
  end

  tr.test("chain -- no result, maxlen") do |t|
    t.assert_nil(chain("cat", "dog", english_dict, 3))
  end

  tr.test("chain") do |t|
    t.assert_equal(["cat", "cag", "cog", "dog"],
                   chain("cat", "dog", english_dict))
  end

end
