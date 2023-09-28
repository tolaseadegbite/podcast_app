require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @other_user = users(:lashe)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @comment = comments(:comment_one)
    @base_title = "Podcast App"
  end

  test "should redirect create when not logged in" do
    get channel_episode_path(@channel, @episode)
    assert_template 'episodes/show'
    assert_no_difference 'Comment.count' do
      post channel_episode_comments_path(@channel, @episode), params: { comment: { body: 'test comment', user: @user, commentable: @commentable } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
    get channel_episode_path(@channel, @episode)
    assert_template 'episodes/show'
    patch channel_episode_comment_path(@channel, @episode, @comment), params: { comment: { body: "comment" } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    delete channel_episode_path(@channel, @episode)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "redirect update when logged in as wrong user" do
    sign_in @other_user
    body = "This is a test comment"
    patch channel_episode_comment_path(@channel, @episode, @comment), params: { comment: {
                                                                                body: body,
                                                                                commentable: @episode
    } }
    assert_response :see_other
    assert_redirected_to channel_episode_path(@channel, @episode)
    assert_not flash.empty?
  end

  test "redirect destroy when logged in as wrong user" do
    sign_in @other_user
    delete channel_episode_comment_path(@channel, @episode, @comment)
    assert_response :see_other
    assert_redirected_to channel_episode_path(@channel, @episode)
    assert_not flash.empty?
  end
end
