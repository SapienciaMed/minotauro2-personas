require 'test_helper'

class SygmausersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sygmauser = sygmausers(:one)
  end

  test "should get index" do
    get sygmausers_url
    assert_response :success
  end

  test "should get new" do
    get new_sygmauser_url
    assert_response :success
  end

  test "should create sygmauser" do
    assert_difference('Sygmauser.count') do
      post sygmausers_url, params: { sygmauser: { user_id: @sygmauser.user_id } }
    end

    assert_redirected_to sygmauser_url(Sygmauser.last)
  end

  test "should show sygmauser" do
    get sygmauser_url(@sygmauser)
    assert_response :success
  end

  test "should get edit" do
    get edit_sygmauser_url(@sygmauser)
    assert_response :success
  end

  test "should update sygmauser" do
    patch sygmauser_url(@sygmauser), params: { sygmauser: { user_id: @sygmauser.user_id } }
    assert_redirected_to sygmauser_url(@sygmauser)
  end

  test "should destroy sygmauser" do
    assert_difference('Sygmauser.count', -1) do
      delete sygmauser_url(@sygmauser)
    end

    assert_redirected_to sygmausers_url
  end
end
