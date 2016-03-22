class MessageMailer < ApplicationMailer
  def notify_new_message message, message_url
    @name = message.receiver.name
    @url = message_url

    mail to: message.receiver.email, subject: 'You receive a new message'
  end

  def notify_read_message message, message_url
    @name = message.sender.name
    @time = message.read_at

    mail to: message.sender.email, subject: 'Your message is read'
  end
end
