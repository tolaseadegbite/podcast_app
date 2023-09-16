# == Schema Information
#
# Table name: channels
#
#  id          :bigint           not null, primary key
#  description :text
#  location    :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_channels_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Channel < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, :location, presence: true

  has_many :episodes, dependent: :destroy
end
