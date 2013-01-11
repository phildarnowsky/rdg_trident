$: << '.'

require 'mongoid'
require 'mailer'

class User
  include Mongoid::Document

  EMAIL_PATTERN = /^.*@.*$/ # ghetto email recognition

  field :phone_number, type: String
  field :email, type: String
  field :save_phone_number, type: Boolean

  def dispatch_sms(body)
    body = body.strip.downcase
    
    case body
    when EMAIL_PATTERN
      save_email!(body)
    when 'yes'
      save_phone_number!
    when 'no'
      delete_record!
    end
  end

  protected

  def save_phone_number!
    update_attributes(save_phone_number: true)
    "OK, great! We'll remember your number and will be in touch."
  end

  def save_email!(new_email)
    update_attributes(email: new_email)
    send_confirmation_email(new_email)
    "OK, great! We'll remember your email and will be in touch. You'll get a confirmation email from us shortly."
  end

  def delete_record!
    destroy
    "OK, we won't keep your number and we won't try to contact you. If you change your mind, you can start over by answering the question again."  
  end

  def send_confirmation_email(to)
    Mailer.email_capture_confirmation_email(to).deliver
  end
end
