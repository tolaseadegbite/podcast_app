# == Schema Information
#
# Table name: episodes
#
#  id          :bigint           not null, primary key
#  description :text
#  likes_count :integer          default(0), not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  channel_id  :bigint           not null
#  playlist_id :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_episodes_on_channel_id   (channel_id)
#  index_episodes_on_playlist_id  (playlist_id)
#  index_episodes_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (playlist_id => playlists.id)
#  fk_rails_...  (user_id => users.id)
#
class Episode < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :playlist_id, length: { minimum: 1, allow_nil: true }

  belongs_to :user
  belongs_to :channel
  belongs_to :playlist, optional: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :likes, as: :likeable, dependent: :destroy

end
