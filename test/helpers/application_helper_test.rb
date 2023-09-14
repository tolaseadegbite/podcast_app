require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

    # page title helper test
    test "full title helper" do
        assert_equal "Podcast App", full_title
        assert_equal "Home | Podcast App", full_title("Home")
    end
end