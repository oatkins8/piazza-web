class SessionsController < ApplicationController

  def new
  end

  def create
    # verify the login credentials (email and password)
    # create a new Session record
    # store the users ID, session token and session ID in an encrypted cookie
  end
end
