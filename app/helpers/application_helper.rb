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
end
