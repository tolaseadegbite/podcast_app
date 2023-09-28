class EpisodesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_channel
    before_action :find_episode, only: [:show, :edit, :update, :destroy]
    before_action :restrict_other_users, only: %w[edit update destroy]
    before_action :restrict_channel_episode_creation, only: [:new, :create]

    def index
        @episodes = @channel.episodes
    end

    def show
        @playlist = Playlist.new
        @commentable = @episode
        @comment = Comment.new
    end

    def new
        @episode = Episode.new
    end

    def create
        @episode = @channel.episodes.build(episode_params)
        @episode.user = current_user
        if @episode.save
            respond_to do |format|
                format.html { redirect_to channel_episode_path(@channel, @episode), notice: 'Episode was successfully created.'}
                # format.turbo_stream { flash.now[:notice] = 'episode was successfully created.' }
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @episode.update(episode_params)
            respond_to do |format|
                format.html { redirect_to channel_episode_path(@channel, @episode), notice: "Episode was successfully updated." }
                # format.turbo_stream { flash.now[notice:] = "episode was successfully updated." }
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @episode.destroy
        respond_to do |format|
            format.html { redirect_to @channel, notice: "Episode deleted." }
            # format.turbo_stream { flash.now[:notice] = "episode deleted." }
        end
    end

    private

        def episode_params
            params.require(:episode).permit(:title, :description, :channel_id, :image, :audio, :user_id, tag_ids: [], playlist_ids: [])
        end

        def find_episode
            @episode ||= Episode.find(params[:id])
        end

        def find_channel
            @channel ||= Channel.friendly.find(params[:channel_id])
        end

        def restrict_other_users
            redirect_to(@channel, status: :see_other, notice: 'Access denied') unless current_user == @episode.user
        end

        def restrict_channel_episode_creation
            redirect_to(@channel, status: :see_other, notice: 'Access denied') if @channel.user != current_user
        end
end
