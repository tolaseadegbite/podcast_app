# == Schema Information
#
# Table name: episodes
#
#  id          :bigint           not null, primary key
#  description :text
#  likes_count :integer          default(0), not null
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
require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  def setup
    @user = users(:tolase)
    @channel = channels(:channel1)
    @episode = @channel.episodes.build(title: "Episode number 1", description: "We discuss about the fundamentals of rails", user: @user)
    @tag = tags(:tag_one)
  end

  test "should be valid" do
    assert @episode.valid?
  end

  test "title should be present" do
    @episode.title = "  "
    assert_not @episode.valid?
  end

  test "title should be longer than 5" do
    @episode.title = "c" * 2
    assert_not @episode.valid?
  end

  test "description should be present" do
    @episode.description = "  "
    assert_not @episode.valid?
  end

  test "destroy associated taggings when episode is destroyed" do
    @episode.save
    Tagging.create!(tag: @tag, episode: @episode)
    assert_difference 'Tagging.count', -1 do
        @episode.destroy
    end
  end

  test "destroy associated likes when episode is destroyed" do
    @episode.save
    Like.create!(user: @user, likeable: @episode)
    assert_difference 'Like.count', -1 do
        @episode.destroy
    end
  end
end
