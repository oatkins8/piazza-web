require "test_helper"

class SessionTest < ActiveSupport::TestCase

  setup do 
    @user = users(:charlie)
  end

  test "token is generated and saved when a new session is created" do
    session = @user.sessions.create

    assert session.persisted?
    assert_not_nil session.token
  end
end
