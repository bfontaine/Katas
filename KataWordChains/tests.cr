# AFAIK Crystal doesn't have any builtin test module for now
# This is a simple test module:
#   ts = TestSuite.new
#   ts.run do |tr|
#
#     tr.test("test name") do |t|
#       t.assert_equal(2, 3) # error
#       t.assert_equal(2, 2) # ok
#     end
#
#   end

class AssertError < Exception
end

class TestsRunner
  def initialize
    @tests = 0
    @asserts = 0
    @good = 0
  end

  def assert(text, &block)
    @asserts += 1
    raise AssertError.new(text) unless block.call()
  end

  def assert_equal(ref, value)
    assert("#{ref} != #{value}") { ref == value }
  end

  def assert_true(value)
    assert("#{value} is not truthy") { value }
  end

  def assert_false(value)
    assert("#{value} is not falsy") { !value }
  end

  def test(name="", &block)
    @tests += 1
    begin
      yield self
    rescue e : AssertError
      puts "ERROR #{name}: #{e}"
    else
      @good += 1
    end
  end

  def results
    bad = @tests - @good
    "Run #{@tests} tests (#{@asserts} assertions), #{@good} good, #{bad} bad."
  end
end

class TestsSuite
  def initialize(@name=nil)
  end

  def run(&block)
    tr = TestsRunner.new
    yield tr
    puts "#{@name || "Tests"}:"
    puts "  #{tr.results}"
  end
end

$TESTS = true
