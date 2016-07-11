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

class Exchange < ActiveRecord::Base
  has_many :currencies, dependent: :destroy
  
  validates :name, :trading_date, :effective_date, presence: true 

  def get_nbp_json
    #download last exchange
    resp = HTTParty.get("http://api.nbp.pl/api/exchangerates/tables/c/?format=json")
    if resp.code == 200
      parsed_resp = resp.parsed_response[0]
      if Exchange.find_by(name: parsed_resp["no"])
        return 'The latest exchange: ' + parsed_resp["no"] + ' is on the list. '
      end
      save_current_rates(parsed_resp)
    else
      return resp.parsed_response
    end
  end

  def save_current_rates(parsed_resp)
    self.name = parsed_resp["no"]
    self.trading_date = parsed_resp["tradingDate"]
    self.effective_date = parsed_resp["effectiveDate"]
    parsed_resp["rates"].each do |rate|
      self.currencies << Currency.new(name: rate["currency"], code: rate["code"], buy_price: rate["bid"], sell_price: rate["ask"], trading_date: parsed_resp["tradingDate"], effective_date: parsed_resp["effectiveDate"])
    end
    return self
  end
end
