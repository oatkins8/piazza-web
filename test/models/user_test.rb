require "test_helper"

class UserTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  describe "validations" do
    it "requires a name" do
      @user = User.new(
        name: "",
        email: "ollie@example.com",
        password: "password"
      )
      assert_not @user.valid?
    end

    it "requires a valid email" do
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
  
    it "name and email stripped normalized before saving" do
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
  
    it "password is between 8 and the Active Model max" do
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

  describe "authentication" do
    before do
      # already have user fixtures so is this necessary? 
      @user = User.create!(
        name: "ollie",
        email: "ollie@example.com",
        password: "password",
        password_confirmation: "password"
      )
    end

    describe "#self.create_session" do
      it "can create a session with an email and a correct password" do
        @session = User.create_session(
          email: "ollie@example.com", 
          password: "password"
        )
  
        assert_not_nil @session
        assert_not_nil @session.token
      end
  
      it "cannot create a session with an incorrect password" do
        @session = User.create_session(
          email: "ollie@example.com", 
          password: "WRONG"
        )
  
        assert_nil @session
      end
  
      it "cannot create a session if the email does not exist" do
        @session = User.create_session(
          email: "unknown@example.com", 
          password: "password"
        )
  
        assert_nil @session
      end
    end
  
    describe "#authenticate_session" do
      before do
        @session = User.create_session(
          email: "ollie@example.com", 
          password: "password"
        )
      end
      
      it "can authenticate a user with a valid session ID and token" do
        binding.irb
        @authenticated_session = @user.authenticate_session(@session.id, @session.token)

        assert_equal @session, @authenticated_session
      end

      it "returns false if the token is incorrect" do
        @user.authenticate_session(@session.id, 500)

        assert_not @authenticate_session
      end
    end
  end
end
