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

require 'rails_helper'

describe Currency do
  
  it 'is valid with name, code, buy price, sell_price' do
    currency = Currency.new(
      name: 'Euro',
      code: 'eur',
      buy_price: '3.39',
      sell_price: '4.23'
      )
    expect(currency).to be_valid
  end

  it 'is invalid without a name' do
    currency = Currency.new(
      name: nil,
      code: nil,
      buy_price: nil,
      sell_price: nil
      )
    currency.valid?
    expect(currency.errors[:name]).to include("can't be blank")
    expect(currency.errors[:code]).to include("can't be blank")
    expect(currency.errors[:sell_price]).to include("can't be blank")
    expect(currency.errors[:buy_price]).to include("can't be blank")
  end
end
