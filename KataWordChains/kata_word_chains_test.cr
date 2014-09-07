require "./tests"
require "./kata_word_chains"

ts = TestsSuite.new "KataWordChains"

ts.run do |tr|
  include KataWordChains

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
    t.assert_false(Dict.new(["foo"]))
  end

  tr.test(".empty -- true") do |t|
    t.assert_true(Dict.new([] of String))
  end

  # Helpers

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

end
