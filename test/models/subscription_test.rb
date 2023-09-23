# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  subscribable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subscribable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_subscribable                           (subscribable_type,subscribable_id)
#  index_subscriptions_on_subscribable_id_and_subscribable_type  (subscribable_id,subscribable_type)
#  index_subscriptions_on_user_id                                (user_id)
#  index_subscriptions_on_user_id_subbable_id_and_subbable_type  (user_id,subscribable_id,subscribable_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @channel = channels(:channel2)
    @owned_channel = channels(:channel1)
    @subscription = @user.subscriptions.build(subscribable: @channel, subscribable_type: 'Channel')
  end

  test "must be valid" do
    assert @subscription.valid?
  end

  test "user must be present" do
    @subscription.user = nil
    @subscription.save
    assert_not @subscription.valid?
  end

  test "subscribable must be present" do
    @subscription.subscribable = nil
    @subscription.save
    assert_not @subscription.valid?
  end

  test "user should not be able to subscribe to an object twice" do
    duplicate_subscription = @subscription.dup
    duplicate_subscription.user = users(:lashe)
    @subscription.user = users(:lashe)
    @subscription.save
    assert_not duplicate_subscription.valid?
  end

  test "user should not be able to subscribe to their channel" do
    @subscription.user = @subscription.subscribable.user
    assert_not @subscription.valid?
  end
end
