require "test_helper"

class EpisodeDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
    sign_in @user
  end

  test "destroy episode" do
    assert_difference 'Episode.count', -1 do
      delete channel_episode_path(@channel, @episode)
    end
    assert_not flash.empty?
    assert_redirected_to channel_url(@channel)
  end
end
