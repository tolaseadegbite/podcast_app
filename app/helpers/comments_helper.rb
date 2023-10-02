module CommentsHelper
    def comment_user_avatar(user, comment)
        if !comment.parent 
            image_tag('avatar.jpg', class: "img-fluid rounded-circle me-3", style: "width: 45px; height: 45px;")
        else 
            image_tag('avatar.jpg', class: "img-fluid rounded-circle me-3", style: "width: 35px; height: 35px;")
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
