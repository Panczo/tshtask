# == Schema Information
#
# Table name: exchanges
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  trading_date   :datetime
#  effective_date :datetime
#

require 'rails_helper'

describe Exchange do
  let(:exchange) { Exchange.new }
  
  describe 'exchange' do
    it 'parse exchange with currencies' do
      VCR.use_cassette('get_last_exchange') do
        resp = exchange.get_nbp_json
        expect(resp.class).to eq(Exchange)
        expect(resp.name).to eq("132/C/NBP/2016")
        expect(resp.currencies).not_to be_empty
        expect(resp.currencies.first.code).to eq("USD")
      end
    end

    it 'its on the list' do
      new_exchange = Exchange.new
      VCR.use_cassette('get_last_exchange') do
        resp = exchange.get_nbp_json
        expect(resp.class).to eq(Exchange)
        
        resp.save!
        VCR.use_cassette('exchange already exists') do
          second_resp = new_exchange.get_nbp_json
          expect(second_resp).not_to eq(Exchange)
          expect(second_resp.class).to eq(String)
          expect(second_resp).to eq('The latest exchange: 132/C/NBP/2016 is on the list. ')
        end
      end
    end
    it 'returns error', pending: true do
       VCR.use_cassette('returns error') do
        resp = exchange.get_nbp_json

        expect(resp.class).not_to eq(Exchange)
        expect(resp.class).to eq(String)
        expect(resp).to eq("Something went wrong. Please try letter")
      end
    end
  end
end
