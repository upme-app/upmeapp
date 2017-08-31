class UserAreaDeInteresse < ApplicationRecord
  belongs_to :user
  belongs_to :area_de_interesse
end
