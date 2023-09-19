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
#  index_subscriptions_on_user_id_subbable_id_and_subbable_type  (user_id,subscribable_id,subscribable_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: [:subscribable_id, :subscribable_type] }

  belongs_to :user
  belongs_to :subscribable, polymorphic: true, counter_cache: :subscriptions_count
end
