class AreaDeInteresse < ApplicationRecord
  
  has_many :project_area_de_interesse, dependent: :nullify
  has_many :user_area_de_interesse, dependent: :nullify
  validates :name, uniqueness: true

end
