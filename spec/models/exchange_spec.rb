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
  pending "add some examples to (or delete) #{__FILE__}"
end
