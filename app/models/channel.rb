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

  belongs_to :user

  extend FriendlyId
  friendly_id :formatted_name, use: :slugged

  def formatted_name
    "@ #{name.downcase}"
  end

  def normalize_friendly_id(string)
    string.gsub(" ", "")
  end
  
  def slug=(value)
    if value.present?
      write_attribute(:slug, value)
    end
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :description, :location, presence: true

  has_many :episodes, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_many :subscribed_users, through: :subscriptions, source: :user

  has_one_attached :cover_image do |attachable|
    attachable.variant :display, resize_to_fill: [1920, 500]
  end

  validates :cover_image, presence: true,   content_type: { in: %w[image/jpeg image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 1.megabytes,
                                      message:   "should be less than 1MB" }
  
  private
  
  def downcase_name
    self.name.downcase!
  end

end
