# Preview all emails at http://localhost:3000/rails/mailers/exchange_mailer
class ExchangeMailerPreview < ActionMailer::Preview
  def exchange_mail_preview
    ExchangeMailer.exchange_created(User.first, Exchange.first)
  end
end
