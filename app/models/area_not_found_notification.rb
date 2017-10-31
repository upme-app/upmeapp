class AreaNotFoundNotification < ApplicationRecord
  belongs_to :area_de_interesse
  belongs_to :user
end
