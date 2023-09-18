require "test_helper"

class LikeDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @like = likes(:like_two)
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
    sign_in @user
  end

  test "should destroy like when logged in" do
    get channel_episode_path(@channel, @episode)
    assert_template 'episodes/show'
    assert_select "title", "#{@episode.title} | #{@base_title}"
    assert_difference 'Like.count', -1 do
      delete like_path(@like, format: :turbo_stream)
    end
  end
end
