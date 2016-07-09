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
  has_many :currencies
  #you can change names if you don't like them

  def get_nbp_xml

  end

  def save_current_rates

  end

  def trading_date
    self.read_attribute(:trading_date).strftime('%Y-%m-%d')
  end

  def effective_date
    self.read_attribute(:effective_date).strftime('%Y-%m-%d')
  end

end
