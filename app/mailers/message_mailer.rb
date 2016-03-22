class MessageMailer < ApplicationMailer
  def notify_new_message receiver_name, receiver_email, message_url
    @name = receiver_name
    @url = message_url

    mail to: receiver_email, subject: 'You receive a new message'
  end

  def notify_read_message sender_name, sender_email, read_at
    @name = sender_name
    @time = read_at

    mail to: sender_email, subject: 'Your message is read'
  end
end
