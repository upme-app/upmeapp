class LandingPageMailer < ApplicationMailer

  default from: 'contato@upmeapp.com.br'

  def welcome_email(email)
    @email = email
    mail(to: email, subject: 'Bem vindo a UpMe!')
  end

end
