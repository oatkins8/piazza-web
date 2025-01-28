require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup_user
    @user = User.create!(
      name: "ollie",
      email: "ollie@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end
  
  test "requires a name" do
    @user = User.new(
      name: "",
      email: "ollie@example.com",
      password: "password"
    )
    assert_not @user.valid?
  end

  # validation

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

  # authentication / session

  test "can create a session with an email and a correct password" do
    setup_user

    @session = User.create_session(
      email: "ollie@example.com", 
      password: "password"
    )

    assert_not_nil @session
    assert_not_nil @session.token
  end

  test "cannot create a session with an incorrect password" do
    setup_user

    @session = User.create_session(
      email: "ollie@example.com", 
      password: "WRONG"
    )

    assert_nil @session
  end

  test "cannot create a session if the email does not exist" do
    setup_user

    @session = User.create_session(
      email: "unknown@example.com", 
      password: "password"
    )

    assert_nil @session
  end
end
