class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, :set_current_user, :redirect_if_signed_in

  def signed_in?
    !!@current_user
  end

  private
  def set_current_user
    @current_user = !session[:user_id].nil? ? User.find(session[:user_id]) : nil
    return @current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this page"
      redirect_to new_session_path # halts request cycle
    end
  end

  def redirect_if_signed_in
    if signed_in?
      redirect_to user_messages_path session[:user_id]
    end
  end
end
