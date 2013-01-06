$: << File.expand_path(__FILE__ + '/../..')
require 'trident'
require 'rspec'
require 'rack/test'

describe "response to multiple choice question via SMS" do
  include Rack::Test::Methods

  def app
    Trident.new
  end

  it "should say something" do
    get '/sms'
    last_response.body.should == "D) Less than $2. ($1.47 actually) Amazing right? Want to learn more about fighting hunger in MA? Txt us your email or \"YES\" for info by txt."
  end
end
