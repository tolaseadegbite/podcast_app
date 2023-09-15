# == Schema Information
#
# Table name: channels
#
#  id          :bigint           not null, primary key
#  description :text
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_channels_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ChannelTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:tolase)
    @channel = @user.channels.build(name: "Example Channel", description: "A channel to show examples of examples", location: "Nigeria")
  end

  test "should be valid" do
    assert @channel.valid?
  end

  test "name should be present" do
    @channel.name = "  "
    assert_not @channel.valid?
  end

  test "name should be longer than 5" do
    @channel.name = "c" * 2
    assert_not @channel.valid?
  end

  test "description should be present" do
    @channel.description = "  "
    assert_not @channel.valid?
  end

  test "location should be present" do
    @channel.location = "  "
    assert_not @channel.valid?
  end
end
