class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new user_params

    respond_to do |format|
      if @food_item.save
        redirect_to new_session_path
        flash[:success] = 'You have signed up successfully.'
      else
        flash.now[:error] = 'You have failed to sign up.'
        render 'new'
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation
  end
end