require "test_helper"

class SbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sb::VERSION
  end
end
