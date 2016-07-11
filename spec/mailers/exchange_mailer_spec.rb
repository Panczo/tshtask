require "rails_helper"

RSpec.describe ExchangeMailer, type: :mailer do
  describe "exchange notify" do
    user = FactoryGirl.create(:user, email: 'janko.muzykant@google.com')
    exchange = FactoryGirl.create(:exchange)
    let(:mail) { ExchangeMailer.exchange_created(user, exchange) }

    it "renders the headers" do
      expect(mail.subject).to eq('Check last exchange.')
      expect(mail.to).to eq(['janko.muzykant@google.com'])
      expect(mail.from).to eq(['tpanek.tshtask@gmail.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("I want to inform you that new exchange (C1) was created!")
    end
  end
end
