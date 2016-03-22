class UsersController < ApplicationController
  skip_before_action :require_login
  before_action :redirect_if_signed_in

  def index
    @friend_list = @current_user.users_to_add_friend
  end

  def new
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to new_session_path
      flash[:success] = 'You have signed up successfully.'
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation
  end
end