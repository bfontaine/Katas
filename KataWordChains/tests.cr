$TESTS = true

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
    @good = 0
  end

  def assert_equal(ref, value)
    raise AssertError.new("#{ref} != #{value}") if ref != value
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
    "Run #{@tests} tests, #{@good} good, #{bad} bad."
  end
end

class TestsSuite
  def run(&block)
    tr = TestsRunner.new
    yield tr
    puts tr.results
  end
end
