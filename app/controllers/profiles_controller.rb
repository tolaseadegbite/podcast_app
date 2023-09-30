class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :channel

  def show

  end

  def edit
  end

  def update
  end

  private
  
  def find_user
    @user ||= User.find_by(username: params[:username])
  end

  def channel
    @channel ||= @user.channels.first
  end
end
