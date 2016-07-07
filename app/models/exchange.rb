# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Exchange < ActiveRecord::Base
  has_many :currencies
  #you can change names if you don't like them

  def get_nbp_xml

  end

  def save_current_rates

  end
end
