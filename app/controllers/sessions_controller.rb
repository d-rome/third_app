class SessionsController < ApplicationController

  def new
    @user = User.new
    @title = "Sign in"
  end
  
  def create
    
  end
  
  def destroy
    
  end

end
