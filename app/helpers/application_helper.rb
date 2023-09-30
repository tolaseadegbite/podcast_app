module ApplicationHelper
    # page title helper
    def full_title(page_title="")
        base_title = "Podcast App"
        if page_title.blank?
            base_title
        else
            "#{page_title} | #{base_title}"
        end
    end

    def render_turbo_stream_flash_messages
        turbo_stream.prepend "flash", partial: "layouts/flash"
    end

    def channel_nav_page?(link_name)
        return "text-dark" if controller_name == link_name
    end

    def channel_link_page?(link_name, link_action)
        return "text-dark" if controller_name == link_name && action_name == link_action
    end

    def channel_layout_renderer(controller_name, action_name)
        render 'channels/channel_layout_content' if controller_name == controller_name && action_name == action_name
    end
end
