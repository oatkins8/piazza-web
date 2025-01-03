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
  end
end
