require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get zipCodeAccidentGrowth" do
    get pages_zipCodeAccidentGrowth_url
    assert_response :success
  end

end
