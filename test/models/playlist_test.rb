# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  channel_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_playlists_on_channel_id  (channel_id)
#  index_playlists_on_name        (name) UNIQUE
#  index_playlists_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PlaylistTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @playlist = @user.playlists.build(name: "Nice playlist", description: "playlist description", channel: @channel)
  end

  test "must be valid" do
    assert @playlist.valid?
  end

  test "name must be present" do
    @playlist.name = ""
    assert_not @playlist.valid?
  end

  test "name must be longer than 3" do
    @playlist.name = "a" * 2
    assert_not @playlist.valid?
  end
end
