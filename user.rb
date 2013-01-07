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
    end
  end

  protected

  def save_phone_number!
    update_attributes(save_phone_number: true)
    "OK, great! We'll remember your number and will be in touch."
  end
end
