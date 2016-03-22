class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :read]
  before_action :set_messages_for_user, only: [:index, :sent]

  def index
  end

  def new
    MessageMailer.notify_new_message(@message, read_user_message_path(@current_user.id, @message.id)).deliver_now
  end

  def create
  end
  
  def sent    
  end

  def read
    render 'show'

    if !!@message && @message.receiver_id == @current_user.id
      @message.read_at_utc Time.now.utc
      @message.save

      MessageMailer.notify_read_message(@message).deliver_now
    else
      flash[:error] = 'You are not the receiver of this message!'
      redirect_to root_path
    end
  end

  private
  def set_message
    @message = Message.find params[:id] if params[:id].present?
  end

  def set_messages_for_user
    @messages = User.find(params[:user_id]).messages
  end
end