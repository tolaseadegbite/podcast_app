# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string           default(""), not null
#  lastname               :string           default(""), not null
#  playlists_count        :integer          default(0), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :downcase_username

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 25 }, format: { with: /\A[a-zA-Z0-9]+(?:[._][a-zA-Z0-9]+)*\z/ }

  has_one_attached :avatar do |attachable|
    attachable.variant :display, resize_to_limit: [50, 50]
  end

  has_one_attached :cover_image do |attachable|
    attachable.variant :display, resize_to_limit: [2560, 1440]
  end

  validates :avatar, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }

  has_many :channels, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_channels, through: :subscriptions, source: :subscribable, source_type: "Channel"
  has_many :comments, dependent: :destroy

  private

    # converts username to lowercase
    def downcase_username
      self.username.downcase!
    end
end
