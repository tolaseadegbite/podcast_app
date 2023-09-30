# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  channel_id  :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_playlists_on_channel_id  (channel_id)
#  index_playlists_on_name        (name) UNIQUE
#  index_playlists_on_slug        (slug) UNIQUE
#  index_playlists_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (user_id => users.id)
#
class Playlist < ApplicationRecord
  # before_save :downcase_name
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def slug=(value)
    if value.present?
      write_attribute(:slug, value)
    end
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :channel_id, length: { minimum: 1, allow_nil: true }

  belongs_to :user, counter_cache: :playlists_count
  belongs_to :channel, counter_cache: :playlists_count, optional: true

  has_many :episode_playlists, dependent: :destroy
  has_many :episodes, through: :episode_playlists

  # TODO: write tests for this scope
  scope :ordered, -> { order(created_at: :desc) }
  
  private

  def downcase_name
      self.name.downcase!
  end
end
