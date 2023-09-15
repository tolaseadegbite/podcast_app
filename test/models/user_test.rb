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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(email: "user@example.com", username: "exampleUser", bio: "A developer", firstname: "User", lastname: "example", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "username length must not be more than 26" do
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  test "username length must not be less that 2" do
    @user.username = "a" * 1
    assert_not @user.valid?
  end

  test "usernames should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = "tolase"
    @user.username = "tolase"
    @user.save
    assert_not duplicate_user.valid?
  end

  test "destroy associated channels when user is destroyed" do
    @user.save
    @user.channels.create!(name: "Example Channel 2", description: "A channel to show examples of examples", location: "Nigeria")
    assert_difference 'Channel.count', -1 do
      @user.destroy
    end
  end
end
