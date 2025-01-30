class ApplicationController < ActionController::Base
  include Authentication

  # 1 method to store a users data in an encrypted cookie
  # need to contain:
    # - User ID
    # - Session ID
    # - Session token

  
end
