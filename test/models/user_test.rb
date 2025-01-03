require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(
      name: "",
      email: "ollie@example.com",
      password: "password"
    )
    assert_not @user.valid?
  end

  test "requires a valid email" do
    @user = User.new(
      name: "ollie",
      email: "",
      password: "password"
    )
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "ollie@example.com"
    assert @user.valid?

    @user.email = " ayush@example.com"
    assert @user.valid?
  end

  test "name and email stripped normalized before saving" do
    @user = User.new(
      name: " ollie",
      email: "ollie@example.com",
      password: "password"
    )
    assert @user.valid?

    @user = User.new(
      name: " ollie",
      email: " Ollie@example.com",
      password: "password"
    )
    assert @user.valid?
  end

  test "password is between 8 and the Active Model max" do
    @user = User.new(
      name: "ollie",
      email: "ollie@example.com",
      password: ""
    )
    assert_not @user.valid?

    @user.password = "password"
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = "a" * (max_length + 1)
    assert_not @user.valid?
  end
end
