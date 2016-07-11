require 'rails_helper'

describe MoneyController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end

    it "render index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should order currencies" do
      e1 = FactoryGirl.create(:exchange, effective_date: '2016-01-02')
      e2 = FactoryGirl.create(:exchange, effective_date: '2016-01-01')
      e3 = FactoryGirl.create(:exchange, effective_date: '2016-01-03')
      get :index
      expect(assigns(:exchanges).first).to eq(e3)
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      exchange = FactoryGirl.create(:exchange)
      get :show, id: exchange
      response.should be_success
    end

    it "render show template" do
      exchange = FactoryGirl.create(:exchange)
      get :show, id: exchange
      expect(response).to render_template(:show)
    end

    it 'return the requested exchange to @exchange' do
      exchange = FactoryGirl.create(:exchange)
      get :show, id: exchange
      expect(assigns(:exchange)).to eq exchange
    end
  end

  describe "GET 'report'" do
    it "should be successful" do
      get 'report', currency_name: 'euro'
      response.should be_success
    end
  end

  it "render report template" do
    get 'report', currency_name: 'euro'
    expect(response).to render_template(:report)
  end

  it 'return the requested currency' do
    euro = FactoryGirl.create(:currency, name: 'euro')
    get 'report', currency_name: 'euro'
    expect(assigns(:currency)).to include euro
  end
end
