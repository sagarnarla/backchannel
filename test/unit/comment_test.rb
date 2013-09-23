require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should not be blank" do
    c=Comment.new
    assert !c.valid?
  end
  test "should require content1" do
    assert_equal "comment for post1", comments(:one).content
  end
  test "should require postid" do
    assert_not_nil comments(:one).post_id
  end
  test "should require userid" do
    assert_not_nil comments(:one).user_id
  end
end
