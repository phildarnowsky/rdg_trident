$: << File.expand_path(__FILE__ + '/../..')
require 'trident'
require 'rspec'
require 'rack/test'
require 'debugger'

module SpecHelpers
  RSpec.configure do |config|
    config.before do
      User.delete_all

      ActionMailer::Base.deliveries.clear
    end
  end

  include Rack::Test::Methods
  
  def app
    Trident.new
  end

  def mo_sms(body, from="+14155551212")
    post "/sms", 'From' => from, 'Body' => body
  end
end
