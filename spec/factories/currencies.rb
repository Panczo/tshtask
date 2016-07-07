# == Schema Information
#
# Table name: currencies
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  converter   :integer
#  code        :string(255)
#  buy_price   :float
#  sell_price  :float
#  exchange_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :currency do
    name "MyString"
    converter 1
    code "MyString"
    buy_price 1.5
    sell_price 1.5
    exchange nil
  end
end
