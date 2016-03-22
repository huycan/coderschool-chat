class MessagesController < ApplicationController
  def index
    @messages = User.find(params[:user_id]).messages
  end

  def new
  end

  def create
  end

  def show
  end
  
  def sent
  end

  def read
  end
end