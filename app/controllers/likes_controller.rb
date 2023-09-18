class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @like = current_user.likes.new(like_params)
        if @like.save
            respond_to do |format|
                format.html { redirect_back(fallback_location: root_path, notice: "Podcast liked") }
                format.turbo_stream { flash.now[:notice] = 'Podcast liked' }
            end
        else
            flash[:notice] = @like.errors.full_messages.to_sentence
        end
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        likeable = @like.likeable
        @like.destroy
        respond_to do |format|
            format.html { format.html { redirect_back(fallback_location: root_path, notice: "Podcast unliked") } }
            format.turbo_stream { flash.now[:notice] = 'Episode unliked' }
        end
    end

    private

        def like_params
            params.require(:like).permit(:likeable_id, :likeable_type)
        end

        def likeable
            @likeable ||= Likeable.find(params[:likeable_id])
        end
end
