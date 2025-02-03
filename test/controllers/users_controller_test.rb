require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "redirects to feed after successful sign up" do
    get sign_up_path
    assert_response :ok

    assert_difference(["User.count", "Organisation.count"], 1) do 
      post sign_up_path, params: {
        user: {
          name: "Ayush",
          email: "aysuhnewatia@railsandhotwirecodex.com",
          password: "password"
        }
      }

      assert_redirected_to root_path
      assert_not_empty cookies[:session]
      follow_redirect!

      assert_select(
        ".notification.is-success",
        text: I18n.t("users.create.welcome", name: "Ayush")
      )
    end
  end

  test "renders errors if the input is invalid" do
    get sign_up_path
    assert_response :ok

    assert_no_difference(["User.count", "Organisation.count"]) do 
      post sign_up_path, params: {
        user: {
          name: "Ayush",
          email: "aysuhnewatia@railsandhotwirecodex.com",
          password: "pass"
        }
      }
    end

    assert_response(:unprocessable_entity)
    assert_select(
      "p.is-danger",
      text: I18n.t("activerecord.errors.models.user.attributes.password.too_short")
    )
  end

  test "renders errors if the password confirmation is incorrect" do
    get sign_up_path
    assert_response :ok

    assert_no_difference(["User.count", "Organisation.count"]) do 
      post sign_up_path, params: {
        user: {
          name: "Ayush",
          email: "aysuhnewatia@railsandhotwirecodex.com",
          password: "password",
          password_confirmation: "pwssword"
        }
      }
    end

    assert_response(:unprocessable_entity)
    assert_select(
      "p.is-danger",
      text: I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
    )
  end
end
