require "test_helper"

class SbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sb::VERSION
  end

  def test_hamming_filter_distance
    assert_equal [2], call(distance: 0)
    assert_equal [2, 3], call(distance: 1)
    assert_equal [1, 2, 3], call(distance: 2)
  end

  def test_hamming_filter_limit
    assert_empty call(limit: 0)
    assert_equal [1], call(limit: 1)
    assert_equal [1, 2], call(limit: 2)
    assert_equal [1, 2, 3], call(limit: 3)
    assert_equal [1, 2, 3], call(limit: 4)
  end

  def test_hamming_filter_handles_large_values
    assert_empty call(array: [53876069761073], filter: 0, distance: 5)
    assert_equal [11111456622286484083], call(array: [0, 11111456622286484083, 2**32-1], filter: 11111456622286484083)
  end

  def call(array: [1, 2, 3], filter: 2, distance: 3, limit: nil)
    Sb.hamming_filter(array.pack('Q*'), filter, distance, limit || array.size)
  end
end
