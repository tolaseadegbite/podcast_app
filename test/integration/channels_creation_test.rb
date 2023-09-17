require "test_helper"

class ChannelsCreationTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @base_title = "Podcast App"
  end

  test "create channel with invalid information" do
    sign_in @user
    assert_no_difference 'Channel.count' do
      post channels_path, params: { channel: { name: " " } }
    end
    assert_response :unprocessable_entity
    assert_template "channels/new"
    assert_select "div.text-danger"
  end

  test "create with valid information" do
    sign_in @user
    get new_channel_path
    assert_template 'channels/new'
    assert_select "title", "New channel | #{@base_title}"
    name = "My great channel"
    description = "My nice channel"
    location = "Nigeria"
    assert_difference 'Channel.count', 1 do
      post channels_path, params: { channel: { name: name,
                                                location: location,
                                                description: description } }
    end
    follow_redirect!
    assert_template 'channels/show'
    assert_not flash.empty?
    assert_match description, response.body
    assert_match location, response.body
  end
end
