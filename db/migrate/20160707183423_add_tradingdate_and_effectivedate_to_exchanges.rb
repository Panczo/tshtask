class AddTradingdateAndEffectivedateToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :trading_date, :string 
    add_column :exchanges, :effective_date, :string 
  end
end
