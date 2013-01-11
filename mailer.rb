require 'mail_config'

class Mailer < ActionMailer::Base
  default :from => 'noreply@robotdoesgood.org'

  def email_capture_confirmation_email(to)
    mail(:to      => to,
         :subject => "Confirmation from RobotDoesGood"
    ) do |format|
      format.text
      format.html
    end
  end
end
