require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @like = likes(:like_one)
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
  end

  test "should redirect create when not logged in" do
    get channel_episode_path(@channel, @episode)
    assert_template 'episodes/show'
    assert_select "title", "#{@episode.title} | #{@base_title}"
    assert_no_difference 'Like.count' do
      post likes_path, params: { like: { likeable: @episode, likeable_type: 'Episode', likeable_id: @episode } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    delete like_path(@like)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end
end
