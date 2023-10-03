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
end
