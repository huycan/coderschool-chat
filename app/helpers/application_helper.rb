module ApplicationHelper
  def color_class_for flash_type
    { success: 'cyan white-text', error: 'red white-text', warning: 'alert-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "card #{color_class_for(msg_type)}") do
        concat(content_tag(:div, message, class: "card-content white-text") do
          concat message
        end)
      end)
      flash.clear
    end
    nil
  end

  def signed_in?
    !!@current_user
  end
end
