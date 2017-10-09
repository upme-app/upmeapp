class ApplicationMailer < ActionMailer::Base

  default from: "UpMe! app<#{ENV['GMAIL_USERNAME']}>"
  layout 'mailer'

end
