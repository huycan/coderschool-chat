class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :read]
  before_action :set_messages_for_user, only: [:index, :sent]

  def index
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

  def set_messages_for_user
    @messages = User.find(params[:user_id]).messages
  end
end