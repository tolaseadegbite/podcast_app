class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_commentable, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_channel
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :find_comment, only: [:edit, :update, :destroy]

    def new
        @comment = Comment.new
            @parent ||= Comment.find(params[:comment_id])
    end

    def create
        @comment = @commentable.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            respond_to do |format|
                format.html { redirect_to channel_episode_url(@channel, @commentable), notice: 'Comment created!' }
            end
        else
            flash[:notice] = @comment.errors.full_messages.to_sentence
            redirect_back(fallback_location: channel_episode_url(@channel, @commentable), status: :see_other)
        end
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            respond_to do |format|
                if @comment.commentable_type == 'Episode'
                    format.html { redirect_to channel_episode_url(@channel, @commentable), notice: 'Comment updated!' }
                end
            end
        else
            flash[:notice] = @comment.errors.full_messages.to_sentence
            redirect_back(fallback_location: channel_episode_url(@channel, @commentable), status: :see_other)
        end 
    end

    def destroy
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to channel_episode_path(@channel, @commentable), notice: "Comment deleted!" }
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :parent_id)
    end

    def find_comment
        @comment ||= Comment.find(params[:id])
    end

    def find_parent
        @parent ||= Comment.find(params[:comment_id])
    end

    def find_commentable
        if params[:episode_id].present?
            @commentable ||= Episode.find(params[:episode_id])
        end
    end

    def find_channel
        if params[:channel_id].present?
            @channel ||= Channel.friendly.find(params[:channel_id])
        end
    end

    # confirms the correct user
    def correct_user
        @comment ||= Comment.find(params[:id])
        redirect_to(channel_episode_path(@channel, @commentable), status: :see_other, notice: "Access denied") unless @comment.user == current_user
    end
end
