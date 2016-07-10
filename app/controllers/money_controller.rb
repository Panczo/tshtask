class MoneyController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    @exchanges = Exchange.all.order(effective_date: :desc)
  end

  def show
    @exchange = Exchange.find(params[:id])
  end

  def refresh_rates
    exchange = Exchange.new
    @resp = exchange.get_nbp_json
    if @resp.is_a?(Exchange) && @resp.save
      render :json => @resp
    else
      render :json => { :errors => @resp }, :status => 422
    end
  end

  def report
    @currency_name = params[:currency_name]
    @currency = Currency.where(name: @currency_name)
    @currency_bp = @currency.pluck(:buy_price)
    @currency_sp = @currency.pluck(:sell_price)
    @currency_chart_bp = @currency.pluck(:trading_date, :buy_price)
    @currency_chart_sp = @currency.pluck(:trading_date, :sell_price)
  end
end
