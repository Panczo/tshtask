class ExchangeWorker
  include Sidekiq::Worker
  
  def perform
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
      ex = Exchange.new(name: parsed_resp[0]["no"], trading_date: parsed_resp[0]["tradingDate"],
       effective_date: parsed_resp[0]["effectiveDate"])
      
      parsed_resp[0]["rates"].each do |rate|
        ex.currencies << Currency.new(name: rate["currency"], code: rate["code"], buy_price: rate["bid"], sell_price: rate["ask"], trading_date: parsed_resp[0]["tradingDate"], effective_date: parsed_resp[0]["effectiveDate"])
      end
      ex.save!
    end
  end
end
