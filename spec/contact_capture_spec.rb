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
    %w(phil@darnowsky.com Joe@hotmail.com clara@yahoo.co.uk).each do |email|
      it "should remember the email \"#{email}\"" do
        mo_sms(email, "+16175551212")
        last_response.content_type.should == 'text/plain'
        last_response.body.should == "OK, great! We'll remember your email and will be in touch. You'll get a confirmation email from us shortly."
        User.where(:phone_number => "+16175551212", :email => email.downcase).count.should == 1
      end

      it "should send a confirmation email to \"#{email}\"" do
        mo_sms(email, "+16175551212")
        ActionMailer::Base.deliveries.should have(1).email
        
        mail = ActionMailer::Base.deliveries.first
        mail.to.should == [email.downcase]

        # proper subject & body
        mail.subject.should == "Confirmation from RobotDoesGood"
        mail.to_s.should include("This is your confirmation email from RobotDoesGood.")
      end
    end
  end

  context "when the user declines a capture" do
    %w(no NO nO).each do |dissent|
      context "by texting in \"#{dissent}\"" do
        it "should do that" do
          mo_sms dissent, '+16175551212'
          last_response.content_type.should == 'text/plain'
          last_response.body.should == "OK, we won't keep your number and we won't try to contact you. If you change your mind, you can start over by answering the question again."
          User.where(:phone_number => "+16175551212").should be_empty
        end
      end
    end
  end

  context "when the user texts in nonsense" do
    it "should respond appropriately"
  end
end
