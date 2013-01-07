require 'mongoid'

class User
  include Mongoid::Document

  field :phone_number, type: String
  field :save_phone_number, type: Boolean

  def dispatch_sms(body)
    body = body.strip.downcase
    
    case body
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

  def delete_record!
    destroy
    "OK, we won't keep your number and we won't try to contact you. If you change your mind, you can start over by answering the question again."  
  end
end
