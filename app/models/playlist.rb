# == Schema Information
#
# Table name: playlists
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_playlists_on_name     (name) UNIQUE
#  index_playlists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Playlist < ApplicationRecord
  before_save :downcase_name

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }

  belongs_to :user, counter_cache: :playlists_count

  has_many :episode_playlists, dependent: :destroy
  has_many :episodes, through: :episode_playlists

  # TODO: write tests for this scope
  scope :ordered, -> { order(created_at: :desc) }
  
  private

  def downcase_name
      self.name.downcase!
  end
end
