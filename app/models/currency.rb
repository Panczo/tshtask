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

class Currency < ActiveRecord::Base
  belongs_to :exchange
  scope :with_currency, ->(name) { where('name = ?', name) }
end
