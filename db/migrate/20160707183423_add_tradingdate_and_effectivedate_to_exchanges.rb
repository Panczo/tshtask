class AddTradingdateAndEffectivedateToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :trading_date, :datetime
    add_column :exchanges, :effective_date, :datetime 
  end
end
