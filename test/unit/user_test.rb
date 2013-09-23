require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not be blank" do
    u=User.new
    assert !u.valid?
  end

  test "should require username" do
    assert_equal "varun", users(:one).username
  end
  test "should require password" do
    assert_equal "abcd", users(:one).password
  end
  test "should require usertype" do
    assert_equal "admin", users(:one).user_type
  end
  test "should require nickname" do
    assert_equal "varunn", users(:one).nickname
  end

end
