require 'spec_helpers'

describe "response to multiple choice question via SMS" do
  include SpecHelpers

  it "should say something" do
    mo_sms "D"

    last_response.content_type.should == 'text/plain'
    last_response.body.should == "D) Less than $2. ($1.47 actually) Amazing right? Want to learn more about fighting hunger in MA? Txt us your email or \"YES\" for info by txt."
  end
end
