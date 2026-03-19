require 'test_helper'

class AdministracionControllerTest < ActionDispatch::IntegrationTest
  test "should get icons" do
    get administracion_icons_url
    assert_response :success
  end

end
