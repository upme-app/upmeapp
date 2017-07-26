class LandingQuiz < ApplicationRecord

  validates :email, uniqueness: true

end
