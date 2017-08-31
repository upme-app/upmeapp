class AreaDeInteresse < ApplicationRecord

  validates :name, uniqueness: true

end
