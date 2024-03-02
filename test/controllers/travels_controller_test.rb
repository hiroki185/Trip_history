require "test_helper"

class TravelsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get travels_show_url
    assert_response :success
  end

  test "should get index" do
    get travels_index_url
    assert_response :success
  end

  test "should get edit" do
    get travels_edit_url
    assert_response :success
  end
end
