require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should require name" do
    assert_equal "fall 2013", categories(:one).name
  end

  test "should require userid" do
    assert_not_nil  categories(:one).user_id
  end

  test "should not be blank" do
    c=Category.new
    assert !c.valid?
  end
end
