class MoneyController < ApplicationController
  before_action :authenticate_user!
  before_action :set_currencies
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
    #generate a report for selected currency
    #report should show: basic statistics: mean, median, average
    #also You can generate a simple chart(use can use some js library)

    #this method should be available only for currencies which exist in the database 
  end

  private 

  def set_currencies
    @currencies ||= Currency.all.pluck(:name).uniq
  end


end
