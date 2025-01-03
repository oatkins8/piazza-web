require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(name: "", email: "ollie@example.com")
    assert_not @user.valid?
  end

  test "requires a valid email" do
    @user = User.new(name: "ollie", email: "")
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "ollie@example.com"
    assert @user.valid?

    @user.email = " ayush@example.com"
    assert @user.valid?
  end

  test "name and email stripped normalized before saving" do
    @user = User.new(name: " ollie", email: "ollie@example.com")
    assert @user.valid?

    @user = User.new(name: "ollie", email: " Ollie@example.com")
    assert @user.valid?
  end
end
