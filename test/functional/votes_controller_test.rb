require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @vote = votes(:one)
  end

=begin
  test "should get index" do
    get(:index, {"post_id" => @vote.post_id}, {"type" => "post"})
    assert_response :success
    assert_not_nil assigns(:votes)
  end
=end

=begin
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote" do
    assert_difference('Vote.count') do
      post :create, vote: {  }, post_id: Post.first.id
    end

    assert_redirected_to vote_path(assigns(:vote))
  end
=end
=begin

  test "should show vote" do
    get :show, id: @vote
    assert_response :success
  end
=end

  test "should get edit" do
    get :edit, id: @vote
    assert_response :success
  end

  test "should update vote" do
    put :update, id: @vote, vote: {  }
    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: @vote
    end

    assert_redirected_to votes_path
  end
end
