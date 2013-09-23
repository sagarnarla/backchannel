require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "should require post id" do
    assert_not_nil votes(:one).user_id
  end
end
