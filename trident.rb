$: << '.'

require 'sinatra'
require 'mongoid'
require 'user'
require 'mail_config'

class Trident < Sinatra::Base
  Mongoid.load!('mongoid.yml')

  set :show_exceptions, false
  set :raise_errors, true

  post '/sms' do
    dispatch_sms(params)
  end

  protected
   
  def dispatch_sms(params)
    headers 'Content-Type' => 'text/plain'

    user = User.where(phone_number: params['From']).first

    if user
      user.dispatch_sms(params['Body'])
    else
      User.create!(phone_number: params['From'])
      "D) Less than $2. ($1.47 actually) Amazing right? Want to learn more about fighting hunger in MA? Txt us your email or \"YES\" for info by txt."
    end
  end
end
