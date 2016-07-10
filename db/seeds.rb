require 'httparty' 

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name

#Seed last 93 exchange rates from nbp
p 'LAST 93 EXCHANGE RATES'
first_day = (Date.today - 93).strftime('%Y-%m-%d')
yesterday = (Date.today - 1).strftime('%Y-%m-%d')
resp = HTTParty.get("http://api.nbp.pl/api/exchangerates/tables/c/#{first_day}/#{yesterday}/?format=json")
resp.parsed_response.each do |exchange|
  ex = Exchange.create(name: exchange["no"], trading_date: exchange["tradingDate"],
   effective_date: exchange["effectiveDate"])
  
  p "Kursy walut na dzień: #{exchange["effectiveDate"]}"
  exchange["rates"].each do |kurs|
    ex.currencies.create(name: kurs["currency"], code: kurs["code"], buy_price: kurs["bid"], sell_price: kurs["ask"], trading_date: exchange["tradingDate"], effective_date: exchange["effectiveDate"])
  end
end
