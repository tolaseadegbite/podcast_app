require "test_helper"

class LikeCreationTest < ActionDispatch::IntegrationTest
  def setup
    @like = likes(:like_two)
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
    sign_in @user
  end
  
  test "create like when logged in" do
    sign_in @user
    get channel_episode_path(@channel, @episode)
    assert_template 'episodes/show'
    assert_select "title", "#{@episode.title} | #{@base_title}"
    assert_difference 'Like.count', 1 do
      post likes_path(format: :turbo_stream), params: { like: { likeable: @episode, likeable_type: 'Episode', likeable_id: @episode.id } }
    end
  end
end
