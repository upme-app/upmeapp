# Preview all emails at http://localhost:3000/rails/mailers/landing_page_mailer
class LandingPageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/landing_page_mailer/RAILS_ENV=development
  def RAILS_ENV=development
    LandingPageMailer.RAILS_ENV=development
  end

end
