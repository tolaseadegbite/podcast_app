require "test_helper"

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user =    users(:tolase)
    @other_user =    users(:lashe)
    @channel = channels(:channel1)
    @episode = episodes(:episode1)
    @base_title = "Podcast App"
  end

  test "should get new" do
    sign_in @user
    get new_channel_episode_path(@channel)
    assert_response :success
    assert_template 'episodes/new'
    assert_select "title", "New episode | #{@base_title}"
  end

  test "should redirect new when not logged in" do
    get new_channel_episode_path(@channel)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect new when logged in as wrong user" do
    sign_in @other_user
    get new_channel_episode_path(@channel)
    assert_response :see_other
    assert_redirected_to @channel
  end

  test "should redirect create when logged in as wrong user" do
    sign_in @other_user
    assert_no_difference 'Episode.count' do
      post channel_episodes_path(@channel), params: { episode: { title: "Episode from wrong user" } }
    end
    assert_response :see_other
    assert_redirected_to channel_url(@channel)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Episode.count' do
      post channel_episodes_path(@channel), params: { episode: { title: "An example episode",
                                                      description: "Adesc" } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when not logged in" do
    get edit_channel_episode_path(@channel, @episode)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when logged in as wrong user" do
    sign_in @other_user
    get edit_channel_episode_path(@channel, @episode)
    assert_response :see_other
    assert_redirected_to @channel
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
    patch channel_episode_path(@channel, @episode), params: { episode: { title: "" } }
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect update when logged in as wrong user" do
    sign_in @other_user
    patch channel_episode_path(@channel, @episode), params: { episode: { title: " " } }
    assert_response :see_other
    assert_redirected_to channel_url(@channel)
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    delete channel_episode_path(@channel, @episode)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end
end
