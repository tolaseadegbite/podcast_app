require "test_helper"

class CommentDeletionTest < ActionDispatch::IntegrationTest
  def setup
    @user =    users(:tolase)
    @channel = channels(:channel1)
    @commentable = episodes(:episode1)
    @comment = comments(:comment_one)
    sign_in @user
  end

  test "destroy comment" do
    assert_difference 'Comment.count', -1 do
      delete channel_episode_comment_path(@channel, @commentable, @comment)
    end
    follow_redirect!
    assert_template 'episodes/show'
  end
end
