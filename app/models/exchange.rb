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
  #you can change names if you don't like them
  
  def get_nbp_json
    #download last exchange
    resp = HTTParty.get("http://api.nbp.pl/api/exchangerates/tables/c/?format=json")
    parsed_resp = resp.parsed_response
    
    #if there isn't any new exchange
    if parsed_resp.include? "404 NotFound" || "400 Bad Request" 
      return "Something went wrong"
    #if exchange exist
    elsif Exchange.find_by(name: parsed_resp[0]["no"])
      return 'The latest exchange: ' + parsed_resp[0]["no"] + ' is on the list. '
    else
      save_current_rates(parsed_resp[0])
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

  def trading_date
    self.read_attribute(:trading_date).strftime('%Y-%m-%d')
  end

  def effective_date
    self.read_attribute(:effective_date).strftime('%Y-%m-%d')
  end

end
