# == Schema Information
#
# Table name: channels
#
#  id                  :bigint           not null, primary key
#  description         :text
#  location            :string
#  name                :string
#  playlists_count     :integer          default(0), not null
#  slug                :string
#  subscriptions_count :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
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
class Channel < ApplicationRecord
  # before_save :downcase_name
  before_save :urlify_slug

  belongs_to :user

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, :location, presence: true

  has_many :episodes, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_many :subscribed_users, through: :subscriptions, source: :user
  
  private
  
  def downcase_name
    self.name.downcase!
  end

  def urlify_slug
    self.slug.split("-").join("")
  end

end
