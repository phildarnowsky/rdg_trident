require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.view_paths = File.join(File.dirname(__FILE__), "mail_templates")

if %w(staging production).include? ENV['RACK_ENV']
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'robotdoesgood.org'
  }

  ActionMailer::Base.delivery_method = :smtp

else
  ActionMailer::Base.delivery_method = :test
end
