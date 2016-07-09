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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exchange do
    name "MyString"
  end
end
