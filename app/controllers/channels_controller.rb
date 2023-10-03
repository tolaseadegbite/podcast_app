class ChannelsController < ApplicationController
    before_action :set_channel, only: [:show, :edit, :update, :destroy, :owned_channels, :channel_subscriptions, :about_channel]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: %i[ edit update destroy ]
    # before_action :allow_one_channel_creation, only: %i[ new create ]

    def index
        @channels = Channel.all.includes(:episodes)
    end

    def show
        
    end

    def new
        @channel = Channel.new
    end

    def create
        @channel = current_user.channels.build(channel_params)
        if @channel.save
            respond_to do |format|
                format.html { redirect_to @channel, notice: 'Channel was successfully created'}
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @channel.update(channel_params)
            respond_to do |format|
                format.html { redirect_to @channel, notice: 'Channel was updated successfully'}
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @channel.destroy
        respond_to do |format|
            format.html { redirect_to channels_path, notice: 'Channel was deleted successfully'}
        end
    end

    def owned_channels
        @owned_channels ||= @channel.user.channels.includes(:episodes).where.not(id: @channel)
    end

    def channel_subscriptions
        @subscriptions = @channel.user.subscribed_channels
    end

    def about_channel
        
    end

    private

    def channel_params
        params.require(:channel).permit(:name, :description, :location, :cover_image, :avatar)
    end

    def set_channel
        @channel ||= Channel.friendly.find(params[:id])
    end

    # confirms the correct user
    def correct_user
        @channel ||= Channel.friendly.find(params[:id])
        redirect_to(channels_url, status: :see_other, notice: "Access denied") unless current_user == @channel.user
    end

    # create channel only once
    def allow_one_channel_creation
        redirect_to(root_url, status: :see_other, notice: "You can only create a channel per account") unless current_user.channels.count < 1
    end
end
