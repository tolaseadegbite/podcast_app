class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :find_channel, only: [:user_likes, :user_comment_likes]

  def show

  end

  def edit
  end

  def update
    if @user.update(profile_params)
      respond_to do |format|
        format.html { redirect_to profile_path(current_user.username), notice: 'Profile updated.' }
        # format.turbo_stream
      end
    else
      flash[:alert] = current_user.errors.full_messages.join(", ")
      redirect_to profile_path(current_user.username)
    end
  end

  def user_channels
    @channels ||= @user.channels.includes(:episodes)
  end

  def user_subscriptions
    @subscriptions = @user.subscribed_channels
  end

  def about_user
    
  end

  def library
    
  end

  def user_likes
    @likes = @user.liked_episodes
  end

  def user_comment_likes
    render 'profiles/user_likes'
  end

  def trending
  end

  def history
  end

  private

  def profile_params
    params.require(:user).permit(:firstname, :lastname, :bio, :email, :avatar, :username)
  end
  
  def find_user
    @user ||= User.find_by(username: params[:username])
  end

  def find_channel
    @channel ||= @user.channels
  end

  def find_episodes
    @channel ||= @user.episodes
  end
end
