# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  subscribable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subscribable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_subscribable                           (subscribable_type,subscribable_id)
#  index_subscriptions_on_subscribable_id_and_subscribable_type  (subscribable_id,subscribable_type)
#  index_subscriptions_on_user_id                                (user_id)
#  user_subscribable_index                                       (user_id,subscribable_id,subscribable_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: [:subscribable_id, :subscribable_type] }
  validate :cant_subscribe_to_your_channel

  belongs_to :user
  belongs_to :subscribable, polymorphic: true, counter_cache: :subscriptions_count
  
  private

  def cant_subscribe_to_your_channel
    errors.add(:user_id, 'You can\'t subscribe to your channel') if self.user == self.subscribable.user
  end
end
