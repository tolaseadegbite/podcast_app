class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :downcase_username

  validates_presence_of :username, length: { minimum: 2, maximum: 20 }, uniqueness: { case_sensitive: false }

  has_one_attached :avatar do |attachable|
    attachable.variant :display, resize_to_limit: [50, 50]
  end

  validates :avatar, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }

  # converts username to lowercase
  def downcase_username
    self.username.downcase!
  end
end
