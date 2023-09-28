require "test_helper"

class CommentEditTest < ActionDispatch::IntegrationTest
  def setup
    @user =    users(:tolase)
    @channel = channels(:channel1)
    @commentable = episodes(:episode1)
    @comment = comments(:comment_one)
    sign_in @user
  end

  test "edit with invalid information" do
    get channel_episode_path(@channel, @commentable)
    patch channel_episode_comment_path(@channel, @commentable, @comment), params: { comment: { body: '', commentable: @commentable } }
    assert_response :see_other
    assert_redirected_to channel_episode_path(@channel, @commentable)
    assert_not flash.empty?
  end

  test "edit with valid information" do
    get channel_episode_path(@channel, @commentable)
    body = 'Edited comment'
    patch channel_episode_comment_path(@channel, @commentable, @comment), params: { comment: { body: body, commentable: @commentable } }
    follow_redirect!
    assert_not flash.empty?
    assert_template 'episodes/show'
    @comment.reload
    assert_match body, response.body
  end
end
