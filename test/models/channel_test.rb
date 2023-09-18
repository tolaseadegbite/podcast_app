# == Schema Information
#
# Table name: channels
#
#  id              :bigint           not null, primary key
#  description     :text
#  location        :string
#  name            :string
#  playlists_count :integer          default(0), not null
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_channels_on_name     (name) UNIQUE
#  index_channels_on_slug     (slug) UNIQUE
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

  test "channel names should be unique" do
    duplicate_channel = @channel.dup
    duplicate_channel.name = "My first channel"
    @channel.name = "My first channel"
    @channel.save
    assert_not duplicate_channel.valid?
  end

  test "destroy associated channels when user is destroyed" do
    @channel.save
    @channel.episodes.create!(title: "Example Episode", description: "An example episode", user: @user)
    assert_difference 'Episode.count', -1 do
      @channel.destroy
    end
  end
end
