require 'test_helper'

class LandingPageMailerTest < ActionMailer::TestCase
  test "RAILS_ENV=development" do
    mail = LandingPageMailer.RAILS_ENV=development
    assert_equal "Rails env=development", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
