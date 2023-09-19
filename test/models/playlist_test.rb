# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  channel_id  :bigint
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
    @playlist = @user.playlists.build(name: "Example playlist", description: "description of playlist", channel: @channel)
    @episode = episodes(:episode1)
  end

  test "playlist is valid" do
    @playlist.valid?
  end

  # test "downcase name before saving" do
  #   mixed_case_playlist = "ruBy on RAiLs"
  #   @playlist.name = mixed_case_playlist
  #   @playlist.save
  #   assert_equal mixed_case_playlist.downcase, @playlist.reload.name 
  # end

  test "name must be present" do
    @playlist.name = ""
    assert_not @playlist.valid?
  end

  test "name must not be less than 3" do
    @playlist.name = "p" * 2
    assert_not @playlist.valid?
  end

  test "destroy associated episodeplaylists when playlist is destroyed" do
    @playlist.save
    EpisodePlaylist.create!(playlist: @playlist, episode: @episode)
    assert_difference 'EpisodePlaylist.count', -1 do
        @playlist.destroy
    end
  end
end
