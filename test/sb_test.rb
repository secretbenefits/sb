require "test_helper"

class SbTest < Minitest::Test
  def setup
    @array = [1, 2, 3]
    @limit = @array.size
  end

  def test_that_it_has_a_version_number
    refute_nil ::Sb::VERSION
  end

  def test_hamming_filter_distance
    assert_equal [2], Sb.hamming_filter(@array, 2, 0, @limit)
    assert_equal [2, 3], Sb.hamming_filter(@array, 2, 1, @limit)
    assert_equal [1, 2, 3], Sb.hamming_filter(@array, 2, 2, @limit)
  end

  def test_hamming_filter_limit
    assert_empty Sb.hamming_filter(@array, 2, 3, 0)
    assert_equal [1], Sb.hamming_filter(@array, 2, 3, 1)
    assert_equal [1, 2], Sb.hamming_filter(@array, 2, 3, 2)
    assert_equal [1, 2, 3], Sb.hamming_filter(@array, 2, 3, 3)
    assert_equal [1, 2, 3], Sb.hamming_filter(@array, 2, 3, 4)
  end

  def test_hamming_filter_handles_large_values
    assert_empty Sb.hamming_filter([53876069761073], 0, 5, 1)
    assert_equal [11111456622286484083], Sb.hamming_filter([0, 11111456622286484083, 2**32-1], 11111456622286484083, 1, 1)
  end
end
