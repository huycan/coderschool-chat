class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      return @user
    else
      return nil
    end
  end

  def signed_in?
    !!current_user
  end
end
