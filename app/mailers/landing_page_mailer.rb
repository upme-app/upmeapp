class LandingPageMailer < ApplicationMailer

  def welcome_email(email)
    @email = email
    mail(to: email, subject: 'Bem vindo a UpMe!')
  end

end
