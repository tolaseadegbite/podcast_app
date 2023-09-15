require "test_helper"

class ChannelsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @base_title = "Podcast App"
  end

  test "edit with invalid information" do
    sign_in @user
    get edit_channel_path(@channel)
    assert_template 'channels/edit'
    assert_select "title", "Edit channel | #{@base_title}"
    patch channel_path(@channel), params: { channel: { name: "" } }
    assert_response :unprocessable_entity
    assert_template 'channels/edit'
    assert_select "div.text-danger"
  end

  test "edit with valid information" do
    sign_in @user
    get edit_channel_path(@channel)
    assert_template 'channels/edit'
    name = "A new name"
    patch channel_path(@channel), params: { channel: { name: name } }
    assert_not flash.empty?
    assert_redirected_to @channel
    @channel.reload
    assert_equal name, @channel.name
  end
end
