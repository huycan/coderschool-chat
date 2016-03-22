class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :read]

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
    render 'show'
    @message.read_at_utc Time.now.utc
    @message.save
  end

  private
  def set_message
    @message = Message.find params[:id] if params[:id].present?
  end
end