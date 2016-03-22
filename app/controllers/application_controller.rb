class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user, :require_login

  private
  def set_current_user
    @current_user = !!session[:user_id] ? User.find_by(id: session[:user_id]) : nil
    return @current_user
  end

  def require_login
    unless signed_in?
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
