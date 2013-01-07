require 'spec_helpers'

describe "capturing a contact after an answer" do
  include SpecHelpers

  before do
    mo_sms 'C', '+16175551212' # user answers question off of collateral
  end

  context "when the user wants their phone number captured" do
    %w(yes YES yEs).each do |assent|
      context "and they send in \"#{assent}\"" do
        it "should capture the phone number" do
          mo_sms(assent, "+16175551212")
          last_response.content_type.should == 'text/plain'
          last_response.body.should == "OK, great! We'll remember your number and will be in touch."
          User.where(:phone_number => "+16175551212", :save_phone_number => true).count.should == 1
        end
      end
    end
  end

  context "when the user wants their email captured" do
    it "should do that"
  end

  context "when the user declines a capture" do
    it "should do that"
  end
end
