require 'test_helper'

class LiquidacionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get liquidaciones_index_url
    assert_response :success
  end

end
