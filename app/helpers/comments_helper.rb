module CommentsHelper

    def comment_user_or_channel_avatar(user, comment, channel)
        # Display proper avatars for channel owner and ordinary user and reduce avatar size if comment.parent is nil
        if user == comment.commentable.user
            if !comment.parent
                link_to image_tag(channel.avatar, class: "img-fluid rounded-circle me-3", style: "width: 45px; height: 45px;"), channel
            else
                link_to image_tag(channel.avatar, class: "img-fluid rounded-circle me-3", style: "width: 35px; height: 35px;"), channel
            end
        else 
            if !comment.parent
                # todo: change to comment user's avatar
                link_to image_tag('avatar.jpg', class: "img-fluid rounded-circle me-3", style: "width: 45px; height: 45px;"), profile_path(user.username)
            else
                link_to image_tag('avatar.jpg', class: "img-fluid rounded-circle me-3", style: "width: 35px; height: 35px;"), profile_path(user.username)
            end
        end 
    end

    def comment_user_or_channel_name(user, comment, channel)
        if user == comment.commentable.user
            link_to channel.name, '#', class: "btn btn-sm btn-secondary rounded-5 py-0"
        else
            link_to user.username, '#', class: "text-decoration-none text-dark"
        end
    end
end
