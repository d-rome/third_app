class ListsController < ApplicationController
  
  before_filter :authenticate

  public

    def create
#      if
      @list = current_user.lists.build(params[:list])
      @list.save
#      # handle successful save
#      else
        render 'pages/home'
    end

    def destroy
      
    end

  private
    
    def authenticate
      deny_access unless signed_in?
    end


end
