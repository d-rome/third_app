class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
#                    ^ this is just a method defined below in private
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @users = User.all.paginate(:page => params[:page])
      # ^ plural, rails looks for this when will_paginate is called
    @title = "All users"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to user_path(@user),
        :flash => {:success => "Welcome to MAPmeds, #{@user.name}." }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @user  = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user  = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # IT worked
      redirect_to user_path(@user),
        :flash => {:success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end

  private
    
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end
