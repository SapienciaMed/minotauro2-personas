require 'test_helper'

class UsersanalistasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usersanalista = usersanalistas(:one)
  end

  test "should get index" do
    get usersanalistas_url
    assert_response :success
  end

  test "should get new" do
    get new_usersanalista_url
    assert_response :success
  end

  test "should create usersanalista" do
    assert_difference('Usersanalista.count') do
      post usersanalistas_url, params: { usersanalista: { user: @usersanalista.user, user_analista: @usersanalista.user_analista } }
    end

    assert_redirected_to usersanalista_url(Usersanalista.last)
  end

  test "should show usersanalista" do
    get usersanalista_url(@usersanalista)
    assert_response :success
  end

  test "should get edit" do
    get edit_usersanalista_url(@usersanalista)
    assert_response :success
  end

  test "should update usersanalista" do
    patch usersanalista_url(@usersanalista), params: { usersanalista: { user: @usersanalista.user, user_analista: @usersanalista.user_analista } }
    assert_redirected_to usersanalista_url(@usersanalista)
  end

  test "should destroy usersanalista" do
    assert_difference('Usersanalista.count', -1) do
      delete usersanalista_url(@usersanalista)
    end

    assert_redirected_to usersanalistas_url
  end
end
