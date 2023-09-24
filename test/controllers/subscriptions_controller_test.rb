require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @subscription = subscriptions(:subscription_one)
    @user = users(:tolase)
    @channel = channels(:channel2)
    @base_title = "Podcast App"
  end

  test "should redirect create when not logged in" do
    get channel_path(@channel)
    assert_template 'channels/show'
    assert_select "title", "#{@channel.name} | #{@base_title}"
    assert_no_difference 'Subscription.count' do
      post subscriptions_path, params: { subscription: { subscribable: @channel, subscribable_type: 'Channel', subscribable_id: @channel } }
    end
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    delete subscription_path(@subscription)
    assert_redirected_to new_user_session_url
    assert_not flash.empty?
  end
end
