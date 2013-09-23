require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
    session[:user_id] = User.first.id
    session[:post] = Post.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { content: @comment.content }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    get :show, id: @comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should update comment" do
    put :update, id: @comment, comment: { content: @comment.content }
    assert_response :success
  end

=begin
  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, post_id: Post.first.id
    end

    assert_redirected_to comments_path
  end
=end
end
