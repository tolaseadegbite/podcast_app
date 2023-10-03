module ChannelsHelper
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
