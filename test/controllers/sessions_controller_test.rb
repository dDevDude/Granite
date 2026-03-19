# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  def test_should_login_user_with_valid_credentials
    post session_path, params: { login: { email: @user.email, password: @user.password } }, as: :json
    assert_response :success
    assert_equal @user.authentication_token, response.parsed_body["authentication_token"]
  end

  def test_shouldnt_login_user_with_invalid_credentials
    post session_path, params: { login: { email: @user.email, password: "invalid password" } }, as: :json
    assert_response :unauthorized
    response_json = response.parsed_body
    assert_equal I18n.t("session.incorrect_credentials"), response_json["error"]
  end

  def test_should_respond_with_not_found_error_if_user_is_not_present
    non_existent_email = "this_email_does_not_exist_in_db@example.email"
    post session_path, params: { login: { email: non_existent_email, password: "welcome" } }, as: :json
    assert_response :not_found
    response_json = response.parsed_body
    assert_equal "Couldn't find User", response_json["error"]
  end

  # TODO: FIX THIS TEST
  # def test_should_update_user_password
  #   old_password = @user.password
  #   new_password = "Updated@password123"
  #   put user_path(@user),
  #     params: {
  #       user: {
  #         password: new_password
  #       }
  #     }, headers: @headers
  #   assert_response :success
  #   response_json = response.parsed_body
  #   assert_equal I18n.t("successfully_updated", name: "User"), response_json["notice"]
  #   assert_equal new_password, @user.reload.password
  # end
end
