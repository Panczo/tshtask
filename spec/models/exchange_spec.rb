# == Schema Information
#
# Table name: exchanges
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  trading_date   :string(255)
#  effective_date :string(255)
#

require 'spec_helper'

describe Exchange do
  pending "add some examples to (or delete) #{__FILE__}"
end
