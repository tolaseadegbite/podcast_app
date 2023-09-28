# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  parent_id        :integer
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @episode = episodes(:episode1)
    @comment = @user.comments.build(commentable: @episode, body: "A comment")
  end

  test "comment must be valid" do
    assert @comment.valid?
  end

  test "body must be present" do
    @comment.body = nil
    assert_not @comment.valid?
  end

end
