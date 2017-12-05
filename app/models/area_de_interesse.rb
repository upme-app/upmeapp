class AreaDeInteresse < ApplicationRecord
  
  has_many :project_area_de_interesse, dependent: :destroy
  has_many :user_area_de_interesse, dependent: :destroy
  validates :name, uniqueness: true

end
