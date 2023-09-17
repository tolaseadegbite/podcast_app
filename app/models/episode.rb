# == Schema Information
#
# Table name: episodes
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  channel_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_episodes_on_channel_id  (channel_id)
#  index_episodes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#  fk_rails_...  (user_id => users.id)
#
class Episode < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :likes, as: :likeable

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true
end
