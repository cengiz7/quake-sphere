require "test_helper"

class EarthquakeTest < ActiveSupport::TestCase
  test "earthquake_count" do
    assert_equal 2, Earthquake.count
  end
end
