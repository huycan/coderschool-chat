class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_signed_in, only: [:new, :create]

  def index
    @users = @current_user.users_to_add_friend
  end

  def add_friend
    friend = User.find params[:friend_id]
    @current_user.add_friend! friend

    redirect_to friends_user_path(@current_user.id)
  end

  def delete_friend
    @current_user.delete_friend! User.find params[:friend_id]

    redirect_to friends_user_path(@current_user.id)
  end

  def block_friend
    @current_user.block_friend! User.find params[:friend_id]
    
    redirect_to friends_user_path(@current_user.id)
  end

  def unblock_friend
    @current_user.unblock_friend! User.find params[:friend_id]

    redirect_to friends_user_path(@current_user.id)
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