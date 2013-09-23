require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not be blank" do
    p=Post.new
    assert !p.valid?
  end
  test "should require content" do
    assert_equal "postcontent1", posts(:one).content
  end
  test "should require userid" do
    assert_not_nil posts(:one).user_id
  end
  test "should require categoryid" do
    assert_not_nil  posts(:one).category_id
  end

end
