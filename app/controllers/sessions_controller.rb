class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    
    if !!@user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have signed in successfully'      
      redirect_to user_messages_path(@user)
    else
      flash.now[:error] = 'Invalid username or password'
      render new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out'
    redirect_to root_path
  end
end