require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    session[:user_id] = User.first.id
    session[:user] = User.first
    cats = []
    categories = Category.all
    categories.each {|category| cats<<[category.name, category.id]}
    @categories = cats
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

=begin
  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: @post.attributes
    end

    assert_redirected_to post_path(assigns(:post))
  end
=end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

=begin
  test "should update post" do
    put :update, id: @post, post: @post.attributes
    assert_redirected_to post_path(assigns(:post))
  end
=end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end