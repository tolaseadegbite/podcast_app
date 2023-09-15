require "test_helper"

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @lashe = users(:lashe)
    @channel = channels(:channel1)
  end

  test "should get new" do
    sign_in @user
    get new_channel_path
    assert_response :success
    assert_select "title", "New channel | Podcast App"
  end

  test "should redirect new when not logged in" do
    get new_channel_path
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Channel.count' do
      post channels_path, params: { channel: { title: "Awesome channel" } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when not logged in" do
    get edit_channel_path(@channel)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect edit when logged in as wrong user" do
    sign_in @lashe
    get edit_channel_path(@channel)
    assert_response :see_other
    assert_redirected_to channels_url
    assert_not flash.empty?
  end 

  test "should redirect update when not logged in" do
    assert_no_difference 'Channel.count' do
      patch channel_path(@channel), params: { channel: { title: "Awesome channel" } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect update when logged in as wrong user" do
    sign_in @lashe
    patch channel_path(@channel), params: { channel: { title: "A title" } }
    assert_response :see_other
    assert_redirected_to channels_url
    assert_not flash.empty?
  end

  test "redirect destroy when not logged in" do
    assert_no_difference "Channel.count" do
      delete channel_path(@channel)
    end
    assert_redirected_to new_user_session_url
  end

  test "redirect destroy when logged in as wrong user" do
    sign_in @lashe
    assert_no_difference "Channel.count" do
      delete channel_path(@channel)
    end
    assert_response :see_other
    assert_redirected_to channels_url
    assert_not flash.empty?
  end
end
