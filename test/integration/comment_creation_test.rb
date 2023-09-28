require "test_helper"

class CommentCreationTest < ActionDispatch::IntegrationTest
  def setup
    @user =    users(:tolase)
    @channel = channels(:channel1)
    @commentable = episodes(:episode1)
    @comment = comments(:comment_one)
    sign_in @user
  end

  test "create comment with invalid information" do
    get channel_episode_path(@channel, @commentable)
    assert_no_difference 'Comment.count' do
      post channel_episode_comments_path(@channel, @commentable), params: { comment: { body: '', commentable: @commentable } }
    end
    assert_response :see_other
    assert_redirected_to channel_episode_path(@channel, @commentable)
    assert_not flash.empty?
  end

  test "create comment with valid information" do
    get channel_episode_path(@channel, @commentable)
    body = "Test comment"
    assert_difference 'Comment.count', 1 do
      post channel_episode_comments_path(@channel, @commentable), params: { comment: { body: body, commentable: @commentable } }
    end
    follow_redirect!
    assert_template 'episodes/show'
    assert_not flash.empty?
    assert_match body, response.body
  end
end
