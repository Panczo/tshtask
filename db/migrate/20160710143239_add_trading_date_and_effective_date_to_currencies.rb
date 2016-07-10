class AddTradingDateAndEffectiveDateToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :trading_date, :datetime
    add_column :currencies, :effective_date, :datetime
  end
end
