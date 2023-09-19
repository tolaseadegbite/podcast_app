class PlaylistsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_playlist, only: [:show, :edit, :update, :destroy]

    def index
        @playlists = current_user.playlists.ordered
    end

    def show
        
    end

    def new
        @playlist = Playlist.new
    end

    def create
        @playlist = current_user.playlists.build(playlist_params)
        if @playlist.save
            respond_to do |format|
                format.html { redirect_to @playlist, notice: "Playlist created" }
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @playlist.update(playlist_params)
            respond_to  do |format|
                format.html { redirect_to @playlist, notice: "Playlist updated"}
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @playlist.destroy
        respond_to do |format|
            format.html { redirect_to playlists_url }
        end
    end

    private

    def playlist_params
        params.require(:playlist).permit(:name, :description, :user_id, episode_ids: [])
    end

    def set_playlist
        @playlist ||= current_user.playlists.find(params[:id])
    end
end
