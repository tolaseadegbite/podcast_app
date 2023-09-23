# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_likes_on_likeable                                   (likeable_type,likeable_id)
#  index_likes_on_likeable_id_and_likeable_type              (likeable_id,likeable_type)
#  index_likes_on_user_id                                    (user_id)
#  index_likes_on_user_id_and_likeable_id_and_likeable_type  (user_id,likeable_id,likeable_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @episode = episodes(:episode1)
    @like = @user.likes.build(likeable: @episode)
  end

  test "must be valid" do
    assert @like.valid?
  end

  test "user must be present" do
    @like.user = nil
    @like.save
    assert_not @like.valid?
  end

  test "likeable must be present" do
    @like.likeable = nil
    @like.save
    assert_not @like.valid?
  end

  test "a user should not be able to like an object twice" do
    duplicate_like = @like.dup
    duplicate_like.user = users(:lashe)
    @like.user = users(:lashe)
    @like.save
    assert_not duplicate_like.valid?
  end
end
