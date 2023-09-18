# == Schema Information
#
# Table name: episode_playlists
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  episode_id  :bigint           not null
#  playlist_id :bigint           not null
#
# Indexes
#
#  index_episode_playlists_on_episode_id   (episode_id)
#  index_episode_playlists_on_playlist_id  (playlist_id)
#
# Foreign Keys
#
#  fk_rails_...  (episode_id => episodes.id)
#  fk_rails_...  (playlist_id => playlists.id)
#
require "test_helper"

class EpisodePlaylistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
