require "test_helper"

class EpisodeCreationTest < ActionDispatch::IntegrationTest
  def setup
    @user =    users(:tolase)
    @other_user =    users(:lashe)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
    sign_in @user
  end

  test "create episode with invalid information" do
    get new_channel_episode_path(@channel)
    assert_template 'episodes/new'
    assert_select "title", "New episode | #{@base_title}"
    assert_no_difference 'Episode.count' do
      post channel_episodes_path(@channel), params: { episode: { title: "", description: "" } }
    end
    assert_response :unprocessable_entity
    assert_template 'episodes/new'
    assert_select "div.text-danger"
  end

  test "create episode with valid information" do
    get new_channel_episode_path(@channel)
    assert_template 'episodes/new'
    assert_select "title", "New episode | #{@base_title}"
    title = "A valid episode"
    description = "Description an an episode"
    assert_difference 'Episode.count', 1 do
      post channel_episodes_path(@channel), params: { episode: {
                                                                title: title,
                                                                description: description
      } }
    end
    follow_redirect!
    assert_template 'episodes/show'
    assert_not flash.empty?
    assert_match title, response.body
    assert_match description, response.body
  end
end
