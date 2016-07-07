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

require 'spec_helper'

describe Currency do
  pending "add some examples to (or delete) #{__FILE__}"
end
