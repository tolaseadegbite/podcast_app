require "test_helper"

class EpisodeEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
    sign_in @user
  end

  test "edit episode with invalid information" do
    get edit_channel_episode_path(@channel, @episode)
    assert_template 'episodes/edit'
    assert_select "title", "Edit episode | #{@base_title}"
    patch channel_episode_path(@channel, @episode), params: { episode: { title: "" } }
    assert_response :unprocessable_entity
    assert_template 'episodes/edit'
    assert_select 'div.text-danger'
  end

  test "edit episode with valid information" do
    get edit_channel_episode_path(@channel, @episode)
    assert_template 'episodes/edit'
    assert_select "title", "Edit episode | #{@base_title}"
    title = "Edited title"
    patch channel_episode_path(@channel, @episode), params: { episode: { title: title } }
    assert_not flash.empty?
    assert_redirected_to channel_episode_path(@channel, @episode)
    @episode.reload
    assert_equal title, @episode.title
  end
end
