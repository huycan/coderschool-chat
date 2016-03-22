class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :read]

  def index
    @messages = User.find(params[:user_id]).messages
  end

  def new    
  end

  def create
    @message = Message.create(message_params)
    @current_user.send_messages! @message
    receiver = User.find params[:message][:receiver_id]
    MessageMailer.notify_new_message(
      receiver.name, receiver.email, read_user_message_path(receiver, @message.id)
    ).deliver_now
    
    redirect_to sent_user_messages_path(@current_user.id)
  end
  
  def sent
    @messages = User.find(params[:user_id]).ordered_sent_messages
  end

  def read
    render 'show'

    if !!@message && @message.receiver_id == @current_user.id
      @message.read_at_utc Time.now.utc
      @message.save

      MessageMailer.notify_read_message(@current_user.name, @current_user.email, @message.read_at).deliver_now
    else
      flash[:error] = 'You are not the receiver of this message!'
      redirect_to root_path
    end
  end

  private
  def set_message
    @message = Message.find params[:id] if params[:id].present?
  end

  def message_params
    params.require(:message).permit(:content, :receiver_id)
  end
end