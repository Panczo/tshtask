class ExchangeMailer < ApplicationMailer
  def exchange_created(user, exchange)
    @user = user
    @exchange = exchange
    mail(to: @user.email, subject: 'Check last exchange.')
  end
end
