require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:charlie)
  end

  test "user is signed in and redirected to home" do
    assert_difference("@user.sessions.count", 1) do
      post sign_in_path, params: {
        user: {
          email: "charlie@example.com",
          password: "password"
        }
      }
    end

    assert_redirected_to root_path
    assert_equal(flash[:success], I18n.t(".sessions.create.successful"))
  end

  test "does not create a session if login details are incorrect" do
    assert_difference("@user.sessions.count", 0) do
      post sign_in_path, params: {
        user: {
          email: "charlie@example.com",
          password: "WRONG"
        }
      }
    end

    assert_equal(flash[:danger], I18n.t(".sessions.create.unsuccessful"))
    assert_response :unprocessable_entity
  end

  test "does not create a session if the user does not exist" do
    assert_difference("@user.sessions.count", 0) do
      post sign_in_path, params: {
        user: {
          email: "frank@example.com",
          password: "password"
        }
      }
    end

    assert_equal(flash[:danger], I18n.t(".sessions.create.unsuccessful"))
    assert_response :unprocessable_entity
  end
end
