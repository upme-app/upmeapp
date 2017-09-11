class ProjectInvitation < ApplicationRecord
  belongs_to :user_from
  belongs_to :user_to
  belongs_to :project
end
