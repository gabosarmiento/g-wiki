class NotificationsMailer < ActionMailer::Base
   default :from => "noreply@g-wiki.herokuapp.com"
  default :to => ENV['GMAIL_USERNAME']

  def new_message(message)
    @message = message
    mail(:subject => "G-Wiki #{message.subject}")
  end

end
