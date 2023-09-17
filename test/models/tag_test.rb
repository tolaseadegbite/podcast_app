# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require "test_helper"

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(name: "Example")
    @episode = episodes(:episode1)
  end

  test "tag is valid" do
    @tag.valid?
  end

  test "downcase name before saving" do
    mixed_case_tag = "ruBy on RAiLs"
    @tag.name = mixed_case_tag
    @tag.save
    assert_equal mixed_case_tag.downcase, @tag.reload.name 
  end

  test "name must be present" do
    @tag.name = ""
    assert_not @tag.valid?
  end

  test "name must not be less than 3" do
    @tag.name = "ta"
    assert_not @tag.valid?
  end

  test "destroy associated taggings when tag is destroyed" do
    @tag.save
    Tagging.create!(tag: @tag, episode: @episode)
    assert_difference 'Tagging.count', -1 do
        @tag.destroy
    end
  end
end
