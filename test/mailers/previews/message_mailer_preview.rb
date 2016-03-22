# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def notify_new_message_preview
    MessageMailer.notify_new_message 'huy', 'abc@xyz.com' 'www.google.com'
  end

  def notify_read_message_preview
    MessageMailer.notify_read_message 'huy', 'abc@xyz.com', DateTime.now
  end
end
