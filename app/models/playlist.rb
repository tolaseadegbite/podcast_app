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
class Playlist < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :user, counter_cache: :playlists_count
  belongs_to :channel, counter_cache: :playlists_count

  has_many :episodes
end
