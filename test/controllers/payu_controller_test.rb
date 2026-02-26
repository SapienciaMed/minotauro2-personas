require 'test_helper'

class PayuControllerTest < ActionDispatch::IntegrationTest
  test "should get confirmacion" do
    get payu_confirmacion_url
    assert_response :success
  end

  test "should get respuesta" do
    get payu_respuesta_url
    assert_response :success
  end

end
